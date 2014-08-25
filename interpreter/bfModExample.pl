#!/usr/bin/env perl
# This script converts zafar.bf to zafar.c

# Add the current directory to the path:
BEGIN {push @INC, './'}

# Using the Brainfuck library:
use Brainfuck;

# Load the BF file:
my $fh = Brainfuck::bfLoad("zafar.bf");

# Clean up all the comments:
my @c = Brainfuck::bfClean($fh);

# Convert the code to C:
my @cc = Brainfuck::bfBody(@c);

# Write the C code (including the header/footer)
Brainfuck::bfWrite("zafar.c", @cc);

print "\nConversion complete!\n";
print "Run the following to compile:\n";
print "\t\$ gcc zafar.c\n";
