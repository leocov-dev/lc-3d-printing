include <../lib_utils.scad>
include <../../../repos/BOSL2/std.scad>
include <../../../repos/BOSL2/bottlecaps.scad>
///////////////////////////////////////////////////////////
// insert for desks with wire retention
//
///////////////////////////////////////////////////////////

$fn=75;
CUT_IN_HALF=false;

OD=21;  // mm
HEIGHT=25;  // mm
TH=2.5;  // mm

OR=OD/2;

module make(INTERF=0) {  difference() {
    union() {
      translate([0,0,HEIGHT])
        pco1881_cap(wall=TH);
      cylinder(h=HEIGHT, r=OR+INTERF);
    }
    
    translate([0,0,-1])
      cylinder(h=HEIGHT+5, r=OR-TH);
  }
}

half([OD*2, OD*2, HEIGHT*2], CUT_IN_HALF) {
  make();
  translate([0, 50, 0])
    make(-.15);
  translate([0, 50*2, 0])
    make(+.15);
}


