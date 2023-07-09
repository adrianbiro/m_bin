#!/usr/bin/perl
use strict;
use warnings;


while (<>) {
  s/\e\[?.*?[\@-~]//g; # Strip ANSI escape codes
  print;
}

#sed -E 's/(\\\[.*\\\])//g'
