# Redefine Theme Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Migrate LCY Lab from Matery to Redefine while preserving Hexo content, categories, tags, formulas, images, search, privacy choices, real counters, and GitHub Pages deployment.

**Architecture:** Keep all site content in `source/`. Install Redefine as the pinned npm dependency `hexo-theme-redefine@2.9.0`, store site-specific settings in `_config.redefine.yml`, and set the root theme to `redefine`. Remove Matery-only build overrides from the deployment workflow; retain them locally until the Redefine preview is accepted so the root theme can be reverted safely.

**Tech Stack:** Hexo 8.1.2, Redefine 2.9.0, pnpm, Markdown, MathJax, Mermaid, hexo-generator-searchdb, GitHub Actions, GitHub Pages.

---

### Task 1: Add Redefine and preserve a reversible theme boundary

**Files:**
- Modify: `E:/LcyLabHexo/package.json`
- Modify: `E:/LcyLabHexo/pnpm-lock.yaml`
- Modify: `E:/LcyLabHexo/_config.yml`
- Create: `E:/LcyLabHexo/_config.redefine.yml`

- [x] **Step 1: Add the pinned Redefine dependency**

Run from `E:\LcyLabHexo`:

```powershell
pnpm add hexo-theme-redefine@2.9.0
```

Expected: `package.json` contains `hexo-theme-redefine: 2.9.0`, and `pnpm-lock.yaml` is updated without changing the existing Hexo version.

- [x] **Step 2: Switch the root theme and create the site-level configuration**

Change `_config.yml`:

```yaml
theme: redefine
```

Create `_config.redefine.yml` with the following site-owned values; the exact option names are Redefine 2.x names:

```yaml
info:
  title: LCY Lab
  subtitle: 电磁仿真、计算几何、C++、Qt 与 OpenCascade 学习记录
  author: LcyLab
  url: https://lcylab.github.io

defaults:
  logo: /images/logo.svg
  favicon: /images/favicon.svg

navbar:
  links:
    首页:
      path: /
      icon: fa-solid fa-house
    学习笔记:
      path: /notes/
      icon: fa-solid fa-book-open
    分类:
      path: /categories/
      icon: fa-solid fa-folder
    标签:
      path: /tags/
      icon: fa-solid fa-tags
    归档:
      path: /archives/
      icon: fa-solid fa-box-archive
    项目记录:
      path: /projects/
      icon: fa-solid fa-code-branch
    GitHub:
      path: https://github.com/LcyLab
      icon: github

home_banner:
  enable: true
  style: fixed
  title: LCY Lab
  subtitle:
    text:
      - 技术学习与研究笔记
      - 电磁仿真 · 计算几何 · C++ · Qt
    hitokoto:
      enable: false
  social_links:
    enable: false

global:
  single_page: true
  open_graph: true
  preloader:
    enable: false
  side_tools:
    gear_rotation: false
    auto_expand: false
  website_counter:
    enable: true
    site_pv: true
    site_uv: true
    post_pv: true

search:
  enable: true
  preload: true

page_templates:
  tags_style: blur

post:
  mathjax:
    enable: true
  toc:
    enable: true

footer:
  social:
    enable: false
```

- [x] **Step 3: Check the installed Redefine default config before preserving any option**

Run:

```powershell
rg -n "^(info|defaults|navbar|home_banner|global|search|page_templates|post|footer):|website_counter|mathjax|toc" node_modules/hexo-theme-redefine/_config.yml
```

Expected: every option used in `_config.redefine.yml` exists in the installed Redefine config. If a section name differs, update only `_config.redefine.yml`; do not edit `node_modules/hexo-theme-redefine`.

### Task 2: Adapt pages and the first article to Redefine templates

**Files:**
- Modify: `E:/LcyLabHexo/source/categories/index.md`
- Modify: `E:/LcyLabHexo/source/tags/index.md`
- Modify: `E:/LcyLabHexo/source/notes/index.md`
- Modify: `E:/LcyLabHexo/source/projects/index.md`
- Modify: `E:/LcyLabHexo/source/archives/index.md`
- Modify: `E:/LcyLabHexo/source/_drafts/计算几何基础/01 点积 叉积与法向量/01 点积 叉积与法向量.md`

- [x] **Step 1: Use Redefine page templates**

Set the categories page front matter to:

