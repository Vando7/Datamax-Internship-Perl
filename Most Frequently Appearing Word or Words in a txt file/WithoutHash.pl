use strict;
use warnings;

open(my $file,"<","text.txt");

my $maxLen = 0;
my @sentence = ();      # Store the words from each line here.
my %longestWord = ();   # Store the longest word and how much it occurs.
my $maxOccurences = 0;  # The maximum amount a word has been encountered.

# Read file. (isightful, I know.)
while(my $line = <$file>){
  @sentence = split(/ /,$line);
  chomp($sentence[-1]);
  for (@sentence){
    # If a word is longer than any of the ones before, clear hash and add it.
    if( length($_) > $maxLen){
      %longestWord = ();
      $longestWord{$_}++;
      $maxOccurences = 1;
      $maxLen = length($_);
    }
    # If a word is as long as the already longest word, add it to the hash.
    elsif( length($_) == $maxLen){
      $longestWord{$_}++;
      if($longestWord{$_} > $maxOccurences)  {
        $maxOccurences = $longestWord{$_};
      }
    }
  }
}
# Print the results.
my $flag = 0;
for(my @keys = keys %longestWord){
  # In case we have multiple words that occur the same amount of times.
  if ($flag) {
    print "Another word as long as the other one is ";
    print $_ if $longestWord{$_} == $maxOccurences;
    print " and it occurs $maxOccurences times.\n";
    next;
  }
  $flag = 1;
  print "Longest word in the text is ";
  print $_ if $longestWord{$_} == $maxOccurences;
  print " and it occurs $maxOccurences times.\n";
}
