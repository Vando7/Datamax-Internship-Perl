use strict;
use warnings;
# This was written before I knew hashes were a thing.
open(my $file,"<","text.txt");

my @words ;
my @sentence ;
my @counts ;
my $maxLen = 0 ;
my $flag = 0;

while(my $line = <$file> ){
  chomp($line);
  @sentence = split(/ /,$line);

  for(my $i = 0; $i < @sentence; ++$i ){
    if( length($sentence[$i]) > $maxLen ){
      @words = ();
      @counts = ();
      $counts[0]=1;
      $maxLen = length ($sentence[$i]);
      push (@words, $sentence[$i]);
    }
    else{
      #===================
      if(length ($sentence[$i]) == $maxLen){
        $flag = 1;
        for(my $j = 0; $j < @words ; $j++ ){
          if($sentence[$i] eq $words[$j]){
              ++$counts[$j];
              $flag = 0;
              last;
          }
        }
        if($flag){
          push (@words, $sentence[$i]);
          push (@counts, 1);
        }
      }
      #===================
    }
  }
}
# Endless brackets !
my $maxIdx = 0;
my $maxCount= 0;

for(my $i = 0; $i < @counts ; ++$i ){
  if($counts[$i]>$maxCount){
    $maxIdx = $i;
    $maxCount = $counts[$i];
  }
}

print "\nThe longest word in the text file is \"$words[$maxIdx]\" and occurs $counts[$maxIdx] time(s).\n\n"
