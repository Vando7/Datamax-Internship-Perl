use strict;
use warnings;

my $sum = 0;
my $tempVal;
my %values=();

while(){
  $tempVal = <STDIN>;
  chomp($tempVal);

  if($tempVal =~ m/exit|q|quit/i){
    last;
  }

  if($values{$tempVal}++){
    print "\nThat number has already been entered. Clearing.\n";
    %values = ();
    $sum = 0;
    next;
  }

  $sum +=  $tempVal;
  print "Average so far is ", $sum/(keys %values) , ".\n";
}
