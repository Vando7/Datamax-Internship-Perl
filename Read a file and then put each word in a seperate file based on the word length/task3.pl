use strict;
use warnings;
# Put each word with a file assigned to its length.
open(my $file,"<","test.txt");
while(my $line=<$file>){
  chomp($line);
  open(my $tmpHandle,">>", "words with length of ".(length($line)));
  print $tmpHandle $line , "\n";
};
