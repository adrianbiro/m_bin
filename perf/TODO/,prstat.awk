#!/bin/sh
{ awk 'BEGIN{ print("COUNT","USER","VSZ","RSS","MEMORY","TIME","CPU")}'

ps aux | awk ' 
NR == 1 {next}
#TODO fix values
{   
    user=$1
    #users[sprintf("%s,%s",$1,"COUNT")] += 1
    #users[sprintf("%s,%s",$1,"NAME")] = $1
    users[user][COUNT] += 1
    users[user][CPU] += $2
    users[user][VSZ] += $3
    users[user][RSS] += $6
    users[user][MEM] += $4
    users[user][TIME] += $9 # TODO
}
END { 
  for (u in users) {
        print( users[u]['COUNT'], u, users[u]['VSZ'], users[u]['RSS'], users[u]['MEM'], users[u]['TIME'], users[u]['CPU'] )
        #print users[sprintf("%s,%s",u,"COUNT")], users[sprintf("%s,%s",u,"NAME")]
    #printf("%7d  %10s\n", users[u]['COUNT'], u)
    #printf("%d%  s%  d%  %d  %d  %d  %d\n", \
    #    users[u]['COUNT'], u, users[u]['VSZ'], users[u]['RSS'], users[u]['MEM'], users[u]['TIME'], users[u]['CPU'] )
  } 
}' | sort -r -n -k 1,1 ;}| column --table

# BEGIN {
    # split("B,kiB,MiB,GiB", suff, ",")
# }

# {
    # size=$1;
    # rank=int(log(size)/log(1024));
    # printf "%.4g%s\n", size/(1024**rank), suff[rank+1]
# }
