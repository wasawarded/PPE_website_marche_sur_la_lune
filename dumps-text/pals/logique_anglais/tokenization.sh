#!/bin/sh
file=$1
grep -o -P '\p{L}+(\p{P}\p{L}+)+|\p{Nd}+|\p{L}+' $file > ./en_text_contexte_tokenized.txt

