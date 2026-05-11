# 下一秒想去看海

A quiet personal writing archive built with Jekyll and GitHub Pages.

This site collects short fiction, essays, fragments, and reflective notes in Traditional Chinese. It is designed to feel like a small literary magazine: warm paper, quiet city nights, low battery, restrained future life, serif typography, and minimal interface.

## Local Run

Install dependencies:

```bash
bundle install
```

Run the local Jekyll server:

```bash
bundle exec jekyll serve
```

Then open the local URL printed by Jekyll, usually `http://127.0.0.1:4000/`.

## Add A Post

Create a Markdown file in `_posts` using this filename format:

```text
YYYY-MM-DD-title.md
```

Example:

```markdown
---
layout: post
title: "低電量回家"
date: 2026-05-10
category: 未來生活
tags: [微型小說, 未來, 城市]
excerpt: "2100 年的 9 月 3 日晚上 10 點，我結束了今天 18 小時的工作。"
---

文章內容從這裡開始。
```

Use `category` as a single primary category field. Do not use `categories` in v1.

## Categories

Category names are written in Traditional Chinese in post front matter. Public category URLs use English slugs.

The mapping lives in `_data/categories.yml`:

| Front matter `category` | Public URL |
| --- | --- |
| `未來生活` | `/categories/future-life/` |
| `城市與夜晚` | `/categories/city-and-night/` |
| `短句存檔` | `/categories/fragments/` |
| `實驗筆記` | `/categories/lab-notes/` |

When templates render a category link, they look up the matching item where `item.name == post.category`, then use `item.url` as the link and `item.name` as the visible label.

Category pages filter posts by the Traditional Chinese `category` value. The English slug is only the public permalink.

## Repository Structure

```text
.
├── _config.yml
├── index.html
├── about.md
├── writing.md
├── 404.html
├── _data/
│   └── categories.yml
├── _layouts/
│   ├── default.html
│   ├── home.html
│   ├── page.html
│   ├── post.html
│   └── category.html
├── _includes/
│   ├── head.html
│   ├── header.html
│   └── footer.html
├── _posts/
│   ├── 2026-05-10-low-battery.md
│   ├── 2026-05-11-fragments-from-may.md
│   └── 2026-05-12-why-this-archive-exists.md
├── categories/
│   ├── future-life/
│   ├── city-and-night/
│   ├── fragments/
│   └── lab-notes/
├── assets/
│   └── css/
│       └── style.css
├── README.md
└── Gemfile
```

## Content Philosophy

This is a quiet writing archive. It is not a diary, documentation site, social feed, dashboard, or tech blog.

The site exists to preserve short fiction, essays, fragments, and observations that might otherwise disappear inside chat boxes, notes apps, or unfinished drafts. Technical work can live elsewhere; this archive should remain calm, literary, and separate from repository noise.

## Design Philosophy

The visual language is built around warm paper, night-blue ink, copper accents, wide spacing, and serif typography. The site should feel like a personal magazine or small archive rather than a default GitHub Pages theme.

The implementation avoids Bootstrap, Tailwind, analytics, comments, search, tag clouds, badges, and heavy JavaScript. Most of the experience should come from typography, rhythm, and careful spacing.

## GitHub Pages Deployment

The site is GitHub Pages compatible and uses the `github-pages` gem.

To deploy:

1. Push the repository to GitHub.
2. In the repository settings, open Pages.
3. Choose the branch and folder GitHub Pages should publish from, usually the default branch root.
4. Save the settings and wait for the Pages build to complete.

The permalink structure for posts is:

```text
/writing/:year/:month/:day/:title/
```

This keeps post URLs separate from category URLs and avoids encoded Chinese category path segments.
