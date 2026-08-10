# LCY Lab Website Basic Features Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 完善 LCY Lab 的访问统计、文章信息、导航和首页小部件，并验证 Hexo 静态输出。

**Architecture:** 保留 Hexo + Matery。将配置和 EJS 覆盖文件维护在 `theme-overrides/matery/`，本地主题目录用于预览，GitHub Actions 在构建时复制相同覆盖文件。统计使用主题内置的不蒜子脚本，不增加新的运行时依赖。

**Tech Stack:** Hexo 8、Matery、EJS、YAML、hexo-wordcount、hexo-generator-searchdb、pnpm、PowerShell。

---

### Task 1: 开启基础站点和文章功能

**Files:**
- Modify: `theme-overrides/matery/_config.yml`
- Modify: `themes/matery/_config.yml`
- Modify: `source/_posts/lcy-lab-site.md`
- Modify: `source/_posts/engineering-data-flow.md`

- [ ] **Step 1: 开启 Matery 已有功能开关**

在两个主题配置文件中保持对应值一致：

```yaml
postInfo:
  date: true
  update: true
  wordCount: true
  totalCount: true
  min2read: true
  readCount: true

busuanziStatistics:
  enable: true
  totalTraffic: true
  totalNumberOfvisitors: true

tcaptcha:
  enable: false
```

- [ ] **Step 2: 给首页推荐区域提供现有文章**

在 `lcy-lab-site.md` 和 `engineering-data-flow.md` 的 front matter 中加入：

```yaml
top: true
```

- [ ] **Step 3: 检查配置一致性**

运行：

```powershell
rg -n "postInfo:|update: true|wordCount: true|min2read: true|readCount: true|busuanziStatistics:|enable: true|tcaptcha:" theme-overrides/matery/_config.yml themes/matery/_config.yml
```

预期：两个配置文件都包含开启的文章信息和不蒜子配置，腾讯验证码配置为 `enable: false`。

### Task 2: 补齐菜单和首页概览小部件

**Files:**
- Modify: `theme-overrides/matery/_config.yml`
- Modify: `themes/matery/_config.yml`
- Create: `theme-overrides/matery/layout/_widget/site-stats.ejs`
- Create: `theme-overrides/matery/layout/index.ejs`
- Create: `theme-overrides/matery/source/css/my.css`
- Create: `themes/matery/layout/_widget/site-stats.ejs`
- Modify: `themes/matery/layout/index.ejs`
- Modify: `themes/matery/source/css/my.css`

- [ ] **Step 1: 添加学习笔记导航**

在 `menu` 中加入：

```yaml
  学习笔记:
    url: /notes
    icon: fas fa-book-open
```

- [ ] **Step 2: 创建站点概览 widget**

`site-stats.ejs` 输出文章、分类、标签、总访问量和访客数，并使用 `busuanzi_value_site_pv` 与 `busuanzi_value_site_uv` 标记等待统计脚本填充，不写入虚构数字。

- [ ] **Step 3: 在首页插入 widget**

复制当前 Matery `index.ejs` 到覆盖目录，在首页卡片中将站点概览放在 dream 文案之后、推荐文章之前；同步本地主题目录。

- [ ] **Step 4: 添加小部件样式**

在 `my.css` 中增加响应式概览卡样式，桌面端显示四列，窄屏自动换行；不覆盖现有主题颜色，只使用现有绿色主题变量效果。

- [ ] **Step 5: 更新 GitHub Actions 覆盖复制步骤**

在 `.github/workflows/pages.yml` 中复制 `index.ejs`、`site-stats.ejs` 和 `my.css` 到远程克隆的 Matery 目录，保证本地预览和线上构建使用同一套模板。

### Task 3: 构建和静态功能验证

**Files:**
- Create: `tools/validate-site-features.ps1`
- Modify: `package.json`
- Modify: `progress.md`
- Modify: `findings.md`
- Modify: `task_plan.md`

- [ ] **Step 1: 清理并构建**

运行：

```powershell
pnpm run clean
pnpm run build
```

预期：Hexo 退出码为 0。

- [ ] **Step 2: 检查关键输出**

确认以下文件存在：

```powershell
Test-Path public/index.html
Test-Path public/search.xml
Test-Path public/notes/index.html
Test-Path public/archives/index.html
Test-Path public/categories/index.html
Test-Path public/tags/index.html
Test-Path public/projects/index.html
```

预期：全部为 `True`。

- [ ] **Step 3: 检查页面标记和默认信息清理**

运行固定字符串检查：

```powershell
$home = Get-Content -Raw -Encoding UTF8 public/index.html
$post = Get-Content -Raw -Encoding UTF8 (Get-ChildItem public/2026/*/*/*.html | Select-Object -First 1)
Select-String -InputObject $home -Pattern 'site-stats','学习笔记','busuanzi_value_site_pv','busuanzi_value_site_uv','searchModal'
Select-String -InputObject $post -Pattern 'wordCount','readTimes','busuanzi_value_page_pv','calendar-check'
if ($home.Contains('xxxxxxxxxx')) { throw '发现腾讯验证码占位 appid' }
if ($home.Contains('reward/alipay') -or $home.Contains('reward/wechat')) { throw '发现打赏图片引用' }
```

预期：站点概览、导航、搜索、PV/UV 和文章信息标记存在，默认占位配置和打赏图片引用不存在。

- [ ] **Step 4: 将静态检查固定为项目命令**

运行：

```powershell
pnpm run check:site
```

预期：输出 `站点基础功能静态检查通过` 并退出码为 0。

- [ ] **Step 5: 更新项目记录**

在 `progress.md` 记录改动文件、构建命令和检查结果；在 `findings.md` 记录不蒜子统计依赖外部服务，若服务不可达，页面仍应正常显示但统计数字可能保持加载状态。

### Task 4: 交付前检查

**Files:**
- Modify: `task_plan.md`
- Modify: `progress.md`

- [ ] **Step 1: 重新读取计划和构建产物检查结果**

确认 Task 1–3 的每个完成标准都有对应命令输出。

- [ ] **Step 2: 给用户报告结果**

只报告已实际验证的构建和静态检查结果，并说明尚未执行的 GitHub 推送需要用户下一步确认。
