################################################################################
# This set of submodules are used for the Brainfuck code interpretation
#	v1.0 Zafar Takhirov 08/20/2014
#
# Usage example:
#	# This script converts zafar.bf to zafar.c
#	BEGIN {push @INC, './'}
#	use Brainfuck;
#	my $fh = Brainfuck::bfLoad("zafar.bf");
#	my @c = Brainfuck::bfClean($fh);
#	my @cc = Brainfuck::bfBody(@c);
#	Brainfuck::bfWrite("zafar.c", @cc);
################################################################################

package Brainfuck;

use strict;

use Exporter;
use vars qw(
	$VERSION
	@ISA
	@EXPORT
	@EXPORT_OK
	%EXPORT_TAGS
);

$VERSION		= "v1.00";
@ISA			= qw(Exporter);
@EXPORT			= ();		# What to export by default
@EXPORT_OK		= qw(bfLoad bfClean);		# Set functions to allow export
%EXPORT_TAGS	= ( DEFAULT	=> [qw(&bfLoad $bfClean)] );	# Set function packs

sub bfLoad {
	# Just loads the file
	my $name = shift;
	print "Reading file: $name\n";
	open FH, "<", "$name" or die $!;
	return *FH;
}

sub bfClean {
	# Cleans the code of any comments and junk
	my $FH = shift;
	print "Cleaning file...\n";
	my @code;
	my @validChars = ( '>', '<', '+', '-', '.', ',', '[', ']' );
	my $counter = 0;
	while (defined (my $char = getc $FH)) {
		if ($char ~~ '[') {
			$counter = $counter + 1;
		}
		if ($char ~~ ']') {
			$counter--;
		}
		push (@code, $char) if ($char ~~ @validChars);
	}
	die "[] do not match" if ($counter != 0);
	close $FH or die $!;
	# print @code;
	return @code;
}

sub bfBody {
	# Creates the body of the C file
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
	my @bfCode = @_;
	my @cCode;
	foreach my $char (@bfCode) {
		push (@cCode, $C_BODY{$char});
	}
	return @cCode;
}

sub bfWrite {
	# Write the C file:
	my $name = shift;
	my @code = @_;
	print "Writing file: $name\n";
	my $C_HEADER = "
int main() {
	char array[1024];
	char *ptr=array;";
	my $C_FOOTER = "
}\n";

	open FH, ">", "$name" or die $!;
	# Write header:
	print FH "$C_HEADER";

	# Write body:
	print FH "@code";

	# Write footer:
	print FH "$C_FOOTER";
	close FH;
}


1;





