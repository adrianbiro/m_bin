#!/usr/bin/awk -f

# The script will dynamically determine the schema of the table by examining the first
# or second record (a line) - if the first one is the header.
# If there is different number of  fields (a columns) in folowing records,
# all that exceded are just ignored, and if there is less then set,
# script will sum them from the left most.
# So for corect results, use clean data.
# It check if value is numeric (float, fraction or integer)
# and then prevent from counting character strings onto final result.
function is_num(n) {
    sign = "[+-]?"
    decimal = "[0-9]+[.]?[0-9]"
    digit = "[0-9]"
    fraction = "[.][0-9]"
    number = "^" sign "(" decimal "|" fraction "|" digit ")" "+$"
    return (n ~ number)  # ^[+-]?([0-9]+[.]?[0-9]|[.][0-9]|[0-9])+$
}

NR==1 {
    while (i<=NF) {
        p = is_num($i);                 # if all fields are character, this record is heading
        hnum = hnum + p;                # regex returns 0 for strings
        i++ }
    start = (hnum >= 1)? 1: 2;          # start counting NR after heading
}


NR==start {
    nfld = NF                           # preserve for END
    for (i=1; i <= NF; i++)
        numcol[i] = is_num($i)          # mark if is number
}

{
    for (i=1; i <= NF; i++)
        if (numcol[i])                  # If is number
            sum[i] += $i                # add to sum for apropriate column.
}

END {
    for (i=1; i <= nfld; i++) {
        if (numcol[i])
            printf("%g", sum[i])        # %.6f 123456789.123456789 > 123456789.123457
        else                            # default %g [.] > 1.23457e+08; 12345.123 > 12345.1
            printf("--")                # For loop prints out all in one line.
        printf(i < nfld ? "\t" : "\n")  # Separation handler, if it is the last record put \n.
    }
}
# The idea, this one-liner can't handle irregularities like a
# random character in a column or count all fields at once.
# $ awk -F'\t' '{num = num + $2} END{print num}' co.tsv
# 25681
# ******************************
# $ echo -e "A S D\na 12 1.3274\ns 54 9.3547\nq +9 8.2\nP -80 -20\n L +6 .2\nY Y Y\n9 o o\n      \nO o o\nmore more more 9\nl \n \np o o"
# A S D
# a 12 1.3274
# s 54 9.3547
# q +9 8.2
# P -80 -20
#  L +6 .2
# Y Y Y
# 9 o o
#
# O o o
# more more more 9
# l
#
# p o o
# $ !! | awk -f sumcol.awk
# --	1	-0.9179

