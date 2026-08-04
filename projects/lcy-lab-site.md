---
title: LCY Lab 站点搭建记录
description: 使用 VitePress 和 GitHub Pages 建立自己的学习笔记站点。
---

# LCY Lab 站点搭建记录

这个站点的目标不是做一个复杂的内容管理系统，而是把笔记放在 GitHub 仓库中，用 Markdown 长期维护，并通过 GitHub Pages 自动发布。

## 当前方案

- VitePress：负责 Markdown 渲染、导航和本地搜索。
- GitHub Actions：负责构建和部署。
- `notes/`：按主题组织学习笔记。
- `projects/`：记录项目过程和阶段性结论。

## 为什么先从静态站点开始

学习笔记的主要操作是写 Markdown、提交和检索。静态站点已经覆盖了这个闭环，不需要先引入数据库、登录和在线编辑器。

后续如果文章数量明显增加，再考虑标签索引、全文搜索增强和自动生成目录。
