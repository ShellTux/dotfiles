#!/usr/bin/env bash

killall swhks

swhks & pkexec swhkd --config "$XDG_CONFIG_HOME/swhkd/swhkdrc"
