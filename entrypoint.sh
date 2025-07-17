#!/bin/bash
set -e

rm -f /tmp/.X99-lock

# 启动虚拟显示服务器
Xvfb :99 -ac -screen 0 1920x1080x24 -nolisten tcp &
sleep 5

# 启动VNC服务器
x11vnc -display :99 \
       -rfbport 5900 \
       -listen 0.0.0.0 \
       -N -forever \
       -passwd secret \
       -shared \
       -ncache 10 \
       -ncache_cr \
       -cursor arrow \
       -cursor_pos \
       -scale_cursor \
       -solid &

# 等待服务启动
sleep 3

# 根据参数运行不同的脚本
SCRIPT=${1:-agent.py}
echo "Running: python $SCRIPT"
exec python "$SCRIPT"
