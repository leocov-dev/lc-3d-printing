use <../lib/lib_utils.scad>
include <../lib/BOSL2/std.scad>

$fn = 100;
$slop = 0.4;

module connector_pins_negative() {
  yflip_copy() back(22.5) cylinder(d=2.5+$slop, h=3.5+$slop);
}

module cargo_box() {
  WALL=2;
  D_OFF=3.5+$slop+WALL;

  difference() {
    cube([21, 95, 22], anchor = BOTTOM);
    up(D_OFF)
    prismoid(size1=[21-WALL*4, 95-WALL*4], size2=[21-WALL, 95-WALL], h=22-D_OFF, anchor=BOTTOM);
    //cube([21-WALL, 95-WALL, 22-WALL], anchor=BOTTOM );
    connector_pins_negative();
  }
}

module fake_tube(h=10, r=3) {
  INDENT=h*0.3;

  difference() {
    cylinder(h = h, r = r, anchor = BOTTOM, orient = FRONT);
    fwd(h - INDENT)
    cylinder(h = INDENT, r1 = r * 0.75, r2= r * 0.9, anchor = BOTTOM, orient = FRONT);


    cylinder(h = INDENT, r2 = r * 0.75, r1= r * 0.9, anchor = BOTTOM, orient = FRONT);
  }
}


module cargo_tubes() {

  difference() {
    union() {
      yflip_copy()
      up(5) {
        up(8.3) fake_tube(h = 95 / 2, r = 5);
        xflip_copy()
        left(5) fake_tube(h = 95 / 2, r = 5);
      }
      prismoid(size1=[21 / 2, 95 / 1.5], size2=[21 / 3.5, 95 / 1.5], h=22 / 3, anchor = BOTTOM);
    }
//    cube([25,1, 40], anchor=BOTTOM);
    connector_pins_negative();
  }
}

//left_half()
//left(40)
cargo_box();

//left_half()
//cargo_tubes();
