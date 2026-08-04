<script setup lang="ts">
type Post = {
  date: string
  category: string
  title: string
  excerpt: string
  link: string
}

const posts: Post[] = [
  {
    date: '2026-08-04',
    category: '站点记录',
    title: '为什么要建立 LCY Lab？',
    excerpt: '把学习过程中的问题、判断和实验结果留下来，让以后重新遇到同类问题时能够快速找回上下文。',
    link: '/projects/lcy-lab-site',
  },
  {
    date: '2026-08-04',
    category: 'C++',
    title: '工程代码中的数据流与失败条件',
    excerpt: '从一个小函数开始，让输入、输出和失败路径都能被读者清楚地追踪。',
    link: '/notes/cpp/engineering-data-flow',
  },
  {
    date: '2026-08-04',
    category: '计算几何',
    title: '几何判断为什么要区分相交、接触和包含',
    excerpt: '布尔相交并不等于几何穿过。处理网格和 CAD 模型时，分类语义必须先定义清楚。',
    link: '/notes/geometry/intersection-semantics',
  },
  {
    date: '2026-08-04',
    category: '电磁仿真',
    title: '从 Yee 网格到材料分类的基本数据流',
    excerpt: '整理网格单元、几何体和材料状态之间的关系，避免把几何分类和求解状态混在一起。',
    link: '/notes/em/yee-material-classification',
  },
  {
    date: '2026-08-04',
    category: 'Qt / OpenCascade',
    title: '模型树、选择状态与属性面板如何保持一致',
    excerpt: '从用户点击模型到属性面板刷新，梳理桌面 CAD 工具中最容易出现的状态同步问题。',
    link: '/notes/qt-occt/model-selection-flow',
  },
]

const topics = [
  { text: 'C++', link: '/notes/cpp/' },
  { text: '计算几何', link: '/notes/geometry/' },
  { text: '电磁仿真', link: '/notes/em/' },
  { text: 'Qt / OpenCascade', link: '/notes/qt-occt/' },
]
</script>

<template>
<div class="lcy-home">
  <section class="lcy-cover">
    <div class="lcy-cover__glow lcy-cover__glow--one"></div>
    <div class="lcy-cover__glow lcy-cover__glow--two"></div>
    <div class="lcy-avatar">LCY</div>
    <p class="lcy-cover__eyebrow">TECHNICAL NOTES · 2026</p>
    <h1>LCY Lab</h1>
    <p class="lcy-cover__tagline">电磁仿真 · 计算几何 · C++ · Qt / OpenCascade</p>
    <p class="lcy-cover__intro">
      记录问题，拆解问题，再把解决问题的方法整理成可以复用的知识。
    </p>
    <div class="lcy-cover__actions">
      <a class="lcy-button lcy-button--primary" href="/archive">开始阅读</a>
      <a class="lcy-button" href="https://github.com/LcyLab/LcyLab.github.io">GitHub</a>
    </div>
  </section>

  <div class="lcy-layout">
    <main class="lcy-feed">
      <div class="lcy-section-heading">
        <div>
          <p class="lcy-kicker">LATEST NOTES</p>
          <h2>最近记录</h2>
        </div>
        <a href="/archive">查看全部 →</a>
      </div>

      <article v-for="post in posts" :key="post.link" class="lcy-post-card">
        <div class="lcy-post-card__meta">
          <time>{{ post.date }}</time>
          <span>{{ post.category }}</span>
        </div>
        <h3><a :href="post.link">{{ post.title }}</a></h3>
        <p>{{ post.excerpt }}</p>
        <a class="lcy-read-more" :href="post.link">阅读全文 <span>↗</span></a>
      </article>
    </main>

    <aside class="lcy-aside">
      <section class="lcy-aside-card lcy-aside-card--about">
        <p class="lcy-kicker">ABOUT THIS LAB</p>
        <h2>你好，我是 LCY</h2>
        <p>
          这里主要记录电磁仿真、计算几何、C++、Qt 和 OpenCascade 相关的学习与工程实践。
        </p>
        <a href="/about">更多关于我 →</a>
      </section>

      <section class="lcy-aside-card">
        <p class="lcy-kicker">TOPICS</p>
        <div class="lcy-topic-list">
          <a v-for="topic in topics" :key="topic.link" :href="topic.link">{{ topic.text }}</a>
        </div>
      </section>

      <section class="lcy-aside-card lcy-aside-card--github">
        <p class="lcy-kicker">OPEN SOURCE</p>
        <h2>代码和笔记都在 GitHub</h2>
        <a href="https://github.com/LcyLab">github.com/LcyLab ↗</a>
      </section>
    </aside>
  </div>
</div>
</template>
