#!/bin/bash

nbins=$(xpath -q -e "count(Binaries/Binary)" $1)

for i in `seq 1 1 $nbins`
do
    offset=$(xpath -q -e "string(Binaries/Binary[$i]/@Offset)" $1)
    length=$(xpath -q -e "string(Binaries/Binary[$i]/@Length)" $1)
    filename=$(dirname $1)/$(xpath -q -e "string(Binaries/Binary[$i]/@FileName)" $1)
    echo "$filename:"
    dd if=$2 bs=1 skip=$((offset+16)) count=$length iflag=skip_bytes,count_bytes of=$filename
    echo
done
