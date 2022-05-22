include <../_lib/BOSL2/std.scad>

$fn = 100;
$slop = 0.2;

WALL_THICKNESS = 3;

module holder(idTop, idBottom, h, sliceAng) {
  top = idTop + $slop;
  bot = idBottom + $slop;
  hyp = adj_ang_to_hyp(1, sliceAng);

  half_of([0, - 1, hyp - 1], cp = [0, (bot / 4), 0])
  diff("sub") {
    tube(h = h, wall = WALL_THICKNESS, id1 = bot, id2 = top, anchor=BOTTOM);

    tag("sub")
    cube([idBottom, top * 2, h], anchor = FRONT + BOTTOM);
  }
}

module bracket(id, h, off, hidT, hidB) {
  rot = 0;
  skew = id / 1.75;
  shift = id + WALL_THICKNESS + off;
  b_ang = adj_opp_to_ang(skew, shift);


  diff("sub2") {
    fwd(skew)
    right(shift/1.275) {
      diff("sub") {
        tube(h = h, id = id, wall = WALL_THICKNESS, anchor=BOTTOM);

        tag("sub")
        pie_slice(ang = 360 - 50, l = h, r = id, spin = 180 - rot);
      }

      cube([WALL_THICKNESS * 2, shift, h], anchor = FRONT + BOTTOM, spin = b_ang);

      tag("sub2")
      cyl(h = h, d = id, anchor = BOTTOM);
    }

    tag("sub2")
    cyl(h = h, d1 = hidB, d2 = hidT, anchor = BOTTOM);
  }


}

module make(curve) {
  holder(41, 31, 35, 35);
  bracket(curve, 35, 0, 41, 31);
}

//make(48);
make(85);
