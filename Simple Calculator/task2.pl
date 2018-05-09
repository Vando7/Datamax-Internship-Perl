use strict;
use warnings;

# Input an operation, press enter, input value.
# It's tedious, I know.

my $sum = 0;
my $cmd = '';
my $tempVal = 0;
my $opFlag;

print "0\n";

while(){
  $cmd = <STDIN>;
  chomp($cmd);
  # Input operation.
  if($cmd eq 'exit' || $cmd eq 'q'){
    last;
  }
  # Input value.
  $tempVal = <STDIN>;
  chomp($tempVal);
  # Process this shit.
  if   ($cmd eq '+') { $sum += $tempVal;}
  elsif($cmd eq '-') { $sum -= $tempVal;}
  elsif($cmd eq '*') { $sum *= $tempVal;}
  elsif($cmd eq '/') { $sum /= $tempVal;}
  elsif($cmd eq '%') { $sum %= $tempVal;}
  else{ print "Invalid operation!\n";}

  print "=\n$sum\n";
}
