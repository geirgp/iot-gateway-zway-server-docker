#!/bin/bash
set -eu
logfile="/var/log/z-way-server.log"

echo "Starting z-way-server ..."
echo "./z-way-server $@"
./z-way-server "$@" &
while [ ! -f $logfile ] ;
do
  # tail will crash if the log file doesn't exist --> wait for it to be
  # created (only applicable on the first run)
  echo "Waiting for z-way-server to start up."
  sleep 1
done

echo "Attaching to log file $logfile ..."
tail --pid $$ -n0 -F $logfile
