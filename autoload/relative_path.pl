#!/usr/bin/env perl
use strict;
use warnings;

my $p = $ARGV[0] . "/";
my $prefix = quotemeta($p);

while (<STDIN>) {
    s/[\r\n]//g;
    if ($_ eq "../") {
        print $_ . "\n";
        next;
    }
    if (/^$prefix(.*)$/) {
        $_ = $1 . "\n";
    }
    s%^\./%%;
    print;
}

