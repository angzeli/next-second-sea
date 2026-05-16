#!/usr/bin/env ruby

require "date"
require "set"
require "yaml"

ROOT = File.expand_path("..", __dir__)

def front_matter(path)
  text = File.read(path)
  match = text.match(/\A---\s*\n(.*?)\n---\s*\n/m)
  raise "missing YAML front matter" unless match

  YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: true) || {}
end

def relative(path)
  path.sub("#{ROOT}/", "")
end

errors = []

categories_path = File.join(ROOT, "_data/categories.yml")
categories = YAML.safe_load(File.read(categories_path)) || []
category_names = Set.new
category_urls = Set.new

categories.each_with_index do |category, index|
  label = "_data/categories.yml item #{index + 1}"

  %w[name slug url].each do |key|
    errors << "#{label} is missing `#{key}`" if category[key].to_s.strip.empty?
  end

  name = category["name"]
  url = category["url"]

  errors << "#{label} has duplicate name `#{name}`" if name && category_names.include?(name)
  errors << "#{label} has duplicate url `#{url}`" if url && category_urls.include?(url)
  errors << "#{label} url must start and end with `/`: #{url}" if url && !url.match?(%r{\A/.+/\z})

  category_names << name if name
  category_urls << url if url
end

category_pages = {}
Dir[File.join(ROOT, "categories/*/index.md")].sort.each do |path|
  data = front_matter(path)
  category_name = data["category_name"]
  permalink = data["permalink"]

  errors << "#{relative(path)} is missing `category_name`" if category_name.to_s.strip.empty?
  errors << "#{relative(path)} is missing `permalink`" if permalink.to_s.strip.empty?

  if category_name
    errors << "Duplicate category page for `#{category_name}`" if category_pages.key?(category_name)
    category_pages[category_name] = { path: path, permalink: permalink }
  end
end

categories.each do |category|
  name = category["name"]
  next unless name

  page = category_pages[name]
  if page.nil?
    errors << "Category `#{name}` is in _data/categories.yml but has no category page"
  elsif page[:permalink] != category["url"]
    errors << "Category `#{name}` url mismatch: data has `#{category["url"]}`, page has `#{page[:permalink]}`"
  end
end

category_pages.each do |name, page|
  errors << "#{relative(page[:path])} has category_name `#{name}` but _data/categories.yml does not include it" unless category_names.include?(name)
end

Dir[File.join(ROOT, "_posts/*.md")].sort.each do |path|
  data = front_matter(path)
  file = relative(path)
  filename_date = File.basename(path)[/\A\d{4}-\d{2}-\d{2}/]

  errors << "#{file} must use `category`, not `categories`" if data.key?("categories")

  %w[title date category].each do |key|
    errors << "#{file} is missing `#{key}`" if data[key].to_s.strip.empty?
  end

  date = data["date"]
  date_string =
    case date
    when Date, Time
      date.strftime("%Y-%m-%d")
    else
      date.to_s
    end

  errors << "#{file} filename date `#{filename_date}` does not match front matter date `#{date_string}`" if filename_date && date_string != filename_date

  category = data["category"]
  errors << "#{file} uses unknown category `#{category}`" if category && !category_names.include?(category)

  tags = data["tags"]
  if data.key?("tags")
    if !tags.is_a?(Array)
      errors << "#{file} `tags` must be a YAML array"
    else
      tags.each do |tag|
        errors << "#{file} tag `#{tag}` must be a string" unless tag.is_a?(String)
        errors << "#{file} tag `#{tag}` looks comma-joined; split it into separate YAML array items" if tag.is_a?(String) && tag.match?(/[，,]/)
      end
    end
  end
end

if errors.empty?
  puts "Site validation passed."
else
  warn "Site validation failed:"
  errors.each { |error| warn "  - #{error}" }
  exit 1
end
