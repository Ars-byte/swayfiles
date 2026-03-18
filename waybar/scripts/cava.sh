#!/bin/bash

killall -q cava

config_file="/tmp/waybar_cava_config"

cat > "$config_file" << 'CONF'
[general]
bars = 8
framerate = 60

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7

[smoothing]
integral = 70
monstercat = 1
CONF

cava -p "$config_file" | while IFS= read -r line; do
    out=$(printf '%s' "$line" | tr -d ';' | sed \
        -e 's/0/ /g' \
        -e 's/1/▁/g' \
        -e 's/2/▂/g' \
        -e 's/3/▃/g' \
        -e 's/4/▄/g' \
        -e 's/5/▅/g' \
        -e 's/6/▆/g' \
        -e 's/7/█/g')
    printf '%s\n' "$out"
done
