#!/bin/sh
awk 'BEGIN{ printf("%-7s %9s %9s %9s %9s %9s %9s\n","COUNT","USER","VSZ","RSS","MEMORY","TIME","CPU")}'
ps aux | awk '
NR == 1 {next}
#TODO fix values
{   user=$1
    users[user][COUNT] += 1
    users[user][CPU] += $2
    users[user][VSZ] += $3
    users[user][RSS] += $6
    users[user][MEM] += $4
    users[user][TIME] += $9 # TODO
}
END { 
  for (u in users) {
    printf("%7d%10s%10d%10d%10d%10d%10d\n", \
        users[u]['COUNT'], u, users[u]['VSZ'], users[u]['RSS'], users[u]['MEM'], users[u]['TIME'], users[u]['CPU'] )
    #printf("%7d  %10s\n", users[u]['COUNT'], u)
    #printf("%d%  s%  d%  %d  %d  %d  %d\n", \
    #    users[u]['COUNT'], u, users[u]['VSZ'], users[u]['RSS'], users[u]['MEM'], users[u]['TIME'], users[u]['CPU'] )
  } 
}' | sort -r -n -k 1,1