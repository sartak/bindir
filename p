#!/usr/bin/env perl
if (@ARGV) {
    exec "forkprove -Mlib::require::all=lib,t -wlr --timer -j 4 @ARGV";
}
else {
    exec "forkprove -Mlib::require::all=lib,t -wlr --timer -j 4 --state=hot,slow,save t";
}

