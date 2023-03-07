include <../vendor/BOSL2/std.scad>
include <clamp.scad>

$fn = 75;

POLE_D = 23;
RUBBER_T = 1.5;

STOP_D = 40;
STOP_T = 6;

module make(){
  clamp(POLE_D, 3, 15);
}

make();
