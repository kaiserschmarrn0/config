#!/bin/bash

g(){
	echo "    "
}

backlight(){
	local level=$(xbacklight)
	if [[ $level == "100.000000" ]]; then
		echo "\ue1c2"
	elif [[ $level == "0.000000" ]]; then
		echo "\ue0e6"
	else
		echo "\ue1c3"
	fi
}

network(){
	if [[ $(iw wlp3s0 link) == "Not connected." ]]; then
		echo "\ue0b1"
	else
		echo "\ue107"
	fi
}

ac(){
	if [[ $(acpi | cut -d, -f1) == "Battery 0: Charging" ]]; then
		echo "\ue099"
	else
		echo "\ue0f7"
	fi
}

clock(){
	date "+%b %d %H:%M"
}

mute(){
	if [[ $(amixer get Master | awk '/Mono:/ {print $6}') == "[off]" ]]; then
		echo "\ue202"
	else
		echo "\ue203"
	fi
}

volume(){
	echo -e "$(mute)  $(amixer -c 0 get Master | awk '/Mono:/ {print $4}' | tr -d '[]%,')"
}

battery(){
	local level=$(acpi --battery | cut -d, -f2 | tr -d ' []%')
	if [[ $level > 80 ]]; then
		echo "\ue1ff  $level"
	elif [[ $level > 20 ]]; then
		echo "\ue1fe  $level"
	else
		echo "\ue1fd  $level"
	fi
}

update(){
	while true; do
		echo -e "%{F#839496}%{l}$(g)$(backlight)$(g)$(network)$(g)$(ac)%{c}$(clock)%{r}$(volume)$(g)$(battery)$(g)"
		sleep 1
	done
}

update | lemonbar \
	-f "tewi-8" -f "Siji-8" \
	-g 1366x24+0+0 \
	-B#071d22
	#-g 1366x24+0+0 \
