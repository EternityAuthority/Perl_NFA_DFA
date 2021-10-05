my @sorted;
sub conc {
   my @unsorted;  
   push( @unsorted, @_[0]);
   push( @unsorted, @_[1]);
   my @sorted = sort @unsorted;

   return @sorted[0].@sorted[1];
}


print &conc('aaa','ccc');
print "\n";
print &conc('ccc','aaa');
print "\n";