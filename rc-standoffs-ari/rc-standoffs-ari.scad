include <../_lib/BOSL2/std.scad>

$fn = 100;
$slop = 0.2;

WALL_THICKNESS = 4;


module pinAligner(w, l, th, pinDia, pinSpacing) {
  tags("keep") {
    diff("hole") {
      cuboid(
        [w, l, th],
      rounding = th / 4,
      edges = [FRONT + LEFT, BACK + LEFT, BACK + RIGHT],
      anchor = BOTTOM
      );

      yflip_copy()
      fwd(pinSpacing / 2)
      cylinder(d = 3.5, h = th * 2, anchor = BOTTOM, $tags = "hole");
    }
  }

  cuboid(
    [w, l, th],
  rounding = th / 4,
  edges = [FRONT + LEFT, FRONT + RIGHT, BACK + LEFT, BACK + RIGHT],
  anchor = BOTTOM,
  $tags = "sub"
  );
}

module socket(h, od, id, hole) {
  down(h - WALL_THICKNESS) {
    tags("keep") {
      diff("hole") {
        up(h / 2)
        cylinder(d = hole, l = od * 2, orient = LEFT, anchor = CENTER, $tags = "hole");

        tube(od = od, id = id, h = h, anchor = BOTTOM);
      }
    }
  }
}

module standoff(w, l, th) {

  pinSpacing = 6;
  pinAlignerWidth = 8;
  pinAlignerLength = 14;
  pinAlignerHole = 3.5;
  socketInner = 5;
  socketOuter = socketInner * 2;
  socketHeight = 10;
  socketScrewHole = 2;

  union() {
    diff("sub", keep = "keep") {
      pinAligner(pinAlignerWidth, pinAlignerLength, th, pinAlignerHole, pinSpacing);


      back(l)
      right(w){
        socket(socketHeight, socketOuter, socketInner, socketScrewHole);
        cylinder(d = socketOuter - 0.01, h = socketHeight, anchor = BOTTOM, $tags = "sub");
      }

      back(l)
      cube([100, 100, WALL_THICKNESS], anchor = BOTTOM + FRONT, $tags = "sub");

      back(pinSpacing / 2) {
        union() {
          left(WALL_THICKNESS)
          wedge([th, l + (WALL_THICKNESS * 6), w + (WALL_THICKNESS * 2)], orient = LEFT, anchor = TOP + LEFT);


          back(.001)
          right((pinAlignerWidth / 2) - .001)
          zrot(180)
          wedge([th, pinAlignerLength - (pinAlignerWidth / 2), w], anchor = FRONT + BOTTOM + LEFT, orient = LEFT);
        }
      }

      right(w+WALL_THICKNESS)
      back(l)
      wedge([th, l/1.25, socketOuter - (WALL_THICKNESS/4)], spin=180, orient = LEFT, anchor= RIGHT + FRONT + BOTTOM);
    }

    up(WALL_THICKNESS)
    right(pinAlignerHole)
    fwd((pinSpacing/2) + (pinAlignerHole/2))
    wedge([WALL_THICKNESS, l / 2, socketHeight*1.25], orient = DOWN, anchor = RIGHT + BOTTOM + FRONT);
  }
}

yrot(180) {
  xflip_copy()
  right(8)
  standoff(2.5, 63.5, WALL_THICKNESS);


//  xflip_copy()
//  left(8)
//  fwd(16)
//  zrot(180)
//  standoff(11.5, 79, WALL_THICKNESS);
}
