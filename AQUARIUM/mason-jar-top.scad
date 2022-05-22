include <../_lib/BOSL2/std.scad>
include <../_lib/BOSL2/hull.scad>

$fn = 100;

$slop = 0.4;

module MasonJarTop(d=100, h=30) {
  lidThickness = 2.4;

  d2 = d-12;

  id = d2-adj_ang_to_opp(h, 45);

  difference() {
    union() {
      cylinder(d = d, h = lidThickness);

      cylinder(d1 = d2, d2 = id, h = h);
    }
    cylinder(d1 = d2-(lidThickness*2), d2 = id-(lidThickness*2), h = h);
  }
}



MasonJarTop(84, 20);
