#!/bin/bash

# 定义变量
GREETING="Hello, World!"
CURRENT_USER=$(whoami)
CURRENT_TIME=$(date +"%Y-%m-%d %H:%M:%S")

# 输出信息
echo "=============================="
echo "$GREETING"
echo "当前用户: $CURRENT_USER"
echo "当前时间: $CURRENT_TIME"
echo "=============================="
