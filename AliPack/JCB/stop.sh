#!/bin/bash

# 明确指定 JAR 文件名（避免自动选择）
JARFILE="AliPack.jar"
PID_FILE="$JARFILE.pid"

# 检查 PID 文件是否存在
if [ ! -f "$PID_FILE" ]; then
  echo "错误：未找到 PID 文件 $PID_FILE"
  exit 1
fi

# 读取 PID 并检查有效性
PID=$(cat "$PID_FILE")
if [ -z "$PID" ]; then
  echo "PID 文件为空，请手动清理"
  exit 1
fi

# 检查进程是否存在
if kill -0 "$PID" >/dev/null 2>&1; then
  # 先尝试优雅终止（SIGTERM）
  kill -15 "$PID"
  sleep 5  # 等待进程退出

  # 强制终止（如果优雅终止失败）
  if kill -0 "$PID" >/dev/null 2>&1; then
    kill -9 "$PID"
    echo "$JARFILE 已强制终止 (PID: $PID)"
  else
    echo "$JARFILE 已正常停止 (PID: $PID)"
  fi

  # 清理 PID 文件
  rm -f "$PID_FILE"
else
  echo "进程 $PID 不存在，清理残留 PID 文件"
  rm -f "$PID_FILE"
fi
