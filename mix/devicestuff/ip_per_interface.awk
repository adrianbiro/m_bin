#!/bin/bash

ifconfig | awk '
    /^\S/{
        sub(/\s.*$/,"",$O);
        printf "%s ", $0
    };
    /inet\s/{
        print $2
    }
'

