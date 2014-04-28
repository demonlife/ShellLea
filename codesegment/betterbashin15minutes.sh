#!/bin/bash

set -o nounset
set -o errexit

#####functions usage start
ExtractBashcomments() {
    #find comments
    egrep "^\s*#[^!]"
}

#cat betterbashin15minutes.sh | ExtractBashcomments | wc
comments=$(ExtractBashcomments < betterbashin15minutes.sh)
#echo "comments = $comments"

SumLines() { # iterating over stdin - similar to awk
    local sum=0
    local line=""
    while read line ; do
        sum=$((${sum} + ${line}))
    done
    #echo ${sum}
}

#SumLines < data_one_number_perline.txt
log() { #classic logger
    local prefix="[$(date +%Y-%m-%d\ %H:%M:%S)]" #the \ must need
    #echo "${prefix} $@" >&2
}

log "INFO" "a message"

#####functions usage end

##### variable start

#a useful idiom: DEFAULT_VAL can be overwritten with an enviroment variable of the same name
readonly DEFAULT_VAL=${DEFAULT_VAL:-7}
myfunc() {
    #initialize a local variable with the global default
    local some_var=${DEFAULT_VAL}
}

# note that it is possible to mark a variable read-only that wasn't before:
x=5
x=6
readonly x
# x=7 #failure
##### variable end

##### regular start
t="abc123"
[[ "$t" == abc* ]] # true(globbing)
[[ "$t" == "abc*" ]] # false, literal matching
[[ "$t" =~ [abc]+[123]+ ]] #true, regular expression
[[ "$t" =~ "abc*" ]] # false, literal matching

#Note, that starting with bash version 3.2 the regular or globbing expression
#must not be quoted. If your expression contains whitespace you can store it in a variable:
r="a b+"
[[ "a bbb" =~ $r ]]

#Globbing based string matching  is also available via the case statement:
case $t in
    abc*) echo "abc*";;
esac
##### regular end

##### string start
f="path1/path2/file.txt"
flen="${#f}" # len=2, string length

#slicing: ${<var>:<start>} or ${<var>:<start>:<length>}
slice1="${f:6}"
slice2="${f:6:5}"
slice3="${f: -8}"
pos=6
len=5
slice4="${f:${pos}:${len}}"

#subsitution(with globbing)
f="path1/path2/file.txt"
single_subst="${f/path?/x}" #x/path2/file.txt
global_subst="${f//path?/x}" #x/x/file.txt

#string splitting
readonly DIR_SEP="/"
array=(${f//${DIR_SEP}/ })
second_dir="${array[1]}" # path2

#deletion at beginning/end (with globbing)
f="path1/path2/file.txt"
# delete at string beginning
extension="${f#*.}"

# greedy deletion at string beginning
filename="${f##/}"

#deletion at string end
dirname="${f%/*}"

#greedy deletion at end
root="{$f%%/*}"
##### string end

##### temporary files

#diff <(wget -O - url1) <(wget -O - url2)
#Also useful are "here documents" which allow arbitrary multi-line string to be passed
#in on stdin. The two occurrences  of 'MARKER' brackets the document.
#'MARKER' can be any text.

#deleter is an arbitarry string
#command << MARKER
#...
#${var}
#$(cmd)
#...
MARKER
