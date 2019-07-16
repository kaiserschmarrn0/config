#!/bin/sh

while getopts ":si" opt; do
	case "$opt" in
		i) install -Dm755 me.sh "${PKG}/usr/bin/me"
			exit;;
		s) scrot -d 1 me-"$(date "+%H:%M:%S_%Y-%m-%d")".png &;;
		\?) echo "$OPTARG ?" >&2
			exit;;
	esac
done

os="$(lsb_release -si | tr '[:upper:]' '[:lower:]')"
mem="$(free -m | awk '/^Mem/ {printf $3}')"
pack="$(xbps-query -l | wc -l)"
sh="$(basename ${SHELL})"
wm="$(xwininfo -root | cut -s -d \" -f2)"
term="${TERM}"

bc="$(tput bold)"
rc="$(tput sgr0)"

cat << EOF

${rc}os:	${os}
${rc}mem:	${mem}
${rc}pack:	${pack}
${rc}term:	${term}
${rc}sh:	${sh}
${rc}wm:	${wm}

EOF
