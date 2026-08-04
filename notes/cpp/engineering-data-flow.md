---
title: 工程代码中的数据流与失败条件
description: 从一个小函数开始，让输入、输出和失败路径都能被清楚追踪。
---

# 工程代码中的数据流与失败条件

工程代码最容易变复杂的地方，不一定是算法本身，而是调用者无法判断一个函数到底接收什么、返回什么，以及失败后状态是否仍然有效。

## 先把失败条件写进返回值

例如，解析一个正整数时，可以用 `std::optional` 明确表达“没有得到有效结果”：

```cpp
#include <optional>
#include <string>

std::optional<int> parsePositiveInt(const std::string& text) {
    if (text.empty()) {
        return std::nullopt;
    }

    const int value = std::stoi(text);
    return value > 0 ? std::optional<int>(value) : std::nullopt;
}
```

这个例子的重点不是语法，而是让调用者不需要猜测特殊返回值。后续还需要根据工程约束补充异常处理和输入范围检查。

## 对大型工程的启发

- 输入数据在进入核心算法前完成校验。
- 算法函数尽量不偷偷修改外部状态。
- 失败路径要能说明原因，而不是只返回一个模糊的 `false`。
- 保存、导出和界面刷新都应该沿着清晰的数据流连接起来。
