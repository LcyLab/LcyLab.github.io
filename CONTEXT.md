# LCY Lab Hexo 项目上下文

## 站点身份

- 本地项目：E:\LcyLabHexo
- GitHub 仓库：https://github.com/LcyLab/LcyLab.github.io
- 在线地址：https://lcylab.github.io/
- 技术路线：Hexo + hexo-theme-redefine 2.9.0 + GitHub Actions + GitHub Pages。
- 用途：按分类记录计算几何、计算电磁学、FDTD、C++、Qt、OpenCascade 等学习与研究笔记。
- 这是 Markdown 静态站点，不引入登录、在线编辑、数据库或多人协作功能。
- 默认使用中文，表达简洁；需要确认时一次只问一个关键问题。

## 已确定的协作决策

- 使用 Redefine，不直接修改 node_modules/hexo-theme-redefine；主题配置统一写在根目录 _config.redefine.yml。
- 站点保留真实 GitHub 关联，删除无关的默认个人资料、打赏和占位内容。
- 文章目录和图片应一起管理，避免 Markdown 依赖外部图片链接。
- 用户喜欢文章开头的灰色引用块简介，所有文章保持统一形式。
- 简介只描述文章的技术主题，不写“根据手写笔记”“根据照片整理”等来源说明。
- 简介禁止出现手写笔记、照片、颜色、字迹辨认、模糊批注、逐字转录或整理过程；只概述文章涉及的概念、公式、算法和结论。
- 正文标题中避免使用 MathJax 内联公式，以免 TOC 提取后出现“电场的、更新”。
- 用户明确要求同步时才提交和推送 GitHub；本地预览、构建和线上发布要分开说明。

## 文章目录结构

每篇文章使用一个目录，目录内只保留一个 Markdown 文件和一个 picture 文件夹：

source/_drafts/<分类>/<文章目录>/<文章名>.md
source/_drafts/<分类>/<文章目录>/picture/

发布时将同样的文章目录移动到 source/_posts/。当前 4 篇笔记已经发布到 _posts，source/_drafts 已清理为空目录。

## 文件存放位置规则

- 未完成文章：E:\LcyLabHexo\source\_drafts\<分类>\<文章目录>\<文章名>.md。
- 文章图片：放在同一文章目录下的 picture/，例如 E:\LcyLabHexo\source\_posts\计算电磁学\02 有限差分与FDTD电场更新\picture\。
- 已发布文章：将完整文章目录移动到 E:\LcyLabHexo\source\_posts\<分类>\。
- 分类页面：source/categories/；标签页面：source/tags/；归档页面：source/archives/；学习笔记入口：source/notes/；项目记录：source/projects/。
- 根站点配置：E:\LcyLabHexo\_config.yml；Redefine 配置：E:\LcyLabHexo\_config.redefine.yml。
- 自定义样式：E:\LcyLabHexo\source\css\；公共背景图片：E:\LcyLabHexo\source\images\。
- GitHub Actions 工作流：.github/workflows/pages.yml。
- public/ 是 Hexo 生成目录，只是构建产物，不直接编辑，也不作为文章源文件存放位置。
- 本地预览：http://localhost:4177/；远程仓库：LcyLab/LcyLab.github.io；线上地址：https://lcylab.github.io/。
- 不要把文章图片放在 source/_drafts/images/；图片必须跟随当前文章目录保存在 picture/ 中。

## 标准 Front Matter

必须根据文章实际内容填写 title、date、permalink、mathjax、categories、tags 和 description：

---
title: 计算电磁学02：直角坐标中FDTD三维公式
date: 2026-09-02 20:00:00
permalink: 计算电磁学/02-有限差分与FDTD电场更新/
mathjax: true
categories:
  - 计算电磁学
tags:
  - FDTD
  - Yee网格
description: 用一句话概括文章的技术内容。
---

正文开头使用一段约两行的灰色引用块：

> 文章简介只写技术主题，保持简洁，不提手写笔记、照片或图片来源。

目前 4 篇文章都采用正文开头引用块；不要只修改 description，因为 description 主要用于页面元信息。

## 公式与标题规则

- 正文公式使用标准 $$...$$ 公式块；正文中可以使用 $...$ 内联公式。
- 不使用 <script type="math/tex; mode=display">，Typora 会把它当普通 HTML。
- 向量使用 \mathbf{}，例如 \mathbf{E}、\mathbf{H}、\mathbf{a}。
- 有向线段可使用 \overrightarrow{\mathbf{AB}}。
- 避免 \operatorname、\lVert、\rVert 等兼容性较差的写法。
- 行列式优先使用 \left|\begin{array}...\end{array}\right|。
- 文章标题或 TOC 标题中不要使用 MathJax 内联公式；例如使用“6.1 电场的 *Ey*、*Ez* 更新”。
- 图片放在当前文章的 picture 文件夹，正文使用相对路径 picture/example.svg。
- 公式、图片和中文编码需要同时在 Typora 与 Hexo 生成页面中检查。

## 当前主题与性能改动

- 首页已采用清晰首屏 + 预模糊的普通滚动正文背景。
- 不使用全屏 position: fixed 背景、运行时 filter: blur() 或自定义滚动模糊脚本，以避免桌面端滚动掉帧。
- 背景样式位于 source/css/lcy-banner-blur.css，预模糊背景位于 source/images/。
- 桌面端文章标题和章节字号位于 source/css/lcy-typography.css；移动端保持主题默认字号。
- 当前本地的性能优化、标题字号调整和简介统一改动已经通过构建检查，但尚未同步 GitHub。

## 新建笔记流程

1. 在 source/_drafts/<分类>/<文章目录>/ 创建一个 Markdown 文件和 picture 文件夹。
2. 写 Front Matter，并在正文第一段写两行左右的灰色引用块简介。
3. 使用 ## 组织主要章节，使用 ### 组织小节；标题中的变量使用纯文本或 Markdown 斜体。
4. 图片保存到本文章的 picture 文件夹，并使用相对路径。
5. 执行 pnpm run clean、pnpm run build、pnpm run check:site。
6. 用 pnpm run server -- --drafts --port 4177 预览；配置变化后需要重启服务。
7. 检查标题、简介、公式、图片、TOC、桌面端和移动端布局。
8. 用户确认后，才将文章从 _drafts 移到 _posts 并提交推送。
