include <../lib/BOSL2/std.scad>
include <../lib/lib_screw.scad>

WIDTH = 115;
DEPTH = 36;
HEIGHT = 150;

T = 10;

module make() {
  w_scale = 1.3;
  d_scale = 2;
  inset = 10;

  difference() {
    prismoid(size1 = [DEPTH + inset, WIDTH], size2 = [(DEPTH + inset) / d_scale, WIDTH / w_scale], h = HEIGHT);
    prismoid(size1 = [DEPTH + inset, WIDTH - T], size2 = [(DEPTH + inset) / d_scale, WIDTH / w_scale - T], h = HEIGHT);
  }
  prismoid(size1 = [DEPTH, WIDTH], size2 = [(DEPTH) / d_scale, WIDTH / w_scale], h = HEIGHT);
}

//make();
