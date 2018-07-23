#!/bin/bash

clock() {
    date "+%H:%M"
}

day(){
    date "+%b, %d"
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

mute(){
	if [[ $(amixer get Master | awk '/Mono:/ {print $6}') == "[off]" ]]; then
		echo "\uf026"
	else
		echo "\uf028"
	fi
}

volume(){
	echo -e "$(mute) $(amixer -c 0 get Master | awk '/Mono:/ {print $4}' | tr -d '[]%,')"
}

battery(){
	local level0=$(acpi --battery | grep 'Battery 0' | cut -d, -f2 | tr -d ' []%')
	local level1=$(acpi --battery | grep 'Battery 1' | cut -d, -f2 | tr -d ' []%')
	let "level = level0/2 + level1/2"
	if [[ $level > 80 ]]; then
		echo "\uf240 $level"
	elif [[ $level = 100 ]]; then 
		echo "\uf240 $level"
	elif [[ $level > 60 ]]; then
		echo "\uf241 $level"
	elif [[ $level > 40 ]]; then
		echo "\uf242 $level"
	elif [[ $level > 20 ]]; then
		echo "\uf243 $level"
	else
		echo "\uf244 $level"
	fi

}

bar0(){
    while true; do
	echo -e "%{F#000000}%{c}$(clock)"
    	sleep 1
    done
}

bar1(){
    while true; do
    	echo -e "%{F#000000}%{c}$(day)"
    	sleep 1
    done
}

bar2(){
    while true; do
	echo -e "%{F#000000}%{c}$(backlight)    $(network)    $(ac)"
    	sleep 1
    done
}

bar3(){
    while true; do
    	echo -e "%{F#000000}%{c}$(battery)  /  $(volume)"
    	sleep 1
    done
}

let "x = $1"
let "y = $2"

bar0 | lemonbar \
    -f "Walkway SemiBold:size=64" \
    -g 640x64+$x+$y \
    -B#00000000 &

let "y = 64 + $2"

bar1 | lemonbar \
    -f "Walkway SemiBold:size=32" \
    -g 640x64+$x+$y \
    -B#00000000 &

let "y = 196 + $2"

bar2 | lemonbar \
    -f "Font Awesome:size=32" \
    -g 640x64+$x+$y \
    -B#00000000 &

let "y = 320 + $2"

bar3 | lemonbar \
    -f "Walkway SemiBold:size=32" -f "Font Awesome:size=32" \
    -g 640x64+$x+$y \
    -B#00000000 
