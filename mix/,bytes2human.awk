#!/usr/bin/awk -f
BEGIN {
    split("B,kiB,MiB,GiB", suff, ",")
}

{
    size=$1;
    rank=int(log(size)/log(1024));
    printf "%.4g%s\n", size/(1024**rank), suff[rank+1]
}
