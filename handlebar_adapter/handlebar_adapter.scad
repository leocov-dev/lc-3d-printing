include <../lib_utils.scad>

////////////////////////////////////////////////////////////////
// adapter for thin handle bars
///////////////////////////////////////////////////////////////
$fn=50;

OR=21/2;
IR=13/2;
TH=16;
SPACE=1;

module make(){
  difference() {
    mirror_copy(){
      translate([0,0,TH/2])
        cylinder(h=1, r1=OR, r2=OR+0.75);
      cylinder(h=TH/2, r=OR);
    }
    cylinder(h=TH*2, r=IR, center=true);
    cube([OR*2+OR, SPACE, TH*2], center=true);
  }
  
}

make();