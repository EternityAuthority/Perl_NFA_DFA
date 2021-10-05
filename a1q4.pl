use strict;

my $filename = 'test.txt';

open(FH, '<', $filename) or die $!;

my $email_count;

while (my $line = <FH>) { 
  foreach my $email (split /\s+/, $line) {
   
      if ( $email =~ /^[a-zA-Z]?\S+@\S+\.\S+$/ ) {
      
        print $email. "  ";
        print $line. "\n";
        $email_count++;
    
     }
  }

  
}


close(FH);