#!/bin/bash

# 明确指定 JAR 文件名
JARFILE="AliPack.jar"

# 启动命令
nohup java -javaagent:$JARFILE -jar -Xms2048m -Xmx2048m -Xmn192m -Xss512k -XX:+UseConcMarkSweepGC -XX:CMSFullGCsBeforeCompaction=200 -XX:+UseCMSCompactAtFullCollection $JARFILE > /dev/null 2>&1 &

# 记录 PID
if [ $? -eq 0 ]; then
  echo $! > "$JARFILE.pid"
  echo "应用启动成功，PID: $!"
else
  echo "应用启动失败"
  exit 1
fi
