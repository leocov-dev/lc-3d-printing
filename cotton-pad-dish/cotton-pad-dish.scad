include <../lib/BOSL2/std.scad>
include <../lib/lib_utils.scad>

$fn = 75;

$slop = 0.4;

PAD_TH = 10;
PAD_D = 58;

TH = 2;

module dish() {
  union() {
    difference() {
      cylinder(h = PAD_TH + TH, d = PAD_D + (TH * 2));
      up(TH) cylinder(h = 1, r1 = (PAD_D - 1.5) / 2, r2 = PAD_D / 2);
      up(TH + 1) cylinder(h = PAD_TH, d = PAD_D);


      up(PAD_TH + TH - 1.5) cylinder(h = PAD_TH, d = PAD_D + TH);
    }

    intersection() {
      cylinder(h = PAD_TH + TH, d = PAD_D - 6);

      hexregion = circle(r = 40, $fn = 6);
      grid2d(spacing = 13, stagger = true, inside = hexregion) union() {
        up(TH) sphere(d = 3.5);
      }
    }
  }
}

module grid() {
  window_num = 10; // number of windows
  window_size = 8; // size of individual windows
  strut_size = TH; // size of the struts

  up(TH / 2){
    for (i = [0:window_num]) {
      rotate([90, 0, 90])
        translate([0, 0, ((window_size + strut_size) * i) - ((window_size + strut_size) * window_num / 2),])
          cube(size = [window_num * (window_size + strut_size), strut_size, strut_size], anchor = CENTER);
    }

    for (i = [0:window_num]) {
      translate([0, ((window_size + strut_size) * i) - ((window_size + strut_size) * window_num / 2), 0])
        cube(size = [window_num * (window_size + strut_size), strut_size, strut_size], anchor = CENTER);
    }
  }
}

module lid() {
  union() {
    difference() {
      cylinder(h = TH, d = PAD_D + TH - $slop);
      cylinder(h = TH, d = PAD_D - (TH * 1.5));
    }

    intersection() {
      cylinder(h = TH, d = PAD_D + TH - $slop);
      grid();
    }
  }
}

module make() {
  // cotton pad reference
//  up(4) cylinder(h = 6 - $slop, d = PAD_D - $slop);

//  up(PAD_TH + TH - 1.5) lid();

  dish();
}

//half([100, 100, 100], true)
make();
