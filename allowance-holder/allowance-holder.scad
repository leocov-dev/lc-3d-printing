include <../_lib/BOSL2/std.scad>

$fn = 100;
$slop = 0.4;

WALL_THICKNESS = 3;

module arch(th, l, h, r) {
  up(h)
  cube([l - (r * 2), th, th], anchor = TOP);

  xflip_copy() {
    left(l / 2)
    cube([th, th, h - r], anchor = BOTTOM + LEFT);

    difference() {
      right((l / 2) - r)
      up(h)
      cylinder(th, r = r, orient = FRONT, anchor = BACK);

      right((l / 2) - r)
      up(h-th)
      cylinder(th, r = r-th, orient = FRONT, anchor = BACK);

      right((l / 2) - r)
      up(h-r)
      pie_slice(ang=270, l=th, r=r*1.25, spin=90, orient=FRONT, anchor=CENTER);
    }
  }
}

module cutout(w, d, h) {
  cube([w, d, h], anchor = BOTTOM) {
    attach(FRONT) cylinder(d = w, h, anchor = CENTER, orient = FRONT);
    attach(BACK) cylinder(d = w, h, anchor = CENTER, orient = FRONT);
  }
}

module coinStack(d, h) {
  difference() {
    union() {
      //      cylinder(WALL_THICKNESS, d = d, anchor = BOTTOM);

      difference() {
        cylinder(h, d = d + WALL_THICKNESS, anchor = BOTTOM);
        cylinder(h, d = d, anchor = BOTTOM);
      }
    }

    fwd(d / 2)
    cutout(d / 2, d / 2, h);
  }

  tags("mask")
  fwd(d / 2)
  down(h)
  cutout(d / 2, d / 2, h * 2);
}

module CoinCaddy(w, d) {
  arch(WALL_THICKNESS * 4, w * 0.8, 55, 40);

  diff("mask")
  cube([w, d, WALL_THICKNESS], anchor = TOP)
  {
    yflip_copy() {
      // quarters
      fwd(22){
        left(14.25)
        coinStack(26, 30);
        right(14.25)
        coinStack(26, 30);
      }
      // dimes
      fwd(25) {
        left(39.5)
        coinStack(19, 30);
        left(60)
        coinStack(19, 30);
      }
      // nickles
      fwd(23.5) {
        right(40)
        coinStack(22, 30);
      }
      // pennies
      fwd(24) {
        right(63)
        coinStack(20, 30);
      }
    }
  }
}

module BillTray(w, d, h) {
  difference() {
    cuboid(
      [w + (WALL_THICKNESS * 2) + ($slop * 2),
          d + (WALL_THICKNESS * 2) + ($slop * 2),
        h + WALL_THICKNESS],
    rounding = 2,
    edges = [FRONT + LEFT, FRONT + RIGHT, BACK + LEFT, BACK + RIGHT],
    anchor = BOTTOM
    );

    up(WALL_THICKNESS)
    cube(
      [w + ($slop * 2),
        d + ($slop * 2),
        h + WALL_THICKNESS],
    anchor = BOTTOM
    );

    xflip_copy()
    left(w / 2)
    zrot(90)
    cutout(20, 20, h + WALL_THICKNESS);
  }

}

up(80)
CoinCaddy(160, 70);

//BillTray(160, 70, 40);
