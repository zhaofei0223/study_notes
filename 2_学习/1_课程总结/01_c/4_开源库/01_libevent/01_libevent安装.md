# Linux 下安装 & 验证 libevent

官方主页：[https://libevent.org/](https://libevent.org/)

1. 从官网获取最新稳定版（如2.1.12）：
```shell
wget https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
tar -xzvf libevent-2.1.12-stable.tar.gz
cd libevent-2.1.12-stable
```

2. 编译配置

执行以下命令进行编译和安装：
```shell
./configure --prefix=/usr/local  # 指定安装路径
make
sudo make install
```

3. 配置库路径

更新动态链接库缓存：
```shell
sudo ldconfig  # 更新库链接
```

4. 验证安装

运行官方示例程序：
```shell
cd sample
gcc hello-world.c -o hello -levent && ./hello
```
