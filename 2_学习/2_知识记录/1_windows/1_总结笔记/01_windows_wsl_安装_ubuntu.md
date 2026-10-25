# windows wsl 如何安装ubuntu
在 Windows 11 上安装 WSL (Windows Subsystem for Linux) 并部署 Ubuntu 主要有三种方法，其中命令行一键安装最为推荐。以下是完整流程总结及关键配置指南：

🚀 方法一：命令行一键安装（最推荐）
适用于网络通畅、希望快速完成所有配置的用户。此方法会自动启用所需功能、下载内核并安装默认或指定的 Ubuntu 版本。

1. 打开终端：右键点击开始菜单，选择 “Windows Terminal (管理员)” 或 “PowerShell (管理员)”。
2. 执行命令：
   - 安装默认最新版 Ubuntu：
     ```powershell
     wsl --install
     ```
   - 安装指定版本（如 Ubuntu 24.04 LTS）：
     ```powershell
     wsl --install -d Ubuntu-24.04
     ```
3. 重启电脑：命令执行完成后，必须重启计算机以使虚拟化驱动和子系统生效。
4. 初始化设置：重启后，Ubuntu 终端会自动弹出。根据提示设置 UNIX 用户名（建议小写）和 密码（输入时不显示字符，属正常现象）。

---

🛠️ 方法二：分步手动安装（适合故障排查或自定义）
如果一键安装失败，或需要精确控制组件启用顺序，可采用此方法。

1. 启用必要功能：以管理员身份运行 PowerShell，依次执行：
   ```powershell
   dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
   dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
   ```
2. 重启计算机。
3. 设置默认版本：重启后再次打开管理员终端，执行：
   ```powershell
   wsl --set-default-version 2
   ```
4. 安装发行版：
   - 查看可用列表：`wsl --list --online`
   - 安装指定版本：`wsl --install -d <发行版名称>` （例如 `Ubuntu-24.04`）

---

🏪 方法三：Microsoft Store 图形化安装
适合不熟悉命令行或企业策略限制 PowerShell 的用户。

1. 打开 Microsoft Store。
2. 搜索 “Ubuntu” 或具体版本如 “Ubuntu 24.04 LTS”。
3. 确认发布者为 Canonical Group Limited 或 Microsoft Corporation，点击 “获取” 或 “安装”。
4. 安装完成后，在开始菜单启动 Ubuntu，按提示完成用户名和密码初始化。
   *注：若启动时报错，可能需要先在 PowerShell 中运行 `wsl --update` 更新内核。*

---

✅ 安装后必备配置（重要）

进入 Ubuntu 终端后，建议立即执行以下操作以优化体验：

1. 更新系统软件包
```bash
sudo apt update && sudo apt upgrade -y
```

2. 更换国内镜像源（加速下载）
由于默认源在国外，国内用户建议更换为清华源或阿里源。以清华源为例：
```bash
备份原源文件
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

替换为清华源（以 Ubuntu 24.04 noble 为例，其他版本需调整代号）
sudo sed -i 's@http://archive.ubuntu.com/ubuntu/@https://mirrors.tuna.tsinghua.edu.cn/ubuntu/@g' /etc/apt/sources.list

再次更新
sudo apt update
```
*注意：不同 Ubuntu 版本的源地址代号不同（如 22.04 是 jammy，24.04 是 noble），请根据实际版本调整。*

3. 安装常用开发工具
```bash
sudo apt install -y build-essential curl wget git vim unzip
```

4. 验证 WSL 状态
在 Windows PowerShell 中运行：
```powershell
wsl -l -v
```
确保输出中 `VERSION` 列为 2，且状态为 `Running` 或 `Stopped`。

---

💡 常见问题与技巧

*   虚拟化未启用：如果安装报错，请进入 BIOS/UEFI 开启 Intel VT-x 或 AMD-V (SVM)。可在任务管理器 -> 性能 -> CPU 中查看“虚拟化”是否已启用。
*   文件互访：
    *   Windows 访问 Linux 文件：在资源管理器地址栏输入 `\\wsl$\Ubuntu-24.04\home\你的用户名`。
    *   Linux 访问 Windows 文件：Windows 的 C 盘挂载在 `/mnt/c`，例如 `cd /mnt/c/Users/你的Windows用户名`。
*   迁移安装位置：WSL 默认安装在 C 盘。若需迁移至 D 盘，可使用 `wsl --export` 导出为 tar 包，注销原实例 (`wsl --unregister`)，再用 `wsl --import` 导入到新路径。
*   GPU 加速：WSL 2 支持 GPU 直通，确保 Windows 上安装了最新的 NVIDIA 或 AMD 显卡驱动，即可在 Linux 中使用 CUDA 等加速功能。

