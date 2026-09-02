# 发现与决策

## 需求
- 用户决定从当前 VitePress 切换为 Hexo，并希望使用接近 `leager-zju.github.io` 的 Matery 主题。
- 旧项目位于 `E:\LcyLab`，新项目暂存于 `E:\LcyLabHexo`。
- 旧项目必须保留，不能直接删除或覆盖。

## 研究发现
- 当前 `E:\LcyLab` 是 VitePress 项目，包含 `.vitepress/config.mts`、`.vitepress/theme/` 和 Markdown 笔记。
- 本机已安装 Node.js `v24.14.0`、npm `11.9.0`、Git `2.52.0.windows.1`。
- Hexo 官方初始化结构包含 `_config.yml`、`source/_posts`、`scaffolds` 和 `themes`。
- Hexo 官方 GitHub Pages 文档支持 GitHub Actions，构建产物目录为 `public/`。
- Matery 是独立的 Hexo 主题，主题目录需要放在 `themes/matery`，根配置需要设置 `theme: matery`。
- Hexo 官方初始化在当前环境生成 Hexo `8.0.0` 依赖，安装后实际版本为 `8.1.2`；本机 Node `24.14.0` 可运行 `hexo version`。
- pnpm 11 默认阻止 `hexo-util` 构建脚本；使用 `pnpm approve-builds hexo-util` 后，`pnpm install --frozen-lockfile` 和 `pnpm exec hexo version` 均可用。
- Matery 默认包含音乐、访问统计、图库和示例项目/技能；本项目已关闭音乐、访问统计、百度推送和图库，替换了个人资料、项目和技能。

## 技术决策
| 决策 | 理由 |
|------|------|
| 先建立 `E:\LcyLabHexo` | 避免破坏现有 VitePress 项目，便于比较和回退 |
| 使用 Matery | 用户明确希望接近参考站点的 Hexo + Matery 方案 |
| 使用 GitHub Actions 部署 | 当前 Pages 已经切换到 Actions，避免生成文件和源文件混在同一分支 |
| 先不接入评论、统计、音乐 | 减少外部依赖，先验证基础构建和内容迁移 |

## 遇到的问题
| 问题 | 解决方案 |
|------|---------|
| 旧目录不是空目录，不能安全执行 Hexo 初始化 | 使用独立目录 `E:\LcyLabHexo` |
| `hexo init E:\HexoBootstrap` 自动安装依赖时提示失败 | 按 Hexo 输出改为在骨架目录单独执行 `npm install`，完成后再复制骨架 |
| `npm install` 在 `E:\HexoBootstrap` 超过 120 秒未结束 | 先检查安装产物和 npm 日志，再决定使用更长超时或调整依赖安装方式；不重复盲目执行 |

## 资源
- Hexo Setup: https://hexo.io/docs/setup
- Hexo Configuration: https://hexo.io/docs/configuration
- Hexo GitHub Pages: https://hexo.io/docs/github-pages
- Matery: https://github.com/blinkfox/hexo-theme-matery

## 视觉/浏览器发现
- 参考站点底部显示 `Powered by Hexo` 和 `Theme Matery`。
- Matery 提供 Banner、文章列表、归档时间线、分类和标签等博客组件。
- 本地首页已通过浏览器 DOM 检查：显示 `LCY Lab`、中文导航、个人简介、GitHub 按钮、5 篇文章卡片和自定义梦想文案；默认示例梦想文案和 QQ 号码均未进入生成页面。
- 复核时发现主题配置中误留重复 `qq` 键，已删除后重新构建通过。
- 为减少仓库体积，GitHub Actions 会在构建时克隆 Matery 上游主题，再覆盖 `theme-overrides/matery/_config.yml`；本地仍保留完整主题用于预览。

## 本次清理
- 已关闭 Matery 打赏、RSS、文章社交分享、转载声明和默认打字副标题。
- 已移除关于页、页脚作者链接以及默认个人资料、项目和技能展示。
- GitHub Actions 构建时会删除上游主题中的默认打赏二维码；线上二维码地址返回 404。
- 保留站点名称 `LCY Lab` 和真实 GitHub 关联 `https://github.com/LcyLab`。

## 2026-08-10 基础功能完善

- Matery 内置不蒜子统计已开启：页脚显示站点 PV/UV，文章页显示单篇 PV，首页概览同步显示访问量和访客数。
- 文章信息已开启发布日期、更新时间、字数和预计阅读时长；站点总字数也显示在页脚。
- 顶部和移动端菜单新增“学习笔记”，保留项目记录、分类、标签和归档入口。
- 首页概览显示文章、分类、标签和访问统计；两篇现有文章标记为推荐文章。
- 根配置补充 `search.xml` 生成配置，使 Matery 原有搜索对话框可以读取本地索引。
- `tools/validate-site-features.ps1` 提供可重复的静态页面检查，`pnpm run check:site` 已通过。
- 不蒜子属于外部统计服务；本地页面可以正常渲染，但服务不可达时统计数字可能保持加载状态，统计数据不应当作为严格审计数据。

## 2026-08-10 统计数据纠正

- 旧 Matery 集成使用 `busuanzi.ibruce.info` 旧脚本；在 `localhost` 预览时返回了明显异常的共享计数，因此不能把本地预览数字当成真实站点数据。
- 官方不蒜子说明 `localhost`、`127.0.0.1` 和 IPv6 本地地址不接入统计；当前实现已据此在本地隐藏统计，不再显示异常数字。
- 生产环境改用官方新版 `https://cdn.busuanzi.cc/busuanzi/3.6.9/busuanzi.min.js`，按浏览器当前页面 URL 统计，并通过兼容桥接填充 Matery 原有显示位置。
- 直接向官方 API 以 `https://lcylab.github.io/` 作为 URL 测试，返回 `site_pv=1`、`site_uv=1`、`page_pv=1`、`page_uv=1`，未再出现 8000 多万的本地异常数字。
- 该方案是真实访问计数服务的公开展示，不等同于审计级日志；若需要访问来源、地域、设备和趋势分析，后续应另接 Cloudflare Web Analytics 或 Umami。

## 2026-08-31 文章图片与公式兼容性

- Typora 打开本地 Markdown 时不能解析网页根路径 `/images/...`，因此文章图片改为相对路径 `picture/*.svg`。
- 文章目录 `source/_drafts/计算几何基础/01 点积 叉积与法向量/` 内只保留一个 Markdown 文件和一个 `picture/` 资源目录，Typora 直接使用目录内的相对图片路径。
- `script type="math/tex; mode=display"` 是 MathJax 2 的旧兼容写法，Typora 会把它当普通 HTML 展示；文章现已统一使用标准 `$$...$$` 公式块，并通过 `\_` 防止 Markdown 误解析下标。
- Hexo 使用 `scripts/copy-article-pictures.js` 在构建后将文章目录下的 `picture/` 复制到对应页面目录，生成页面中的图片路径与文章资源目录一致。
