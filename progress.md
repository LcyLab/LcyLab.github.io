# 进度日志

## 会话：2026-08-04

### 阶段 1：需求与发现
- **状态：** complete
- 执行的操作：
  - 检查 `E:\LcyLab` Git 状态和项目结构。
  - 检查 Node.js、npm 和 Git 版本。
  - 阅读 Hexo 官方初始化、配置、主题和 GitHub Pages 文档。
  - 确认旧项目保持不变，新项目使用 `E:\LcyLabHexo`。
- 创建/修改的文件：
  - `docs/superpowers/specs/2026-08-04-hexo-matery-migration-design.md`
  - `docs/superpowers/plans/2026-08-04-hexo-matery-migration.md`
  - `findings.md`
  - `progress.md`

### 阶段 2：规划与结构
- **状态：** complete
- 执行的操作：
  - 创建 Hexo 目标目录和规划目录。
- 由于目标目录包含迁移记录，使用独立 `E:\HexoBootstrap` 运行 Hexo 官方初始化。
- Hexo 初始化骨架创建成功，但自动安装依赖提示失败，等待手动 `npm install` 验证。
- 创建/修改的文件：
  - `docs/superpowers/specs/`
  - `docs/superpowers/plans/`

### 阶段 3：实现
- **状态：** complete
- 已安装全局 `hexo-cli`。
- 使用 Hexo 官方骨架建立 `E:\HexoBootstrap`，验证 `hexo 8.1.2` 可运行。
- 已将骨架复制到 `E:\LcyLabHexo`，并克隆 `themes/matery`。
- 已完成根站点配置、Matery 个人资料/项目/技能配置和基础依赖安装。
- `pnpm install --no-frozen-lockfile` 成功完成，新增 Markdown、搜索和字数统计依赖。
- 已迁移 4 篇原有技术笔记，新增关于、项目、笔记、归档、分类和标签页面。
- 已加入 GitHub Actions 工作流 `\.github\workflows\pages.yml`，用于将 `public/` 部署到 GitHub Pages。

### 阶段 4：测试与验证
- **状态：** complete
- `pnpm run clean; pnpm run build` 退出码为 0，生成 179 个文件。
- 本地首页、归档、分类、标签、关于、项目、笔记及 2 篇文章路径均返回 HTTP 200。
- 首页 DOM 检查确认 Matery 导航、LCY Lab 标题、GitHub 链接、自定义文案和文章列表正常；未发现 VitePress 标记、默认示例梦想文案或默认 QQ 号码。
- 旧项目 `E:\LcyLab` 未被修改。

### 阶段 5：交付
- **状态：** complete
- 已将 Hexo 源文件同步到 `LcyLab/LcyLab.github.io` 的 `main` 分支。
- 提交：`3690981e609b8597260881f4ec80887b011e96a9`，消息为 `migrate site to Hexo Matery`。
- GitHub Actions 部署成功，线上页面已验证。

### 阶段 6：清理默认个人信息
- **状态：** complete
- 已关闭 Matery 打赏、RSS、社交分享和转载声明。
- 已移除关于页、默认个人资料/项目/技能展示，以及页脚和转载区域中的 `/about` 链接。
- GitHub Actions 构建时删除默认打赏二维码并覆盖页脚模板。
- 提交：`8baecae789ff9a7c480b985786a648d2b6cdaf30`。
- Actions：`30918758168`，结论为 `success`。
- 线上验证：首页/文章页/项目页为 HTTP 200；`/about/` 和两个打赏二维码地址为 HTTP 404。