```yaml
---
title: 分类
date: 2026-08-04 20:00:00
template: categories
---
```

Set the tags page front matter to:

```yaml
---
title: 标签
date: 2026-08-04 20:00:00
template: tags
---
```

Keep the note and project page bodies, but use `layout: page` only if Redefine’s installed config confirms that `page` is the page layout name. Keep the archive page as `layout: archive` only if the installed theme exposes that layout; otherwise use its documented archive template.

- [x] **Step 2: Check first-article front matter and image paths**

The first article remains at:

```text
source/_drafts/计算几何基础/01 点积 叉积与法向量/01 点积 叉积与法向量.md
```

Its image references remain local and relative:

```markdown
![点积的几何意义](picture/dot-product.svg)
```

Keep `mathjax: true`, the `permalink`, categories, tags, and all formula text. Do not reintroduce `<script type="math/tex; mode=display">`.

### Task 3: Replace Matery-specific deployment and asset handling

**Files:**
- Modify: `E:/LcyLabHexo/.github/workflows/pages.yml`
- Modify: `E:/LcyLabHexo/scripts/copy-article-pictures.js`
- Modify: `E:/LcyLabHexo/README.md`

- [x] **Step 1: Remove Matery cloning and override copying from Pages workflow**

Delete the `Fetch Matery theme` step. The workflow must install the pinned theme through `pnpm install --frozen-lockfile`, then run the existing Hexo build and Pages upload steps.

- [x] **Step 2: Keep the custom picture copier theme-agnostic**

Keep `scripts/copy-article-pictures.js` independent of Matery. It must copy an article folder’s sibling `picture/` directory to the article’s generated public path after generation, without changing Markdown image URLs.

- [x] **Step 3: Update README commands and theme instructions**

Replace Matery-specific instructions with:

```powershell
pnpm install
pnpm run server
```

Document `_config.redefine.yml` as the theme configuration source and state that `theme-overrides/matery/` is retained only as a rollback copy until migration acceptance.

### Task 4: Build and perform local visual/functional QA

**Files:**
- Modify if needed: `E:/LcyLabHexo/tools/validate-site-features.ps1`
- Modify if needed: `E:/LcyLabHexo/task_plan.md`
- Modify if needed: `E:/LcyLabHexo/progress.md`

- [x] **Step 1: Run the clean build**

```powershell
pnpm install --frozen-lockfile
pnpm exec hexo clean
pnpm run build
```

Expected: exit code 0, no Matery template errors, and generated pages include the homepage, categories, tags, archives, notes, projects, and existing articles.

- [x] **Step 2: Run the draft build**

```powershell
pnpm exec hexo generate --draft
```

Expected: the first article is generated at the configured permalink, all five `picture/*.svg` files are present beside the generated article, and the HTML contains MathJax rather than raw TeX or the legacy math script.

- [x] **Step 3: Start Redefine preview and inspect in the browser**

```powershell
pnpm run server -- --drafts --port 4177
```

Inspect these routes:

```text
http://localhost:4177/
http://localhost:4177/categories/
http://localhost:4177/tags/
http://localhost:4177/archives/
http://localhost:4177/notes/
http://localhost:4177/projects/
http://localhost:4177/计算几何基础/01-点积-叉积与法向量/
```

Expected: Redefine styling is visible; navigation, banner, categories, tags, search, formulas, image assets, article TOC, and dark mode work; no Matery-specific widgets or default personal/donation content appear.

- [x] **Step 4: Run the existing static feature check and update only theme-specific assertions**

```powershell
pnpm run check:site
```

Expected: the check passes after assertions are adjusted from Matery markers to Redefine markers. Do not weaken checks for article pages, privacy content, search output, formulas, or image existence.

### Task 5: Acceptance and optional publication

**Files:**
- No source changes unless QA finds a defect.

- [x] **Step 1: Compare Redefine preview against acceptance criteria**

Confirm that all existing content remains, the first article is readable, and the site no longer renders Matery-only UI.

- [x] **Step 2: Stop at local acceptance**

Leave GitHub and the live domain unchanged until the user explicitly asks to publish the Redefine version.

- [ ] **Step 3: If explicitly requested, publish intentionally**

Use the existing GitHub synchronization flow with an explicit file list including the root config, Redefine config, package files, workflow, scripts, source pages, first article, and its `picture/` assets. Verify the Actions run and live URL before reporting publication.
