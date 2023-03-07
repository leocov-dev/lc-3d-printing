include <../_lib/lib_utils.scad>
/////////////////////////////
// ANT TRAP BAIT CONTAINER //
/////////////////////////////

$fn = 40;
CUT_IN_HALF = false;

OD = 65;  // mm
HOLE = 40;  // mm
HEIGHT = 13;  // mm
TH = 6;  // mm

module make() {
  hole(d = HEIGHT, r = HOLE / 2 - 2, draft = 12, trans = [0, 0, HEIGHT + 3]) {
    hull() {
      cylinder(h = 1, d = OD);
      translate([0, 0, HEIGHT])
        cylinder(h = 1, d = HOLE + 2);
    }
  }
  rotate([0, - 90, 0])
    translate([0, OD / 2 - 10, - TH / 2])
      linear_extrude(TH)
        polygon([
        [0, 0],
        [0, 30],
        [22, 30],
        [22, 25],
        [20, 20],
        [16, 14.5],
        [12, 10],
        [9, 5],
        [7, 0]
        ]);
}

half([OD, OD, HEIGHT * 2], CUT_IN_HALF){
  make();
}
