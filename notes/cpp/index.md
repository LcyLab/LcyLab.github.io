# C++

## 记录方向

- 现代 C++ 语法与标准库
- CMake、Visual Studio 和跨平台工程
- 性能、内存和调试问题
- 面向大型工程的模块设计

## 示例：优先使用清晰的数据流

在工程代码中，函数不仅要完成计算，还应该让输入、输出和失败条件容易被追踪。一个小函数可以先明确返回值，再处理边界情况：

```cpp
#include <optional>

std::optional<int> parsePositiveInt(const std::string& text) {
    if (text.empty()) {
        return std::nullopt;
    }

    const int value = std::stoi(text);
    return value > 0 ? std::optional<int>(value) : std::nullopt;
}
```

后续笔记会继续补充异常处理、输入校验和测试策略。
