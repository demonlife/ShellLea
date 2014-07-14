#!/bin/bash
#vim: set sw=4 ts=4 et:

help() {
    cat <<EOF
b2d -- covert binary to decimal
usage: b2d [-h] binarynum
options: -h help text
example: b2d 111010
will return 58
EOF
    exit 0
}

error() {
    # print an error and exit
    echo "$1"
    exit 1
}

# cut 的用法： cut -b 3: 截取第3个字符， cut -b -3: 第一个到倒数第3个字符
# echo "abc" | cut -b 1 => a, echo "abc" | cut -b -2 => ab
lastchar() {
    # return the last character of a string in $rval
    if [ -z "$1" ]; then
        # empty string
        rval=""
        return
    fi

    #wc puts some space behind the output this is whe we need sed:
    numofchar=`echo -n "$1" | sed 's/ //g' | wc -c`
    # now cut out the last char
    rval=`echo -n "$1" | cut -b $numofchar`
}

chop() {
    if [ -z "$1" ]; then
        # empty string
        rval=""
        return
    fi

    #wc puts some space behind the output this is mhy we need sed:
    numofchar=`echo -n "$1" | wc -c | sed 's/ //g'`
    if [ "$numofchar" = "1" ]; then
        # only one char in string
        rval=""
        return
    fi

    numofcharminus1=`expr $numofchar "-" 1`
    # now cut all but the last char:
    rval=`echo -n "$1" | cut -b -$numofcharminus1`
    # 原来的rval= `echo -n "$1"|cut -b 0-$numofcharminus1` #运行时出错
    # 原因是cut从1开始计数， 应该是cut -b 1-${numofcharminus}

}

while [ -n "$1" ]; do
    case $1 in
        -h) help; shitf 1;; #function help is called
        --) shift; break;; # end of options
        -*) error "error: no such option $1. -h for help";;
        *) break;;
    esac
done

# the main program
sum=0
weight=1

# one arg must be given;
[ -z "$1" ] && help
binnum="$1"
binnumorig="$1"

while [ -n "$binnum" ]; do
    lastchar "$binnum"
    if [ "$rval" = "1" ]; then
        sum=`expr "$weight" "+" "$sum"`
    fi
    # remove the last position is $binnum
    chop "$binnum"
    binnum="$rval"
    weight=`expr "$weight" "*" 2`
done

echo "binary $binnumorig is decimal $sum"
#
    
    
