在 Windows 上安装 C 开发环境，主要有两条路线：一是装 Visual Studio 这种全能 IDE，二是用 MinGW 或 MSYS2 配 VS Code 的轻量组合。 新手图省心选前者，想轻量、灵活或习惯命令行选后者。

🖥️ 路线一：Visual Studio（推荐新手）

微软官方 IDE，自带 MSVC 编译器、调试器，装完即用，无需手动配环境变量。

1. 下载安装器：去 Visual Studio 官网下载社区版（Community），个人学习免费。
2. 选择工作负载：运行安装器后，勾选“使用 C++ 的桌面开发”，这是 C/C++ 核心组件，含编译器、Windows SDK 等。
3. 开始安装：安装包较大，默认占用约 10G 空间，可在安装器里改路径，然后点“安装”等待完成。
4. 验证：启动 VS，新建“空项目”，写个 Hello World 代码，点“本地 Windows 调试器”运行，输出正常即环境 OK。

> Visual Studio 是完整 IDE，功能强大但偏重；VS Code 只是轻量编辑器，需自行搭配编译器才能编译 C 代码。

⚙️ 路线二：MinGW + VS Code（轻量主流）

此组合占用小、启动快，也是目前较流行搭配。

1. 安装编译器（MinGW）：通过 MSYS2{id="entity_1"} 安装较方便。下载 MSYS2 安装包，一路下一步安装，注意安装路径不要含中文或空格。
2. 安装 GCC 工具链：安装完启动 MSYS2 终端，输入命令按回车更新软件包，再输入命令安装 MinGW 工具链（含 gcc.exe）。
3. 配置环境变量：找到 `mingw64\bin` 文件夹，复制完整路径，添加到系统环境变量 `Path` 中。
4. 验证编译器：打开 cmd，输入 `gcc -v`，若显示版本信息则配置成功。
5. 安装 VS Code 及插件：下载安装 VS Code，在扩展商店搜索安装 C/C++（微软官方）和 Code Runner 插件，即可获得语法高亮、代码补全和一键运行功能。

> 若下载 MinGW 压缩包手动解压，记得把解压后 `bin` 目录路径加到 `Path`，且路径保持纯英文。

📝 验证环境

无论哪条路线，写个简单程序测试：

```c
include <stdio.h>
int main() {
    printf("Hello World!\n");
    return 0;
}
```

保存为 `hello.c`，命令行执行 `gcc hello.c -o hello.exe` 再运行 `hello.exe`，输出 Hello World 即环境搭建完成。