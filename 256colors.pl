#!/usr/bin/perl
# Author: Todd Larason <jtl@molehill.org>
# $XFree86: xc/programs/xterm/vttests/256colors2.pl,v 1.1 1999/07/11 08:49:54 dawes Exp $

# use the resources for colors 0-15 - usually more-or-less a
# reproduction of the standard ANSI colors, but possibly more
# pleasing shades

# colors 16-231 are a 6x6x6 color cube
for ($red = 0; $red < 6; $red++) {
    for ($green = 0; $green < 6; $green++) {
  for ($blue = 0; $blue < 6; $blue++) {
      printf("\x1b]4;%d;rgb:%2.2x/%2.2x/%2.2x\x1b\\",
       16 + ($red * 36) + ($green * 6) + $blue,
       int ($red * 42.5),
       int ($green * 42.5),
       int ($blue * 42.5));
  }
    }
}

# colors 232-255 are a grayscale ramp, intentionally leaving out
# black and white
for ($gray = 0; $gray < 24; $gray++) {
    $level = ($gray * 10) + 8;
    printf("\x1b]4;%d;rgb:%2.2x/%2.2x/%2.2x\x1b\\",
     232 + $gray, $level, $level, $level);
}


# display the colors

# first the system ones:
print "System colors:\n";
for ($color = 0; $color < 8; $color++) {
    print "$color\x1b[48;5;${color}m  \e[m  ";
}
for ($color = 8; $color < 16; $color++) {
    print "$color\x1b[48;5;${color}m  \e[m  ";
}
print "\x1b[0m\n\n";

# now the color cube
print "Colors:\n";
my $len = 0;
for ($color = 16; $color < 232; $color++) {
      $len += 7;
      $len = 7, print "\n" if $len > 85;
      my $show = $color;
      $show = " $show" if $show < 100;
      print "$show\x1b[48;5;${color}m  \e[m  ";
}
print "\n\n";


# now the grayscale ramp
print "Grayscale ramp:\n";
for ($color = 232; $color < 256; $color++) {
    print "$color\x1b[48;5;${color}m  \e[m  ";
    print "\n" if $color == 243;
}
print "\n";
