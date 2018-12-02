#!/bin/bash

g(){
	echo "            "
}

p(){
	echo "      "
}

backlight(){
	local level=$(xbacklight)
	if [[ $level == "100.000000" ]]; then
		echo "\uf005"
	elif [[ $level == "0.000000" ]]; then
		echo "\uf006"
	else
		echo "\uf123"
	fi
}

network(){
	if [[ $(iw wlp3s0 link) == "Not connected." ]]; then
		echo "\uf08a"
	else
		echo "\uf004"
	fi
}

ac(){
	if [[ $(acpi | grep -o 'Discharging' | cut -d, -f1) == "Discharging" ]]; then
		echo "\uf1e6"
	else
		echo "\uf0e7"
	fi
}

clock(){
	date "+%b %d %H:%M"
}

mute(){
	if [[ $(amixer get Master | awk '/Mono:/ {print $6}') == "[off]" ]]; then
		echo "\uf026"
	else
		echo "\uf028"
	fi
}

volume(){
	echo -e "$(mute)    $(amixer -c 0 get Master | awk '/Mono:/ {print $4}' | tr -d '[]%,')"
}

battery(){
	local level0=$(acpi --battery | grep 'Battery 0' | cut -d, -f2 | tr -d ' []%')
	local level1=$(acpi --battery | grep 'Battery 1' | cut -d, -f2 | tr -d ' []%')
	let "level = level0 * 3/10 + level1 * 7/10"
	if [[ $level > 80 ]]; then
		echo "\uf240    $level"
	elif [[ $level > 60 ]]; then
		echo "\uf241    $level"
	elif [[ $level > 40 ]]; then
		echo "\uf242    $level"
	elif [[ $level > 20 ]]; then
		echo "\uf243    $level"
	else
		echo "\uf244    $level"
	fi
}

update(){
	while true; do
		#echo -e "%{F#81a1c1}%{B#3b4252}%{l}$(g)$(backlight)$(g)$(network)$(g)$(ac)$(g)%{r}%{B#3b4252}$(g)$(volume)$(g)$(battery)$(g)%{B#bf616a}%{F#eceff4}$(g)$(clock)$(g)%{B#003b4252}"
		echo -e "%{F#3b4252}%{B#81a1c1}%{l}$(g)$(backlight)$(g)$(network)$(g)$(ac)$(g)%{r}%{B#81a1c1}$(g)$(volume)$(g)$(battery)$(g)%{B#bf616a}%{F#eceff4}$(g)$(clock)$(g)%{B#C03b4252}"
		sleep 1
	done
}

update | lemonbar \
	-f "IBM Plex Sans Regular:size=12" -f "Font Awesome:size=14" \
 -g 1920x32+0+1048 \
	-B#C03b4252
	#-g 1920x33+0+0 \
#-g 1366x24+0+0 \
