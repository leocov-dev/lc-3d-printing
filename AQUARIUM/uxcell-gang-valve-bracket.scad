use <../lib/lib_utils.scad>
include <../lib/BOSL2/std.scad>

$fn = 100;

W = 45;
D = 14;
TH = 3;
H = 10;

module make() {
  cube(size = [W, TH * 3, H], anchor = BOTTOM)
  difference() {
    union() {
      //      cube(size = [W, TH * 3, H/1.5], anchor = BOTTOM)
      fwd(TH / 2) tube(h = W, ir = D / 2, wall = TH, anchor = BACK, orient = LEFT);

      //      back(3)
      //      cube(size = [W, TH * 1.5, H/2], anchor = BOTTOM);
    }

    union() {

      //      xflip_copy()
      //      left(12) up(12) cylinder(h=12, d=10, orient=FRONT, anchor=CENTER);
      //      # up(2.5) cube(size=[3,3,5], anchor=BACK);

      fwd(D) cube(size = [W, TH * 5, 12], anchor = BACK);
      fwd(D + 2) cube(size = [W, TH * 5, 40], anchor = BACK);

      cube(size = [W / 2, D + (TH * 3), D], anchor = BACK + TOP);

      xflip_copy()
      left(W / 3)
      cube(size = [W / 2.5, D + (TH * 2), D], anchor = BACK + BOTTOM);

    }
  }
  back(3/2) color("pink") prismoid(h=H, size1 = [W/3, TH * 3 + 3], size2 = [W, TH * 3 + 3], anchor = TOP);
}

make();
