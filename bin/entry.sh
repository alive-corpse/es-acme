#!/bin/sh
set -eo > /dev/null

while true; do
    /opt/acme.sh/acme.sh --cron --home /home/acme/.acme.sh
    sleep 86400
done
