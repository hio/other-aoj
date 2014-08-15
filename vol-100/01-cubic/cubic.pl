use strict;
use warnings;

caller or main();

sub main
{
  print cubic(read_num()), "\n";
}

sub read_num
{
  my $line = <>;
  chomp $line;
  $line =~ /^(\d+)$/ or die "invalid input: $line";
  $1;
}

sub cubic
{
  my $num = shift;
  $num * $num * $num;
}
