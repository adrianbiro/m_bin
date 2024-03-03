#!/bin/bash
awk --bignum -v PREC=100 '
BEGIN {
    split("B,kiB,MiB,GiB,TiB,PiB,EiB,ZiB,YiB", suff, ",")
}

{
    size=$1;
    rank=int(log(size)/log(1024));
    printf "%.4g%s\n", size/(1024**rank), suff[rank+1]
}
'