include <../_lib/BOSL2/std.scad>
include <../_lib/BOSL2/hull.scad>
/////////////////////////////
// Aquarium fill diffuser  //
/////////////////////////////

$fn = 50;

FLOAT_DIA=18;
WALL=1.6;

module cap(angle) {
  capArc = arc(r=FLOAT_DIA/2, angle=-angle-15, start=90+5);

  difference() {
    path_extrude2d(capArc, caps = false)
    regular_ngon(n = 5, align_tip = FRONT, od = FLOAT_DIA);

    path_extrude2d(capArc, caps = false)
    regular_ngon(n = 5, align_tip = FRONT, od = FLOAT_DIA - (WALL * 2));
  }
}

module FillDiffuser(size=50) {
  tube(od=FLOAT_DIA, h=size, wall=WALL, anchor=CENTER+FRONT, orient=RIGHT, $fn=5);
  fwd(size/2)
  tube(od=FLOAT_DIA, h=size/2, wall=WALL, anchor=CENTER+BACK, orient=RIGHT, $fn=5);

  trapezoidAngle = adj_opp_to_ang(size / 2, size / 4);

  xflip_copy() {
    right(size / 2)
    zrot(90 - trapezoidAngle)
    tube(od = FLOAT_DIA, h = adj_opp_to_hyp(size / 2, size / 4), wall = WALL, anchor = TOP + BACK, orient = RIGHT, $fn=5);

    right(size / 2)
    cap(90 + trapezoidAngle);

    right(size / 4)
    fwd(size/2)
    yflip()
    cap(90 - trapezoidAngle);
  }

  fwd(size/4) {
    difference() {
      extrude_from_to([0, 0, 0], [0, 0, - (size / 4) - WALL], scale = 0.01)
      trapezoid(h = (size / 2) + (WALL * 4), w1 = (size / 2) + (WALL * 4), w2 = size + (WALL * 4), anchor = CENTER);

      extrude_from_to([0, 0, 0], [0, 0, - (size / 4)], scale = 0.01)
      trapezoid(h = (size / 2) + WALL, w1 = (size / 2) + WALL, w2 = size + WALL, anchor = CENTER);

      zflip()
      down(size/3)
      ovoid_spread(n=51, d=0.5, cone_ang=15, scale=[size/2,1,1])
      cylinder(d=4, h=200);
    }
  }
}

//left_half()
FillDiffuser(140);

//cube([200, 1, 1], anchor=CENTER);
