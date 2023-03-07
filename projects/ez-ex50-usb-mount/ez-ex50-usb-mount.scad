include <../vendor/BOSL2/std.scad>
include <../_lib/lib_utils.scad>

$fn = 75;

$slop = 0.3;

H = 22 + $slop;
W = 58.5 + $slop;
D = 53.5;

WALL_TH = 6;
EAR_TH = 4.5;
ONE_U = 44.45;

hole = 3.75;
edge = 4.75;
sep = 48;
sep_fb = 35;

module roundedHole() {
  D = 6.5;
  W = 11 - D;

  left(W / 2)
  cylinder(d = D, h = 10, orient = FRONT, anchor = CENTER);
  cube(size = [W, 10, D], anchor = CENTER);
  right(W / 2)
  cylinder(d = D, h = 10, orient = FRONT, anchor = CENTER);
}


module make() {

  difference() {
    union() {

      difference() {

        // SUROUNDING BOX
        difference() {
          cube(size = [W + WALL_TH, D, H + WALL_TH], anchor = CENTER + FRONT);
          cube(size = [W, D, H], anchor = CENTER + FRONT);
          right((W + WALL_TH) / 2) up((H + WALL_TH) / 2) rounding_mask_y(l = 100, r = 2, anchor = FRONT);
          right((W + WALL_TH) / 2) down((H + WALL_TH) / 2) rounding_mask_y(l = 100, r = 2, anchor = FRONT);
        }


        // MOUNTING HOLES
        union() {
          right(58.5 / 2) down((H + WALL_TH) / 2) {
            left(edge + ($slop / 2)) back(edge + ($slop / 2))
            cylinder(d = hole, h = WALL_TH * 2, anchor = CENTER) {
              left(sep)
              cylinder(d = hole, h = WALL_TH * 2, anchor = CENTER);
              back(sep_fb)
              cylinder(d = hole, h = WALL_TH * 2, anchor = CENTER);
              left(sep) back(sep_fb)
              cylinder(d = hole, h = WALL_TH * 2, anchor = CENTER);
            }
          }
        }
      }

      // RACK EAR
      left((W + WALL_TH) / 2) {
        difference() {
          cube(size = [30, EAR_TH, ONE_U], anchor = CENTER + RIGHT + FRONT);
          up(ONE_U / 2) left(30) rounding_mask_y(l = 100, r = 3, anchor = FRONT);
          down(ONE_U / 2) left(30) rounding_mask_y(l = 100, r = 3, anchor = FRONT);

          left(30 - 5.5 - 2.5) back(2) {
            off = 31.75 / 2;
            down(off)
            roundedHole();
            up(off)
            roundedHole();
          }
        }

        up((H + WALL_TH) / 2) right(23.5) xflip() angle_pie_mask(ang = 18.9, d = 50, l = EAR_TH, orient = FRONT, anchor
        = TOP);
        zflip() up((H + WALL_TH) / 2) right(23.5) xflip() angle_pie_mask(ang = 18.9, d = 50, l = EAR_TH, orient = FRONT,
        anchor
        = TOP);
        back(26) yflip() zrot(90) angle_pie_mask(ang = 18.9, d = 50, l = H + WALL_TH);
      }

    }

    right(edge + ($slop*2))
    left(58.5 / 2)
    back(edge + ($slop / 2))
    down((H+WALL_TH)/2) cylinder(d = hole * 2.2, h = WALL_TH * 2, anchor = CENTER + TOP);
    back(D / 2) cuboid([200, 42, 20], rounding = 5, edges = [FRONT, BACK], $fn = 2);
  }
};


make();
