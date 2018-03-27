#!/bin/sh

start-common.sh

sbin/start-slave.sh spark://spark-beta-master:7077
sbin/start-shuffle-service.sh
