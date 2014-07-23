#!/usr/bin/env bash

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))

# 所有变量都应该为局部的
change_owner_of_file() {
    local filename=$1
    local user=$2
    local group=$3
    chown $user:$group $filename
}

# 代码中唯一的全局命令是： main
# 作为循环用的变量i， 将其声明为局部变量很重要
main() {
    local files="/tmp/a /tmp/b"
    local i
    for i in $files
    do
        # ...
    done
}

# 一切皆是函数
# 一行代码只做一件事情
temporary_files() {
    local dir=$1
    ls $dir \
        | grep pid \
        | grep -v daemon
}

