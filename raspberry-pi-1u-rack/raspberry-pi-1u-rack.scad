use <../lib/lib_utils.scad>
use <../lib/lib_fan.scad>
include <../lib/BOSL2/std.scad>

$fn = 50;
H_1u = 44;  // 1u is 44.45mm
W_1u = 17.75 / 0.039370;// 19 inch rack
HOLE_INTERF=0.1;

//reference();


module make() {
  //  # translate([- 45, 0, 0]) cube([W_1u, 100, H_1u]);
  FRAME();
  TRAY();
  EAR();
}
make();


//////////
// TRAY //
//////////
module TRAY() {
  footprint();
  back(120) dupont1();

  color("coral") {
    _w = 58;
    _h = 6;
    _d = 92;

    _rim_c=150;
    _rim=12;
    _rim_d=_rim_c+_rim;
    _rim_edge=1;
    _rim_edge_mul=3;
    _rim_h2=_h*1.5;
    _rim_h=_rim_h2-_h+0.5;

    intersection() {
      back(_rim_c) {
        difference() {
          down(_h) cylinder(r = _rim_d, h = _rim_h2, $fn = 200);
          cylinder(r1 = _rim_d - (_rim_edge * _rim_edge_mul), r2 = _rim_d - _rim_edge, h = _rim_h, $fn = 200);
        }
      }
      left(_w / 2) down(_h * 1.5) fwd(_rim * 2) cube([_w, _d + (_rim * 2), _h * 3]);
    }
  }
}

module footprint() {
  back(26.5){
    _h = 2;
    _half = 49 / 2;
    xflip_copy() move_copies([[_half, 0, 0], [_half, 58, 0]]) standoff(h = _h, interf=HOLE_INTERF);

    translate([0, 19, _h]) pi(3);
  }
}
module standoff(h, interf = 0.1) {
  _base_width=2;
  difference() {
    union() {
      cylinder(d = 6, h = h);

      hull() {
        translate([0, 0, h - (h / 3)]) cylinder(h = 0.01, d = 6);
        cylinder(h = 0.01, d = 6 + _base_width);
      }
    }

    _d_bore = 2.7 + interf;
    _h_bore = h * 2;
    translate([0, 0, - (h / 2)]) cylinder(d = _d_bore, h = _h_bore);
  }
}

///////////
// FRAME //
///////////
module FRAME() {
  #up(22) back(150) rotate([90, 0, 0]) fan(40, 20, 32, 4);

  color("lightseagreen") {
    _w=72;
    _h=2;
    left(_w/2) down(_h) cube([_w,10,_h]);
  }
}

module dupont1() {
  cube([2.54, 14, 2.54]);
}

/////////
// EAR //
/////////
module EAR() {

}


// #####################################################################################################################
module reference() {
  up(9){
    back(11)
    left(36){
      mirror_copy(LEFT, 0, [215.9, 0, 0])
      translate([432, - 6, - 19])
        rotate([0, 90, 0]) {
          difference() {
            color("green")
              import("ref/raspberry-pi-rack-1u-ears.stl");
            translate([0, - 10, - 1])
              cube([60, 120, 30]);
          }
        }

      fwd(11){
        xcopies(72, n = 6, sp = [0, 0, 0])
        color("#4F7DCD")
          import("ref/raspberry-pi-rack-1u-frame.stl");


        translate([65, 85, 3])
          rotate([0, 0, 180])
            color("red")
              import("ref/raspberry-pi-rack-tray.stl");
      }
    }
  }
}

module pi(ver = 4) {
  if (ver == 4) {translate([- 28, 42.5, 1.5]) rotate([0, 0, - 90]) color("grey") import("../lib/ref/pi4.stl");}
  else if (ver == 3) {rotate([0, 0, - 90]) color("darkgrey") import("../lib/ref/pi3.stl");}
}
