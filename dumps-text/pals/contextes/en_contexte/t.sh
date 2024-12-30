#!/bin/sh
n=1
while read text;
do
#     cat "/$text.txt" >> all.txt
    cat $text >> "./all.txt"
    n=$(expr $n + 1)
done < "./name.txt"
