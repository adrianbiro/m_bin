#!/usr/bin/awk -f
# Parses a markdown formatted file to gather work progress data
BEGIN { csvfile = "/home/adrian/Documents/workprogress.csv" }

{
    char = char + length($0)
    words = words + NF
}

NF == 0 { paragraph++ }     # blank line

$1 ~ /^#{1,6}/ { sections++ }

END {
    printf "%s,%s,%s,%s,%s,%s,%s,%s\n",
          toupper(FILENAME), strftime( "%Y-%m-%d", systime()),
          NR, words, char, paragraph, (char / 1800), sections >> csvfile

    printf \
"%s lines, %s words, %s characters, %s paragraphs, %s standard pages, %s sections\n",

    NR, words, char, paragraph, (char / 1800), sections
}