## 测试结果
| 测试 | 输入 | 预期结果 | 实际结果 | 状态 |
|------|------|---------|---------|------|
| 旧项目状态 | `git -C E:\LcyLab status --short` | 无变更 | 无变更 | 通过 |
| 本机工具版本 | `node --version`, `npm --version`, `git --version` | 工具可用 | Node 24.14.0 / npm 11.9.0 / Git 2.52.0 | 通过 |
| Hexo 构建 | `pnpm run clean; pnpm run build` | 生成静态站点且退出码为 0 | 生成 179 个文件，退出码 0 | 通过 |
| 本地页面 | `Invoke-WebRequest http://127.0.0.1:4175/...` | 页面返回 200 | 9 个核心路径均返回 200 | 通过 |
| 首页内容 | 生成的 `public/index.html` 与浏览器 DOM | 站点配置和主题内容正确 | LCY Lab、Matery、GitHub、项目记录和文章列表均存在 | 通过 |
| GitHub 同步 | `LcyLab/LcyLab.github.io` main | 远程提交并触发 Pages 部署 | 提交 `3690981e609b8597260881f4ec80887b011e96a9`，Actions success | 通过 |
| 线上页面 | `https://lcylab.github.io/...` | 页面可访问并包含新站点内容 | 首页、归档、项目页、文章页均 HTTP 200 | 通过 |

## 错误日志
| 时间戳 | 错误 | 尝试次数 | 解决方案 |
|--------|------|---------|---------|
| 2026-08-04 | `hexo init` 自动依赖安装提示失败 | 1 | 单独执行 `npm install`，不重复初始化 |
| 2026-08-04 | `npm install` 超过 120 秒未结束 | 1 | 检查 `node_modules` 和 npm 日志后再调整方案 |
| 2026-08-04 | Matery 配置出现重复 `qq` 键，导致 YAML 解析失败 | 1 | 删除重复键后重新构建 |

## 五问重启检查
| 问题 | 答案 |
|------|------|
| 我在哪里？ | 阶段 2，目标目录已创建 |
| 我要去哪里？ | 完成 Hexo + Matery 初始化、迁移和本地验证 |
| 目标是什么？ | 建立可部署的 `E:\LcyLabHexo`，不修改 `E:\LcyLab` |
| 我学到了什么？ | 见 findings.md |
| 我做了什么？ | 见上方进度日志 |

## 会话：2026-08-10

### 阶段 1：基础功能设计与实现
- **状态：** complete
- 开启 Matery 不蒜子 PV/UV 统计、文章浏览量、字数、阅读时长、更新时间和站点总字数。
- 新增“学习笔记”顶部和移动端菜单入口。
- 为两篇已有文章增加推荐标记，恢复首页推荐文章区域的实际内容。
- 根站点配置增加 `search.xml`，修复 Matery 搜索对话框没有索引文件的问题。

### 阶段 2：首页概览与构建覆盖
- **状态：** complete
- 新增首页站点概览 widget，显示文章、分类、标签、总访问量和访客数。
- 新增概览样式，并同步本地主题和 GitHub Actions 的主题覆盖文件。
- GitHub Actions 构建时会复制首页模板、widget 和自定义 CSS。
- 图标、头像、评论、后台统计和个人信息均未在本次范围内修改。

### 阶段 3：验证
- **状态：** complete
- `pnpm run clean`、`pnpm run build` 和 `pnpm run check:site` 连续执行成功。
- Hexo 生成 176 个文件，包含 `search.xml`、首页、文章、笔记、项目、归档、分类和标签页面。
- 浏览器检查确认首页概览、学习笔记导航、文章信息和搜索 `Hexo` 的结果均正常。
- 文章页实际显示发布日期、更新时间、字数、阅读时长和阅读次数；目录及上一篇/下一篇也正常。

### 交付状态
- 本次修改已完成于 `E:\LcyLabHexo`。
- 未执行 GitHub 提交或推送，等待用户确认后再同步远程仓库。

