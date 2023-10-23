#!/bin/bash

host="ya.ru"
path="~/ping-log"
count=1
timeout=1

# Process command-line arguments
while getopts ":h:c:t:" opt; do
  case $opt in
    h)
      if [[ -z $OPTARG ]]; then
        echo "Error: Missing argument for option -h"
        exit 1
      fi
      host=$OPTARG
      ;;
    t)
      timeout=$OPTARG
      ;;
    c)
      count=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo "Usage: $0 [-h TargetURI] [-t timeout] [-c count]"
      exit 1
      ;;
  esac
done

if [ -z "$host" ]; then
  echo "Error: Target host URI is required. [-h uri]" >&2
  exit 1
fi

echo "trying to ping $host $count times with timeout of $timeout seconds"

# Ping the host
ping -c "$count" -W "$timeout" "$host"
