# 🌊 下一秒想去看海

## 🔗 Website

https://angzeli.github.io/next-second-sea/

## 📚 About

A quiet personal writing archive built with Jekyll and GitHub Pages.

This site collects short fiction, essays, fragments, and reflective notes in Traditional Chinese. It is designed to feel like a small literary magazine: warm paper, quiet city nights, low battery, restrained future life, serif typography, and minimal interface.

## 🧭 Content Philosophy

This is a quiet writing archive. It is not a diary, documentation site, social feed, dashboard, or tech blog.

The site exists to preserve short fiction, essays, fragments, and observations that might otherwise disappear inside chat boxes, notes apps, or unfinished drafts. Technical work can live elsewhere; this archive should remain calm, literary, and separate from repository noise.

## 🎨 Design Philosophy

The visual language is built around warm paper, night-blue ink, copper accents, wide spacing, and serif typography. The site should feel like a personal magazine or small archive rather than a default GitHub Pages theme.

The implementation avoids Bootstrap, Tailwind, analytics, comments, search, tag clouds, badges, and heavy JavaScript. Most of the experience should come from typography, rhythm, and careful spacing.

## 🛠 Maintenance

Setup, post authoring, category mapping, repository structure, and deployment notes live in [HOW_TO.md](HOW_TO.md).

For long Chinese titles, use `title_lines` to control visual line breaks on the post page:

```yaml
title: 不可能宇宙裡飄散的微粒
title_lines:
  - 不可能宇宙裡
  - 飄散的微粒
```

The normal `title` is still used for listings and metadata.
