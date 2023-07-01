#!/usr/bin/awk -f
BEGIN {
	if (ARGC < 2) {
		printf("Run with minimum of two numeric arguments, to get average.\n")
		exit(1)
	}

	for (i = 1; i < ARGC; i++) {
		if (ARGV[i] !~ /^[.[:digit:]]+$/) {
			printf("Err: Argument #%d invalid.\n", i)
			exit(1)
		}

		sum += ARGV[i]
	}

	printf("Avg: %.2f\n", sum / (ARGC - 1))
}