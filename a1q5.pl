use strict;
use Math::Round;
use POSIX 'ceil';
my $filename = 'test_html.txt';

open( FH, '<', $filename ) or die $!;

my $line_string;
my $line_count;
my $tag_start;
my $tag_end;
my $tag_comment_start;
my $tag_number;
my $tag_len;
my $tag_aver_len;
my @tag_len_stack = ();
my $tag_len_max;
my $tag_len_min;
my $sum;
while ( my $line = <FH> ) {    
    for my $i ( 1 .. length $line ) {
        my $char = substr( $line, $i - 1, 1 );
       
        if ( $char eq "<" ) {
            if(substr($line, $i,3) eq "!--"){
               $tag_comment_start = 1; 
            }else{
                $tag_start = 1;
                $tag_end   = 0;
            }
            
            
        }elsif ( $char eq ">" ) {
            if ( $tag_start == 1 ) {
                
                if($tag_comment_start == 0){
                    $tag_number++;
                    $tag_end = 1;
                    push( @tag_len_stack, $tag_len+1 );
                    $tag_start = 0;
                }elsif(substr($line, $i-3,2) eq "--"){
                    $tag_start = 0;
                    $tag_comment_start = 0;
                }
                
            }
        }

        if ( $tag_start == 1 ) {
            
            if($tag_comment_start == 0){
               $tag_len++;  
            }
            
        }
        if ( $tag_end == 1 ) {
            $tag_len   = 0;
            $tag_start = 0;
        }

    }

   
}
$tag_len_max = 0;
$tag_len_min = @tag_len_stack[0];

for my $j (@tag_len_stack){
    if($j >= $tag_len_max){
        $tag_len_max = $j;
    }
    if($j < $tag_len_min){
        $tag_len_min = $j;
    }
    $sum = $sum + $j;
}
if($tag_number != 0){ 
   $tag_aver_len = $sum/$tag_number;
}


$tag_aver_len =  ceil($tag_aver_len * 100 ) / 100;

print("Tag count: ".$tag_number. "\n");
print("Min length: ".$tag_len_min. "\n");
print("Max length: ".$tag_len_max. "\n");
print("Avg length: ".$tag_aver_len);

close(FH);