通过以上步骤，你即可在 Windows 11 上获得一个高性能、无缝集成的 Ubuntu 开发环境。<br>参考资料<br>[1] [Win11怎么安装WSL_Win11安装Linux子系统完整教程【进阶】-Windows系列-PHP中文网  - php中文网](https://www.php.cn/faq/2458917.html)<br>[2] [Windows 11 安装 WSL + Ubuntu 24.04 完整指南（从零到可用）_wsl安装-CSDN博客 - CSDN博客](https://blog.csdn.net/longerxin2020/article/details/163672252)<br>[3] [Win11安装WSL及Ubuntu完整指南：从零搭建Linux开发环境-CSDN博客 - CSDN博客](https://blog.csdn.net/weixin_32520095/article/details/167662202)<br>[4] [Windows怎么安装Ubuntu到WSL_Windows如何在WSL中安装Ubuntu发行版系统【教程】-Windows系列-PHP中文网  - php中文网](https://www.php.cn/faq/2270531.html)<br>[5] [在Windows 11上 使用 WSL 安装并运行带有图形界面的 Ubuntu 24.04-腾讯云开发者社区-腾讯云 - 腾讯云](https://cloud.tencent.com/developer/article/2553255)<br>[6] [WSL2与Ubuntu 20.04安装配置全指南-恒康企业建站 - www.healthychan.com](http://www.healthychan.com/news/409914/)<br>[7] [Ubuntu WSL2 安装与管理全攻略：从入门到进阶-CSDN博客 - CSDN博客](https://blog.csdn.net/weixin_32183107/article/details/164865968)<br>[8] [WSL 2安装Ubuntu 24.04 LTS全指南-恒康企业建站 - www.healthychan.com](http://www.healthychan.com/news/1015961/)<br>[9] [WSL2与Ubuntu安装配置全指南-CSDN博客 - CSDN博客](https://blog.csdn.net/weixin_30225755/article/details/162949227)<br>[10] [WSL2 从入门到实战：Ubuntu 安装配置、系统优化与故障排查全指南-编程知识 - www.hqwc.cn](http://www.hqwc.cn/a/1918747.html)<br>[11] [Win11 学院：如何在 Windows 11 上使用 WSL 安装 Ubuntu - 腾讯云开发者社区-腾讯云 - 腾讯云](https://cloud.tencent.com/developer/news/2190163)<br>[12] [Win11 安装 WSL2 Ubuntu 24.04 完整指南：从零到开发环境-尧图网站设计 - 网站设计基础知识学习经验分享](http://www.trdm.cn/news/721290)<br>[13] [Windows 11通过WSL命令行安装Ubuntu指南_文心快码 - 文心快码](https://comate.baidu.com/zh/page/bs14cdpetny)<br>[14] [Windows 11 WSL + Ubuntu 24.04 安装指南_wsl安装-CSDN博客 - CSDN博客](https://blog.csdn.net/h_bpdwn/article/details/161223930)<br>[15] [WSL 安装 Ubuntu 完整步骤（Windows 10/11 通用，极简无脑版）_wsl安装ubuntu-CSDN博客 - CSDN博客](https://blog.csdn.net/wochunyang/article/details/160559987)<br>[16] [win11如何在WSL中安装Ubuntu_win11WSL中安装Ubuntu最全设置总结-Windows系列-PHP中文网  - php中文网](https://www.php.cn/faq/2304041.html)<br>[17] [Win11用户必看：三种方法教你轻松安装WSL中的Ubuntu - 腾讯云开发者社区-腾讯云 - 腾讯云](https://cloud.tencent.com/developer/news/2191018)<br>[18] [win11如何使用Linux子系统WSL_win11Linux子系统WSL完整指南一文搞懂-Windows系列-PHP中文网  - php中文网](https://www.php.cn/faq/2349974.html)<br>[19] [Windows 11 安装 WSL 2 + Ubuntu 24.04 完整指南-CSDN博客 - CSDN博客](https://blog.csdn.net/weixin_33462167/article/details/166161306)<br>[20] [Windows11从零开始配置 WSL2 并安装 Ubuntu（新手友好）_win11 wsl2安装-CSDN博客 - CSDN博客](https://blog.csdn.net/weixin_58521748/article/details/162790296)<br>[21] [Windows系统下通过WSL安装Ubuntu子系统全攻略_文心快码 - 文心快码](https://comate.baidu.com/zh/page/2p1lh86weoh)<br>[22] [Win11怎么安装Linux子系统 Win11 WSL2安装Ubuntu及环境配置指南-Windows系列-PHP中文网  - php中文网](https://www.php.cn/faq/1801711.html)<br>[23] [别再装双系统、虚拟机了！Windows WSL 保姆级全指南：从安装到进阶，一篇搞定原生 Linux 环境 - 知乎 - 知乎](https://zhuanlan.zhihu.com/p/2020586727526385283)<br>[24] [windows11如何安装WSL_Windows 11安装Linux子系统(WSL)教程-Windows系列-PHP中文网  - php中文网](https://www.php.cn/faq/1676783.html)<br>[25] [Windows 11安装Ubuntu全攻略：WSL、虚拟机、双系统对比与实战-CSDN博客 - CSDN博客](https://blog.csdn.net/weixin_42524824/article/details/164666164)<br>[26] [告别双系统折腾！Win11下用WSL2安装Ubuntu 24.04桌面版保姆级教程-CSDN博客 - CSDN博客](https://blog.csdn.net/weixin_29232507/article/details/159370342)<br>[27] [Win11安装Ubuntu20.04双系统（保姆教程 - 更新至2025.06）-编程知识 - www.hqwc.cn](http://www.hqwc.cn/news/1585170.html)<br>[28] [Win11怎么安装Linux双系统_Win11与Ubuntu双系统安装方法【进阶】-Windows系列-PHP中文网  - php中文网](https://www.php.cn/faq/2446181.html)<br>[29] [Win11安装基于WSL2的Ubuntu-腾讯云开发者社区-腾讯云 - 腾讯云](https://cloud.tencent.com/developer/article/2476964)<br>[30] [Windows系统下安装Ubuntu双系统全流程指南_文心快码 - 文心快码](https://comate.baidu.com/zh/page/i8dod1rh6ca)<br>[31] [WSL2安装配置全攻略：从系统准备到开发环境搭建-编程知识 - www.hqwc.cn](http://www.hqwc.cn/a/1045453.html)<br>[32] [WSL2手动安装Ubuntu 18.04完整指南_文心快码 - 文心快码](https://comate.baidu.com/zh/page/4qtdkun4tmz)<br><br>百度AI生成，内容仅供参考
