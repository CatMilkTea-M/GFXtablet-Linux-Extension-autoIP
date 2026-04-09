#!/bin/bash

cd "$(dirname "$0")"

IP=$(ip route | grep "src 10.37.141." | awk '{for(i=1;i<=NF;i++) if($i=="src") print $(i+1)}' | head -n 1)

if [ -z "$IP" ]; then
	notify-send "Network None" "No IP Connected." -i dialog-warning
	killall networktablet
	sleep 1
	notify-send "vTablet Server" "Stoped." -i dialog-information
else
	./networktablet &
fi
if [ ./networktablet & ]; then
	notify-send "Network Info" "Now IP: $IP" -i network-transmit-receive
	sleep 1
	notify-send "vTablet Server" "Working Now." -i dialog-information
fi
