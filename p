#!/usr/bin/env perl
if (@ARGV) {
    exec "prove -wlr --timer -j 4 @ARGV";
}
else {
    exec "prove -wlr --timer -j 4 --state=hot,slow,save t";
}

