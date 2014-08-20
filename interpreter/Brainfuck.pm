################################################################################
# This set of submodules are used for the Brainfuck code interpretation
#	v1.0 Zafar Takhirov 08/20/2014
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
@EXPORT_OK		= qw(bfLoad);		# Set functions to allow export
%EXPORT_TAGS	= ( DEFAULT	=> [qw(&bfLoad)] );	# Set function packs

###
# Load BF
###
sub bfLoad {
	print "@_";
}



1;