### 阶段 4：纠正访问统计
- **状态：** complete
- 定位到异常数据来自旧版不蒜子脚本在 `localhost` 预览环境下的无效域名统计。
- 生产环境切换到官方新版不蒜子脚本；本地环境不再加载统计脚本，并显示“正式站点统计”。
- 增加兼容桥接，保持 Matery 原有页脚、文章页和首页概览的显示结构。
- 浏览器实测本地首页不显示异常数值；官方 API 按 `https://lcylab.github.io/` 请求返回从 1 开始的测试数据。
- 修正后重新执行 `pnpm run clean`、`pnpm run build` 和 `pnpm run check:site`，全部通过。

### 本次错误日志
| 时间戳 | 错误 | 尝试次数 | 解决方案 |
|--------|------|---------|---------|
| 2026-08-10 | Hexo 将根目录 `scripts/validate-site-features.ps1` 当作 JavaScript 加载 | 1 | 将检查脚本移到 `tools/` |
| 2026-08-10 | Windows PowerShell 5.1 误读校验脚本中的中文字符串 | 1 | 使用 ASCII 页面标记进行断言 |
| 2026-08-10 | 校验脚本排除了所有 `index.html` 导致找不到文章页 | 1 | 只匹配日期文章路径 `public/2026/.../index.html` |
| 2026-08-10 | 本地页面显示 8000 多万访问量 | 1 | 旧版不蒜子不支持 localhost；生产使用新版官方脚本，本地隐藏统计 |

## 会话：2026-08-31

### 阶段 1：修正文章公式与图片资源
- **状态：** complete
- 将文章整理到 `source/_drafts/计算几何基础/01 点积 叉积与法向量/01 点积 叉积与法向量.md`。
- 标题调整为“计算几何基础 01：点积、叉积与法向量”。
- 将 5 张几何示意图集中到同一目录下的 `picture/` 文件夹。
- 将 MathJax 2 的旧 `script type="math/tex; mode=display"` 写法改为 Typora 和 Hexo 都能识别的 `$$...$$` 公式块，并对下标下划线做 Markdown 转义。
- 开启 Hexo `post_asset_folder` 与 marked `postAsset`，使相对图片路径在文章页面中继续有效。

### 验证
- `pnpm exec hexo clean; pnpm exec hexo generate --draft` 通过，生成 192 个文件。
- 文章页面标题正确，5 张图片全部加载成功，MathJax 节点为 68 个，未发现未渲染的 LaTeX 文本。
- Typora 直接使用文章目录下的 `picture/` 相对路径；旧位置的重复图片副本暂保留，未影响新文章资源链路。

### 阶段 2：调整图例布局
- **状态：** complete
- 图 1 移动到“点积的几何意义”公式之后，归入点积小节。
- 图 2 从 Typora 写入的 `zoom: 25%` 改为固定宽度 220px、自动高度并居中显示。
- 删除图例旁边的外部图片来源说明，保留简洁图注。

### 阶段 2 验证
- 浏览器复核确认图 1 位于点积几何公式之后。
- 浏览器复核确认图 2 显示尺寸约为 220×510px，5 张图片均加载成功，68 个公式节点正常渲染。

## 会话：2026-08-31（Redefine 迁移）

### 迁移实现
- **状态：** complete（已完成本地验收，未同步 GitHub）
- 安装并固定 `hexo-theme-redefine@2.9.0` 和 `hexo-filter-mathjax@0.11.1`。
- 根配置切换为 `theme: redefine`，主题配置集中到 `_config.redefine.yml`。
- 保留分类、标签、归档、学习笔记、项目记录、站内搜索、目录、暗色模式、Vercount PV/UV、字数和阅读时长。
- GitHub Actions 已移除构建时下载 Matery 的步骤，改为直接使用锁定的 pnpm 依赖。
- 保留 `themes/matery/` 与 `theme-overrides/matery/` 作为可回退副本。

### 公式与隐私修正
- 将 Redefine/MathJax 不支持的 `\lVert`、`\rVert`、`\operatorname` 改为兼容写法。
- 生成页面不再包含旧 MathJax script、默认 `you@example.com`、打赏图片或验证码占位内容。

