#!/bin/bash
awk '!/\|/{ 
    printf "Quality: %s%%\n", int($3 * 100 / 70) 
}' /proc/net/wireless 
