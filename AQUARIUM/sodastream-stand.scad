include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>

$fn = 100;
INTERF = 0.6;
WALL=3;

FOOT_FAC=2.5;

module SodastreamStand() {
  dia = 60;
  height = 60;

  od = 60+(WALL*2);

  start = WALL;
  increment = height/4;

  scale_fac=1.15;

  difference() {
    union() {
      hull() {
        cube([od * FOOT_FAC, od, WALL], anchor = CENTER + BOTTOM);

        up(start + increment)
        xscale(scale_fac)
        cylinder(d = od, h = 0.1, anchor = TOP);
      }

      hull() {
        up(start + increment)
        xscale(scale_fac)
        cylinder(d = od, h = 0.1, anchor = TOP);

        up(height)
        xscale(1)
        cylinder(d = od, h = 0.1, anchor = TOP);
      }
    }

    up(WALL)
    cylinder(d = dia + INTERF, h = height);
  }
}

SodastreamStand();