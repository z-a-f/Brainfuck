#!/usr/bin/env perl

use strict;
use warnings;

# print "$ARGV\n"

# (Program Start) 	char array[infinitely large size];
# 					char *ptr=array;
# > 				++ptr;
# < 				--ptr;
# + 				++*ptr;
# - 				--*ptr;
# . 				putchar(*ptr);
# , 				*ptr=getchar();
# [ 				while (*ptr) {
# ] 				}

my $C_HEADER = "int main() {
char array[255];
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
my $fName = shift(@ARGV);
my $cName = "$fName.c";

print "Opening: $fName\n";
open BFILE, "<", "$fName" or die $!;
print "Opening: $cName\n";
open CFILE, ">", "$cName" or die $!;

my @code;
my @validChars = ( '>', '<', '+', '-', '.', ',', '[', ']' );

while (defined (my $char = getc BFILE)) {
	push (@code, $char) if ($char ~~ @validChars)
}
close BFILE or die $!;

# Write header:
print CFILE "$C_HEADER";

foreach my $char (@code) {
	print CFILE $C_BODY{$char};
}

# Write footer:
print CFILE "$C_FOOTER";

close CFILE or die $!;
