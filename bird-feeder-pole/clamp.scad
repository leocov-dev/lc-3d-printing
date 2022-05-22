include <../vendor/BOSL2/std.scad>
include <../_lib/lib_screw.scad>

module clamp(d, t, h) {
  od = d+t*2;
  $slop = (d/2)/10;
  hinge_i = $slop/10;
  difference() {
    cylinder(d = od, h = h);
    cylinder(d=d, h=h);
    cube([od, $slop, h], anchor = BOTTOM);
  }

  hinge_d = 6;

  difference() {
    union() {
      difference() {
        right(d / 2) cube([(hinge_d / 2) + t + hinge_i, hinge_d, h], anchor = LEFT + BOTTOM);
        right(d / 2) back((hinge_d / 2)) cube([(hinge_d / 2) + t + hinge_i, (hinge_d / 2) + ($slop / 2), h], anchor =
        LEFT + BOTTOM
        + BACK);
      }

      right(od / 2 + hinge_i) cylinder(d = hinge_d, h = h, anchor = LEFT + BOTTOM);
    }
    up(h / 4 - hinge_i) right(d / 2) cube([hinge_d + hinge_i + t, hinge_d, h / 2 + hinge_i*2], anchor = BOTTOM + LEFT);
  }

  intersection() {
    union() {
      difference() {
        right(d / 2) cube([(hinge_d / 2) + t + hinge_i, hinge_d, h], anchor = LEFT + BOTTOM);
        right(d / 2) fwd((hinge_d / 2)) cube([(hinge_d / 2) + t + hinge_i, (hinge_d / 2) + ($slop / 2), h],
        anchor =
        LEFT + BOTTOM
        + FRONT);
      }

      right(od / 2 + hinge_i) cylinder(d = hinge_d, h = h, anchor = LEFT + BOTTOM);
    }
    up(h / 4) right(d / 2) cube([hinge_d + hinge_i + t, hinge_d, h / 2], anchor = BOTTOM + LEFT);
  }

}
