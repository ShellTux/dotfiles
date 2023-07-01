#!/bin/sh

interface=$1
status=$2
if [ "$CONNECTION_UUID" = "uuid" ]
then
	case "$status" in
		up)   systemctl start sshd.service ;;
		down) systemctl stop sshd.service  ;;
	esac
fi
