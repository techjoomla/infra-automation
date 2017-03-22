#!/bin/bash

set -e

distro_family="$1"

case "${distro_family}" in
    redhat)
        cron_file_path=/var/spool/cron/root
        ocsinventory_binary="/usr/sbin/ocsinventory-agent"
        ;;
    debian)
        cron_file_path=/var/spool/cron/crontabs/root
        ocsinventory_binary="/usr/bin/ocsinventory-agent"
        ;;
esac

echo "Run the inventory and display it in the terminal"
${ocsinventory_binary} --stdout

echo "Run the inventory and store it on disk"
${ocsinventory_binary} --local=/var/lib/ocsinventory-agent

echo "Check inventory was done and inventory file created"
if [ $(find /var/lib/ocsinventory-agent/ -name "*.ocs" | wc -l) -ne 1 ]; then
    echo "ERROR: The inventory report has not been created."
    exit 1
fi

echo "Check report XML"
find /var/lib/ocsinventory-agent/ -name "*.ocs" -print0 | xargs -0 -n1 xmllint > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "ERROR: The inventory report is not a well formed XML."
    exit 1
fi

echo "Check cronjob creation"
grep ocsinventory-agent-test-install "${cron_file_path}" > /dev/null 2>&1 || (echo "ERROR: Cronjob seems to not have been created." && exit 1)