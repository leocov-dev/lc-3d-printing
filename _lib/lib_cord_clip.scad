include <../_lib/BOSL2/std.scad>

module cordClip(d = 3, offset = 0) {
  MIN_WALL = 3.25;
  wallCalc = (d / 5) * 2;
  wall = (wallCalc > MIN_WALL) ? wallCalc : MIN_WALL;

  diff("mask")
  cube([d + wall, d, offset > 0 ? offset : 0.01], anchor = BOTTOM){
    attach(TOP) {
      difference() {
        cube([d + wall, d, d + wall], anchor = BOTTOM);

        up(wall / 2){
          cylinder(d = d + $slop, h = d, orient = BACK, anchor = CENTER + BACK){
            fwd((d) / 2)
            cube([d + $slop, d, d], anchor = CENTER);
          }
        }
      }

      xflip_copy()
      left((d + $slop) / 2)
      up(d + wall)
      bottom_half()
      right_half()
      xscale(1 / 3)
      zscale(1.75)
      cylinder(d = d / 1.75, h = d, orient = BACK, anchor = CENTER);

      xflip_copy()
      left((wall + d) / 2)
      up(wall + d)
      rounding_mask(l = d * 2, r = wall / 4, orient = FRONT, anchor = CENTER, $tags = "mask");

      xflip_copy()
      left(((d + $slop) / 2) - (d / 1.75 / 2 / 3))
      up(wall + d)
      rounding_mask(l = d * 2, r = wall / 4, orient = FRONT, anchor = CENTER, $tags = "mask");
    }
  }

}
