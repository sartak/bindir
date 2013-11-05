#!/usr/bin/env perl
use strict;
use warnings;
use Imager::Color;

my $count = shift or die "usage: $0 count\n";
my $slice = 256 / $count;
for my $i (0 .. $count - 1) {
    my $hsv = Imager::Color->new(
        hsv =>  [ $i * $slice, 0.75, 0.75 ]
    );
    my ($r, $g, $b) = $hsv->rgba;
    printf "%2X%2X%2X\n", $r, $g, $b;
}

