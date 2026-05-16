---
title: 文字存檔
subtitle: 按時間收起來的一些文字。未必完整，但先保存。
permalink: /writing/
---

<div class="category-filter" aria-label="分類">
  {% for category in site.data.categories %}
    <a href="{{ category.url | relative_url }}">{{ category.name }}</a>
  {% endfor %}
</div>

{% assign posts_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in posts_by_year %}
  <section class="archive-year" aria-labelledby="year-{{ year.name }}">
    <h2 id="year-{{ year.name }}">{{ year.name }}</h2>
    <div class="archive-list">
      {% for post in year.items %}
        <article class="archive-item">
          <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%m.%d" }}</time>
          <div>
            <div class="post-meta">
              {% include category-link.html category=post.category %}
            </div>
            <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
            {% if post.excerpt %}
              <p>{{ post.excerpt | strip_html }}</p>
            {% endif %}
          </div>
        </article>
      {% endfor %}
    </div>
  </section>
{% endfor %}