### 验证
- `pnpm install --frozen-lockfile` 通过。
- `pnpm exec hexo clean`、`pnpm run build`、`pnpm exec hexo generate --draft` 通过。
- `pnpm run check:site` 通过。
- 浏览器确认首页、分类、标签、归档、学习笔记、项目记录、搜索和首篇文章可访问；首篇文章的 5 张图片逐张加载，68 个 MathJax 节点无错误。

### 本轮公式排障
- **状态：** complete
- 定位到叉积行列式使用 `vmatrix` 环境且 Markdown 会吞掉一层矩阵换行符，导致 `Unknown environment 'vmatrix'` 或矩阵被压成一行。
- 改为 `\left|\begin{array}{ccc}...\end{array}\right|`，并对行尾换行符做 Markdown 转义。
- 浏览器复核确认行列式显示为 3×3，`mjx-merror` 为空；`pnpm run check:site` 通过。

## 会话：2026-09-01（文章公式与向量记号复核）

- 修复叉积模长公式多余的 `=`，并将图 2 调整到模长公式之后。
- 将点间向量和法向量统一为 `\overrightarrow{\mathbf{AB}}` 等粗体箭头形式；点名、坐标分量和标量保持普通体。
- 修复 Markdown 对 `n_p`、`n_i` 等下标的误解析，改用下划线后的空格保护下标，兼容 Typora 和 Hexo 的 MathJax 渲染。
- 补充 `normalize` 定义及非零长度条件。
- `pnpm exec hexo clean`、`pnpm run build`、`pnpm exec hexo generate --draft`、`pnpm run check:site` 均通过；页面无原始 `$$`、无 `mjx-merror`，行列式保持 3×3。

## 会话：2026-09-02（计算电磁学 Day 02）

- 新建 `source/_drafts/计算电磁学/02 有限差分与FDTD电场更新/02 有限差分与FDTD电场更新.md`。
- 标题为“计算电磁学 02：有限差分与 FDTD 电场更新公式”。
- 整理前向、后向和中心差分，麦克斯韦旋度方程，Yee 网格，电场更新系数、CFL 稳定性、边界条件和工程实现注意事项。
- 未使用用户手写图片；使用 Wikimedia Commons 的有限差分图和 FDTD Yee 网格图，图片许可说明放在文章末尾。
- 草稿页面生成 149 个 MathJax 节点和 2 张本地配图，公式错误为 0；`pnpm run build`、`pnpm exec hexo generate --draft`、`pnpm run check:site` 均通过。

### 本轮补充
- 补齐电场 `E_y`、`E_z`，磁场 `H_x`、`H_y`、`H_z` 的 FDTD 更新公式。
- 增加磁场损耗系数 `D_A`、`D_B`、无磁流退化形式，以及最终六分量的紧凑向量方程。
- 重新生成草稿页面后得到 183 个 MathJax 节点、2 张图片，公式错误为 0；全站错误扫描和 `pnpm run check:site` 通过。

## 会话：2026-09-01（计算几何 Day 02）

- 新建 `source/_drafts/计算几何基础/02 方向谓词与圆球内外接判定/02 方向谓词与圆球内外接判定.md`。
- 标题为“计算几何基础 02：方向谓词与圆球内外接判定”，整理 orient2D、orient3D、inCircle 和 inSphere。
- 补充输入点顺序、符号约定、退化输入、浮点误差、Delaunay 应用和谓词与度量的区别。
- 按本篇 orient3D 定义修正 inSphere 的符号说明，明确在正向四面体约定下正数表示球内。
- 将 Day 02 原始笔记保存到同目录 `picture/day-02-notes.jpg`。
- 草稿页面生成 113 个 MathJax 节点、2 个矩阵、无公式错误；`pnpm run build`、`pnpm exec hexo generate --draft`、`pnpm run check:site` 通过。
