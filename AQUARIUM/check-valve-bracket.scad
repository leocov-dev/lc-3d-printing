use <../_lib/lib_utils.scad>
include <../_lib/BOSL2/std.scad>

$fn = 100;

$slop = 0.05;
TH=2;

VALVE_R1 = 11/2;
VALVE_R2 = 13/2;


module valve_holder() {

  difference() {
    union() {
      tube(h = 15, ir1 = VALVE_R1 + $slop, ir2 = VALVE_R2 + $slop, wall = 2, anchor = BOTTOM);

      up(15)
      tube(h = 6, ir1 = VALVE_R2 + $slop, ir2 = VALVE_R2 + $slop - 0.5, wall = 2);

//      back(10)
//      color("green") prismoid(h = 15, size1 = [7, 7], size2 = [7, 5], shift = [0, 1]);

//      back(10.5) up(15)
//      color("lightgreen") cube(size = [7, 6, 6], anchor = BOTTOM);
    }

    fwd(7)
    color("pink") cube(size = [8, 8, 25], anchor = BOTTOM);
  }
}

module hose_clip(h=4, d=5.5, l=10) {
  wallTH=d/3;
  back(l-2)
  difference() {
    union() {
      fwd(3) color("red") cube(size = [6, l, h], anchor = BACK + BOTTOM);
      tube(h = h, ir = (d/2), wall = wallTH);
    }
    back(0) prismoid(h = (d/2)+wallTH*1.5, size1 = [4, h], size2 = [5, h], orient = BACK, anchor = BACK + BOTTOM);
  }
}


module make() {
  union() {
    fwd(4.25)
    up(15.2)
    xrot(- 40)
    union() {
      down(10) back(13)
      cube(size = [45, 3, 31], anchor = BOTTOM);

      xflip_copy()
      right(11)
      back(4)
      valve_holder();
    }


    prismoid(h = 14, size1 = [45, 13], size2 = [45, 3], shift = [0, 5], anchor = BOTTOM + FRONT);

    back(5.5)
    cube(size = [45, 15, 3], anchor = TOP);

    back(11.5)
    cube(size = [45, 3, 60], anchor = TOP);

//    xflip_copy()
//    left(11)
//    down(40) back(18)
//    hose_clip(h=8);
  }
}

//front_half()
make();
