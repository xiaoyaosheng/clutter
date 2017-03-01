#! /bin/bash
function shutdown()
{
    date
    echo "Shutting down Service"
    unset SERVICE_PID # Necessary in some cases
    cd /opt/${MODULE_NAME}
    source stop.sh
}
 
## 停止进程
cd /opt/${MODULE_NAME}
echo "Stopping Service"
source stop.sh
 
## 启动进程
echo "Starting Service"
source start.sh
export SERVICE_PID=$!
 
## 启动Flume NG agent，等待4s日志由start.sh生成
sleep 4 
nohup /opt/apache-flume-1.6.0-bin/bin/flume-ng agent --conf /opt/apache-flume-1.6.0-bin/conf --conf-file /opt/apache-flume-1.6.0-bin/conf/logback-to-kafka.conf --name a1 -Dflume.root.logger=INFO,console &
 
# Allow any signal which would kill a process to stop Service
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP
 
echo "Waiting for $SERVICE_PID"
wait $SERVICE_PID