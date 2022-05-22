include <../_lib/BOSL2/std.scad>

$fn = 75;

ID = 15.5;
OD = 23;

DIAMETER = OD + 3;


module make() {

  difference() {
    half_of(TOP, [0,0,-10])
    intersection() {
//      cylinder(d = DIAMETER, h = 100, anchor = CENTER);
      up(6) zscale(1.5) sphere(d = DIAMETER * 1.25);
    }

    up(15) cylinder(d = OD, h = 25, anchor=TOP);
  }

  cylinder(d=ID, h=15);

  zrot_copies(n=4)
  rot(7, LEFT+FRONT, [0,0,-4])
  difference() {
    f_id = ID+0.25;
    fc_id = f_id-3;
    half_of(RIGHT, [1, 0, 0]) half_of(FRONT, [0, - 1, 0])
    cylinder(d = f_id, h = 8, anchor = TOP)
    attach(BOTTOM) sphere(d = f_id);

    cylinder(d = fc_id, h = 100, anchor = TOP);
  }

}

//half_of(RIGHT)
make();
