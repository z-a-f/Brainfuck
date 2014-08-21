#!/usr/bin/env perl

# This script converts zafar.bf to zafar.c
BEGIN {push @INC, './'}
use Brainfuck;
my $fh = Brainfuck::bfLoad("zafar.bf");
my @c = Brainfuck::bfClean($fh);
my @cc = Brainfuck::bfBody(@c);
Brainfuck::bfWrite("zafar.c", @cc);

print "\nConversion complete!\n";
print "Run the following to compile:\n";
print "\t\$ gcc zafar.c\n";