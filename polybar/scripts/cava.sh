#! /bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="/tmp/polybar_cava_config"
echo "
[general]
bars = 14
bar_height = 2
sensitivity = 95

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7


[color]
gradient = 1

gradient_color_1 = '#ff014f'   # vivid magenta red (keep)
gradient_color_2 = '#c98b9f'   # soft rose (keep)
gradient_color_3 = '#b37dbc'   # muted lavender-magenta
gradient_color_4 = '#9c7fd3'   # violet-purple
gradient_color_5 = '#7f8cf0'   # cool blue-violet
gradient_color_6 = '#69b4f2'   # bright sky blue
gradient_color_7 = '#6bd3e5'   # aqua-cyan blend
gradient_color_8 = '#80f5c0'   # minty end tone

" > $config_file

# read stdout from cava
cava -p $config_file | while read -r line; do
    echo $line | sed $dict
done
