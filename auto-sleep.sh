#!/bin/bash
# Inspiration taken from https://danielpgross.github.io/friendly_neighbor/howto-sleep-wake-on-demand#1-on-the-server
logged_in_count=$(who | wc -l)
# We expect 2 lines of output from `lsof -i:548` at idle: one for output headers, another for the
# server listening for connections. More than 2 lines indicates inbound connection(s).
afp_connection_count=$(lsof -i:548 | wc -l)
if [[ $logged_in_count < 1 && $afp_connection_count < 3 ]]; then
	systemctl suspend
else
	echo "Not suspending, logged in users: $logged_in_count, connection count: $afp_connection_count"
fi
