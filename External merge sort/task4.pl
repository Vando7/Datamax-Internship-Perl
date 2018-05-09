use strict;
use warnings;
# Welcome to the clusterfuck.
# Task: Sort a file that cannot be loaded into memory cuz it's too big.
# The file that will be sorted must have one number per row.
my $fileToSort = "test";
open my $mainFile, "<", $fileToSort.".txt" or die;

my $bufferSize = 4;       # Can be set to 1000 or whatever.
my $totalElements = 0;    # Total amount of elemets to be sorted.
my $bufferCounter = 0;
my $tempFileCounter = 0;

my @tempFiles = ();
my @tempArray = ();

# --------| Split the main file to a bunch of smaller sorted chunks.
while(my $slurp = <$mainFile> ){
  chomp($slurp);
  # Open the N-th temporary file.
  open($tempFiles[$tempFileCounter],">>","tmpFile".$tempFileCounter);
  push(@tempArray,$slurp);

  ++$bufferCounter;
  # Check wether the buffer is full.
  if( $bufferCounter >= $bufferSize){
    # Sort temporary array and write to N-th file.
    @tempArray = sort{$a <=> $b} @tempArray;
    for(my $i = 0; $i < $bufferSize ; ++$i){
      print {$tempFiles[$tempFileCounter]} $tempArray[$i],"\n";
    }
    $totalElements += @tempArray;
    # Reset working variables.
    $bufferCounter = 0;
    ++$tempFileCounter;
    @tempArray = ();
  }
}

# In case we left over some elements hanging in the temp array.
if(@tempArray < $bufferSize && @tempArray > 0){
  @tempArray = sort{$a <=> $b} @tempArray;
  for(my $i = 0; $i < @tempArray ; ++$i){
    print {$tempFiles[$tempFileCounter]} $tempArray[$i],"\n";
  }
  $totalElements += @tempArray;
  ++$tempFileCounter;
  @tempArray = ();
}
close($mainFile);

# --------| Start building the sorted file.
open(my $sFile,">","$fileToSort-Sorted");
my @sieve = ();
my $min = 9007199254740992;
# Initialize a starter array. Read the first element of each temp. file.
for(my $i = 0; $i < $tempFileCounter ; ++$i){
  open($tempFiles[$i],"<","tmpFile".$i);
  my $var = readline($tempFiles[$i]);
  chomp ($var);
  # Set minimal element from the ones read.
  if($min > $var){
    $min = $var;
  }
  $sieve[$i]=$var;
}

# Each cell in the @sieve array represents a file. If the file has been read we
# start to ignore it. Just like how we ignore global warming and the rise of the
# cucumber price.
my @ignore = ();
for(my $i = 0; $i < @sieve ; ++$i){$ignore[$i] = 0;}

# Find the smallest number and write it to the sorted file.
while(--$totalElements+1){
  for(my $i = 0; $i < @sieve ; ++$i){
    if($ignore[$i]){next;}  # You rebel.
    # If the element of the i-th file is the minimal, add to sorted file and
    # read next element in file.
    if($sieve[$i] == $min){
      print $sFile $min,"\n";
      my $var = readline($tempFiles[$i]);

      # If the variable is undef then the file has been read.
      if(!($var)){
        $ignore[$i]=1;
        $min = 9007199254740992;
      }
      else{
        chomp($var);
        $sieve[$i] = $var;
        $min = $var;
      }
    }
  }
  # Find the next minimal element.
  for(my $i = 0; $i < @sieve ; ++$i){
    if($ignore[$i]){next;}
    if($sieve[$i] < $min){
      $min = $sieve[$i];
    }
  }
}

# Delete temporary files.
for(my $i=0;$i<@tempFiles;++$i){
  unlink "tmpFile$i";
}
print "Sorting done, file saved to $fileToSort-Sorted.txt\n\n";
