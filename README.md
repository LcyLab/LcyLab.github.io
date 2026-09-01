# LCY Lab

使用 Hexo + Redefine 构建的个人学习与研究笔记站点。

网站地址：<https://lcylab.github.io/>

## 本地运行

```powershell
pnpm install
pnpm run server
```

访问 `http://localhost:4000`。

## 本地检查

```powershell
pnpm run clean
pnpm run build
pnpm run check:site
```

`check:site` 会检查搜索索引、核心页面、站点统计标记、文章信息和默认占位内容。

## 新建文章

```powershell
hexo new post "文章标题"
```

文章保存在 `source/_posts/`，使用 `categories` 和 `tags` front matter 管理分类与标签。

## 构建

```powershell
pnpm run clean
pnpm run build
```

生成结果位于 `public/`，该目录不会提交到源分支。推送到 `main` 后，GitHub Actions 会构建并部署 GitHub Pages。

## 主题配置

主题配置位于 `_config.redefine.yml`，根配置通过 `theme: redefine` 启用 Redefine。Redefine 通过 `package.json` 固定版本并由 GitHub Actions 安装，不再依赖构建时下载 Matery。`themes/matery/` 和 `theme-overrides/matery/` 暂时保留，仅用于迁移回退；确认 Redefine 版本稳定后再考虑清理。头像、首页 Banner、菜单、GitHub 链接和页面入口都可以在 `_config.redefine.yml` 中调整。

当前已启用按正式域名统计的站点 PV/UV、文章浏览量、字数、阅读时长、目录、分类、标签、站内搜索和暗色模式。统计使用 Redefine 的 Vercount 接入，正式站点会累积真实数据；本地预览中的数字不代表线上统计结果。
