#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors!
. ~/.dwm/bar/themes/gruvchad

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$green^ CPU"
	printf "^c$white^ ^b$black^ $cpu_val"
}

pkg_updates() {
    updates=$(checkupdates | wc -l)

	if [ "$updates" -eq "0" ]; then
		printf "^c$green^  Fully Updated"
    elif [ "$updates" -eq "1" ]; then
		printf "^c$green^  $updates"" update"
	else
		printf "^c$green^  $updates"" updates"
	fi
}

battery() {
	get_capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
    status="$(cat /sys/class/power_supply/BAT1/status)"

	if [ "$status" = "Charging" ] || [ "$status" = "Full" ] || [ "$status" = "Unknown" ]; then
	    printf "^c$blue^   $get_capacity"
	else
        if [ "$get_capacity" -ge "90" ]; then
            printf "^c$blue^    $get_capacity"
        elif [ "$get_capacity" -ge "70" ]; then
            printf "^c$blue^    $get_capacity"
        elif [ "$get_capacity" -ge "50" ]; then
            printf "^c$blue^    $get_capacity"
        elif [ "$get_capacity" -ge "25" ]; then
            printf "^c$blue^    $get_capacity"
        elif [ "$get_capacity" -ge "10" ]; then
            printf "^c$blue^    $get_capacity"
        else
            printf "^c$blue^    $get_capacity"
        fi
	fi
}

brightness() {
	printf "^c$red^   "
	printf "^c$red^%.0f\n" $(xbacklight -get)
}

mem() {
	printf "^c$blue^^b$black^  "
	printf "^c$darkblue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

clock() {
	printf "^c$white^ 󱑆 "
	printf "^c$white^ $(date '+%a %d/%m %I:%M:%S %p') "
}

while true; do

	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
	interval=$((interval + 1))

	sleep 1 && xsetroot -name "$updates      $(battery)      $(brightness)      $(cpu)      $(mem)      $(clock)      "
done
