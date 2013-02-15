#!usr/bin/perl
#

open rFILE,"<","./Examples_Perl/iris.names" or die $!;
open wFILE, ">./Examples_Perl/file.txt" or die $!;
#binmode rFILE; 
my ($buf, $data, $n);

#while (($n = read rFILE, $data, 4) != 0) { 
#  print "\t$n bytes read\n"; 
#	print "$data";
#	print wFILE $data;
#	$buf .= $data; 
#}
my $lines=<rFILE>;


while (defined $lines){
	if ($lines=~/[Tt]itle/) {
		my @title=split(/^[*][:]/,$lines);
		print wFILE "\@RELATION @title";
	}
	$lines=<rFILE>;
	print $lines;
	
	if ($lines=~/[Aa]ttribute/) {
		$flag=1;
		while ($flag>0) {
			$lines=<rFILE>;
			if ($lines=~/^*[ ]*[0-9]\W/) {
				my @words = split(/^*[ ]*[0-9]\W/, $lines);
				print wFILE "\@ATTRIBUTE@words";
				
			} else {$flag=0;}
		}
	}
}



close(rFILE);
close wFILE;
