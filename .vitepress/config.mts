import { defineConfig } from 'vitepress'

export default defineConfig({
  lang: 'zh-CN',
  title: 'LCY Lab',
  description: '电磁仿真、计算几何、C++ 与仿真软件开发笔记',
  cleanUrls: true,
  lastUpdated: true,
  themeConfig: {
    siteTitle: 'LCY Lab',
    nav: [
      { text: '首页', link: '/' },
      { text: '归档', link: '/archive' },
      { text: '分类', link: '/notes/' },
      { text: '项目记录', link: '/projects/' },
      { text: '标签', link: '/tags' },
      { text: '关于我', link: '/about' },
      { text: 'GitHub', link: 'https://github.com/LcyLab/LcyLab.github.io' },
    ],
    sidebar: {
      '/notes/': [
        {
          text: '学习笔记',
          items: [
            { text: '笔记总览', link: '/notes/' },
            { text: 'C++', link: '/notes/cpp/' },
            { text: '计算几何', link: '/notes/geometry/' },
            { text: '电磁仿真', link: '/notes/em/' },
            { text: 'Qt / OpenCascade', link: '/notes/qt-occt/' },
          ],
        },
      ],
      '/projects/': [
        {
          text: '项目记录',
          items: [{ text: '项目总览', link: '/projects/' }],
        },
      ],
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/LcyLab' },
    ],
    search: {
      provider: 'local',
    },
    footer: {
      message: '记录问题，持续积累。',
      copyright: 'Copyright © 2026 LCY Lab',
    },
  },
})
