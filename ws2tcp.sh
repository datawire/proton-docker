#!/bin/bash
ORIGIN=$(pwd)
DIR=$(dirname $(readlink -f $0))
cd $DIR
PID=$(ps axf | grep "node proxy" | grep -v grep | awk '{print $1}' | head -n1)
if [ -n "$PID" ]; then
    echo "ws2tcp already running PID=$PID"
else
    node proxy "$@" > ws2tcp.log 2>&1 &
    PID=$!
    echo "ws2tcp started PID=$PID."
fi
cd $ORIGIN
