#!/usr/bin/env perl
# with improved formatting same as http://www.zorranlabs.com/blog/?p=59
my @ps = `ps aux`;
my @headers = split(/\s+/, shift(@ps));
my %users;

foreach (@ps) {
  chomp;
  my $col = 0;
  my %ps_entry;
  foreach (split(/\s+/, $_, $#headers + 1)) {
    $ps_entry{$headers[$col]} = $_;
    $col++;
  }

  next unless exists $ps_entry{USER};
  $users{$ps_entry{USER}} = { 
    COUNT=>0, SIZE=>0, RSS=>0, MEM=>0, TIME=>0, CPU=>0 
    } unless exists $users{$ps_entry{USER}};
  my $user = $users{$ps_entry{USER}};

  $user->{COUNT}++;
  $user->{SIZE} += $ps_entry{VSZ} if exists $ps_entry{VSZ};
  $user->{RSS} += $ps_entry{RSS} if exists $ps_entry{RSS};
  $user->{MEM} += $ps_entry{'%MEM'} if exists $ps_entry{'%MEM'};
  $user->{CPU} += $ps_entry{'%CPU'} if exists $ps_entry{'%CPU'};
  $user->{TIME} += ($1 * 60) + $2 if (exists $ps_entry{'TIME'} && $ps_entry{'TIME'} =~ /^([0-9]+):([0-9]+)$/);
}

printf("%-7s%-11s%-15s%-9s%8s%10s%10s\n","COUNT","USER","VSZ(mb)","RSS(mb)","MEM(%)","TIME","CPU(%)");
foreach (sort { $users{$b}{CPU} <=> $users{$a}{CPU} } keys(%users)) {
  printf("%-7d%-11s%-15.2f%-11.2f%-12.1f%-10s%-10.1f\n",
    $users{$_}{COUNT}, 
    $_, 
    ($users{$_}{SIZE} / 1024 / 1024), 
    ($users{$_}{RSS} / 1024 / 1024), 
    $users{$_}{MEM}, 
    sprintf("%d:%d", ($users{$_}{TIME} / 60),($users{$_}{TIME} % 60)),
    $users{$_}{CPU});

}