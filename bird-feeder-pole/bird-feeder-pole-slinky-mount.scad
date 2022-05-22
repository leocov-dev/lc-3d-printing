include <../vendor/BOSL2/std.scad>
include <../_lib/lib_screw.scad>

$fn = 75;

POLE_D = 23;
SLINKY_D = 62;
TRENCH_H = 9;
GAP = 1.5;
RUBBER_T = 1.5;
THICKNESS = 5;
LIP_THICKNESS = 8;

module coneShape(start_d, end_d) {
  angle_h = 15;

  cap_r = sqrt(pow(start_d / 2, 2) + pow(angle_h, 2));

  cylinder(d1 = end_d, d2 = start_d, h = angle_h)
  attach(BOTTOM, TOP) cylinder(d = end_d, h = 20);
}

module make() {

  difference() {
    union() {
      top_half(z = - 14)
      coneShape(POLE_D + THICKNESS, SLINKY_D);

      difference() {
        down(11) cylinder(d = SLINKY_D + LIP_THICKNESS, h = 3, anchor = TOP);
        down(12) right(30) xrot(4) cube([50, 100, 1], anchor = TOP);
      }
    }

    cylinder(d = POLE_D + RUBBER_T, h = 100, anchor = CENTER);

    cube([GAP, 100, 100], anchor = CENTER);

    yflip_copy()
    fwd(18) up(5) screw(4.3, 16, 8.1, 8.25);
  }

}

//half_of(RIGHT)
//half_of(BACK, -18)
make();
