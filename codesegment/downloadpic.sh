#!/bin/env bash

#https://longluo.github.io/blog/20140913/a-shell-script-used-to-download-the-imges-from-the-Internet/
#方法1
BASE_URL="https://s.yimg.com/zz/combo?a/i/us/nws/weather/gr/"

BIG_PNG="ds.png"
PNG=".png"

for ((i=0; i<49; ++i)); do
    curl ${BASE_URL}${i}${BIG_PNG} -o ${i}${PNG}
    sleep 1
done

#方法二
URL_ARRAY=(
    'http://s.yimg.com/zz/combo?a/i/us/nws/weather/gr/0d.png'
)

NAME_ARRAY=(
    'file1.jpg'
)

ELEMENTS=${#URL_ARRAY[@]}

for (( i=0; i<ELEMENTS; ++i));do
    curl ${URL_ARRAY[${i}]} -o ${NAME_ARRAY[${i}]}
    sleep 1
done
