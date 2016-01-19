use warnings;
use strict;
use File::Slurp;



# Les inn fil og legg i en array
my $file = read_file('timestamp.csv');
my @array = split('\n',$file);


#Open output-fil
my $filename = "timestampPerl.csv";
open my $out, '>', $filename or die "$!";


# Konverter tidspunkt
foreach my $array(@array) {
my $time = scalar(localtime($array));
my $time2 = $time."\n";
print $out $time2; 
}
chomp $out;
close $out;
