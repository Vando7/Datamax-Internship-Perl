use strict;
use warnings;
# Task: input an array of scalars and after that remove the repeating ones.
# Limitation: The removal process can be done in only one loop.

print "How many variables do you want to input ?\n";
my $variableCount = <STDIN>;
chomp($variableCount);

print "Input:\n";
my %variableHash=();
my @variableArray=();

while($variableCount > 0){
  --$variableCount;
  my $tempVar = <STDIN>;
  chomp($tempVar);
  # If an element has been added, skip the push to the array.
  if($variableHash{$tempVar}++){ next;}
  push (@variableArray, $tempVar);
}

if(@variableArray){
   local $" = "\t";
   print "Output: ",join(" ",@variableArray),"\n";
}
