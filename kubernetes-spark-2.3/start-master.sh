#!/bin/sh

start-common.sh

echo "$(hostname -i) spark-beta-master" >> /etc/hosts

sbin/start-master.sh --ip spark-beta-master --port 7077

