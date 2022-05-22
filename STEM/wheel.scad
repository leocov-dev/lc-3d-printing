use <../_lib/lib_utils.scad>
include <../_lib/BOSL2/std.scad>

$fn = 100;

WHEEL_RAD = 17.5;
WHEEL_WIDTH = 15;
TH = 1.5;
AXEL_DIAMETER = 4.2;

TH_2 = TH * 1.5;

module wheel() {
  difference() {
    union() {
      cylinder(r = WHEEL_RAD, h = TH);

      tube(
      or = WHEEL_RAD,
      ir = WHEEL_RAD - TH,
      h = WHEEL_WIDTH
      );

      tube(
      od = AXEL_DIAMETER + TH_2,
      id = AXEL_DIAMETER,
      h = WHEEL_WIDTH/1.15
      );

      up(TH)
      tube(
      or = WHEEL_RAD - TH,
      ir1 = WHEEL_RAD - TH_2,
      ir2 = WHEEL_RAD - TH,
      h = TH_2/2
      );

      up(TH)
      tube(
      od1 = AXEL_DIAMETER + (TH_2 * 2),
      od2 = AXEL_DIAMETER + TH_2,
      id = AXEL_DIAMETER,
      h = TH_2/2
      );
    }

    chamfer_cylinder_mask(
    r = WHEEL_RAD,
    chamfer = TH,
    orient = DOWN
    );
  }
}

//front_half()
wheel();
