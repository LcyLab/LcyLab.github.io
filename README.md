# LCY Lab

使用 Hexo + Matery 构建的个人学习与研究笔记站点。

网站地址：<https://lcylab.github.io/>

## 本地运行

```powershell
pnpm install
pnpm run server
```

访问 `http://localhost:4000`。

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

本地主题配置位于 `themes/matery/_config.yml`，用于本地预览。GitHub Actions 会自动下载 Matery 主题，并使用 `theme-overrides/matery/_config.yml` 覆盖主题配置后再构建。头像、首页 Banner、菜单、GitHub 链接、About 页面和项目展示都可以在覆盖配置中调整。
