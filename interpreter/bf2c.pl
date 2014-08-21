#!/usr/bin/env perl

use strict;
use warnings;

# Headers and Footers for the C program:
my $C_HEADER = "int main() {
char array[1024];
char *ptr=array;";
my $C_FOOTER = "\n}";
my %C_BODY = (
	'>'	=> "++ptr;\n",
	'<'	=> "--ptr;\n",
	'+'	=> "++*ptr;\n",
	'-'	=> "--*ptr;\n",
	'.'	=> "putchar(*ptr);\n",
	','	=> "*ptr=getchar();\n",
	'['	=> "while (*ptr) {\n",
	']'	=> "}\n",
);

# Get the file name:
if ($#ARGV == -1) {
	die "Not enough arguments! $!"
}
my $fName = shift(@ARGV);
my $cName = "$fName.c";

open BFILE, "<", "$fName" or die $!;
open CFILE, ">", "$cName" or die $!;

# Find valid characters:
my @code;
my @validChars = ( '>', '<', '+', '-', '.', ',', '[', ']' );

while (defined (my $char = getc BFILE)) {
	push (@code, $char) if ($char ~~ @validChars)
}
close BFILE or die $!;

# Write header:
print CFILE "$C_HEADER";

# Write body:
foreach my $char (@code) {
	print CFILE $C_BODY{$char};
}

# Write footer:
print CFILE "$C_FOOTER";

close CFILE or die $!;




