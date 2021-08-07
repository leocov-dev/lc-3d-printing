include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>

$fn = 100;

$interf = 0.05;
TH = 2.5;

W = 127;
D = 115;
H = 76;

module box(size = [5, 5, 5], wall = 1, rounding = 3) {
  width = size[0];
  depth = size[1];
  height = size[2];
  union() {
    cuboid(size = [width, depth, wall], anchor = BOTTOM, rounding = rounding, edges = [FRONT + RIGHT, FRONT + LEFT, BACK
      + RIGHT, BACK + LEFT]);

    rect_tube(size = [width, depth], wall = wall, h = height, rounding = rounding, irounding = rounding / 2);
  }
}

module therm_sub(length = 150, dia = 3.8) {
  union() {
    cylinder(d = dia, h = length, anchor = TOP)
    up(length / 2) cylinder(d1 = dia, d2 = dia * 2, h = 5, anchor = BOTTOM)
    up(2.5) cylinder(d = 7, h = 5, anchor = BOTTOM)
    up(2) sphere(d = 35, anchor = BOTTOM);
  }
}

module make() {
  difference() {
    union() {
      box(size = [W, D, H], wall = TH);
      fwd(D / 2 - TH) cube(size = [W, TH, H], anchor = BOTTOM + FRONT);
      fwd(D / 2 - TH - TH) cube(size = [W, TH, H], anchor = BOTTOM + FRONT);
      fwd(D / 2 - TH - TH - TH) cube(size = [W, TH, H], anchor = BOTTOM + FRONT);
      corner_size = 13;
      fwd(D / 2 - TH - TH - TH) left(W / 2) right((corner_size / 2))
      prismoid(size1 = [corner_size, H], size2 = [0, H], shift = [- (corner_size / 2), 0], h = corner_size, orient =
      BACK, anchor = BACK + BOTTOM);

      // walls width split
      right(W / 2 - 45) cube(size = [TH, D, H], anchor = BOTTOM);
      right(W / 2 - 102) cube(size = [TH, D, H], anchor = BOTTOM);

      // walls depth split
      fwd(D / 2 - TH - TH - TH - 38) left(W / 2) cube(size = [W - 102, TH, H], anchor = BOTTOM + LEFT);
    }

    color("red")
      fwd(D / 2 - (7 / 2) - 2.5) up(H - 1) left(W / 2) yrot(- 58) down(15)
      therm_sub();
  }
}


make();
