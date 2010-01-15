#!/usr/bin/env perl -lap
BEGIN { $field = @ARGV ? shift(@ARGV) : die "Usage: $0 fieldnumber" }
$_ = $F[$field];

