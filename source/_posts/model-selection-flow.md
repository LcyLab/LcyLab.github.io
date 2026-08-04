---
title: 模型树、选择状态与属性面板如何保持一致
description: 从用户点击模型到属性面板刷新，梳理桌面 CAD 工具的状态同步。
date: 2026-08-01 20:00:00
categories:
  - Qt / OpenCascade
tags:
  - Qt
  - OpenCascade
  - CAD
---

在 Qt 和 OpenCascade 应用中，用户看到的是模型树、视口和属性面板三个界面，但它们应该共享同一个“当前选择模型”状态，而不是各自维护一份选择结果。

## 推荐的数据流

```text
视口或模型树产生选择
  → Document / Controller 更新 selectedModelId
  → NavigationTree 投影选择状态
  → Properties Dock 根据 selectedModelId 刷新
```

选择变化时，应先清理旧的属性内容，再根据新模型填充数据。这样可以避免用户已经取消选择，但属性面板还显示上一个对象的陈旧信息。

## 需要提前定义的边界

- 选择模型和选择模型的某个面、边、点不是同一种状态。
- 隐藏模型时，是否保留选择需要有明确规则。
- 删除或重新导入模型后，旧的模型 ID 必须失效。
- 属性面板只负责展示和编辑，不应该反过来拥有模型树的选择状态。
