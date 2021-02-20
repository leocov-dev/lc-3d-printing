include <../lib/BOSL2/std.scad>

$fn = 75;

RUBBER_THICKNESS = 1.5;

BRACKET_WIDTH = 15;
BRACKET_THICKNESS = 4;
BRACKET_SPLIT = 0.5;

HORN_SIZE = 12.75;

INTERF = 0.25;


module humpedRing(id, od) {

  attachable(d = od + BRACKET_THICKNESS, h = BRACKET_WIDTH, orient = LEFT) {

    difference() {
      zflip_copy()
      tube(
      h = BRACKET_WIDTH / 2,
      id = id,
      od1 = od + BRACKET_THICKNESS,
      od2 = od
      );

      yrot(90)
      cube([BRACKET_WIDTH, od + BRACKET_THICKNESS, BRACKET_SPLIT], anchor = CENTER);
    }

    children();
  }
}

module handlebarBracket(size, part = "top") {
  id = size + RUBBER_THICKNESS * 2;
  od = id + BRACKET_THICKNESS;
  hg_od = BRACKET_WIDTH - BRACKET_THICKNESS + 1;

  h_w = BRACKET_WIDTH / 1.4;
  t_w = BRACKET_WIDTH / 2.5;
  d_t = BRACKET_THICKNESS * 2.5;

  module half() {
    difference() {
      union() {
        half_of()
        humpedRing(id, od) {
          difference() {
            union() {
              back(id / 2 + t_w)
              attach(CENTER)
              cylinder(h = d_t, d = h_w, anchor = CENTER, orient = LEFT);

              back(id / 2)
              attach(CENTER)
              cube([d_t, t_w, h_w], anchor = FRONT);
            }

            slice = od + BRACKET_WIDTH * 2;
            cube([BRACKET_SPLIT, slice, BRACKET_WIDTH], anchor = CENTER);
          }
        }

        fwd(od / 2)
        right(INTERF)
        cylinder(h = BRACKET_WIDTH / 2 - INTERF, d = hg_od, anchor = BACK + TOP, orient = LEFT);

        up(BRACKET_SPLIT / 2)
        fwd(id / 2)
        right(INTERF)
        cube([BRACKET_WIDTH / 2 - INTERF, BRACKET_WIDTH / 2, (hg_od / 2) - (BRACKET_SPLIT / 2)], anchor = BACK + BOTTOM
        +
        LEFT);
      }

      fwd(od / 2)
      right(INTERF)
      cylinder(h = BRACKET_WIDTH / 2 - INTERF, d = hg_od + (INTERF * 100), anchor = BACK + TOP, orient = RIGHT);
    }
  }

  difference() {
    if (part == "top") {
      half();
    } else {
      zflip() mirror(LEFT) half();
    }

    fwd((od / 2) + hg_od / 2){
      #cylinder(h = BRACKET_WIDTH, d = 4.25, anchor = CENTER, orient = RIGHT);

      left(BRACKET_WIDTH / 2 - 3)
      cylinder(h = 4, d = 9.25, anchor = TOP, orient = RIGHT);

      right(BRACKET_WIDTH / 2 - 3){
        cylinder(h = 3, d = 8.25, anchor = TOP, orient = LEFT, $fn = 6);
      }
    }

    back((od / 2) + hg_od / 3){
      cylinder(h = BRACKET_WIDTH, d = 4.25, anchor = CENTER, orient = UP);

      down(BRACKET_WIDTH / 2 + 2)
      cylinder(h = 7, d = 9.25, anchor = TOP, orient = DOWN);

      up(BRACKET_WIDTH / 2 + 1){
        cylinder(h = 6, d = 8.25, anchor = TOP, orient = UP, $fn = 6);
      }
    }
  }
}

module hornBracket(size, part="top") {
  module thing() {
    id = size + RUBBER_THICKNESS * 2;
    od = id + BRACKET_THICKNESS;

    h_w = BRACKET_WIDTH / 1.75;
    t_w = BRACKET_WIDTH / 3;
    d_t = BRACKET_THICKNESS * 2;

    difference() {
      humpedRing(id, od) {
        yflip_copy() {
          difference() {
            union() {
              back(id / 2 + t_w)
              attach(CENTER)
              cylinder(h = d_t, d = h_w, anchor = CENTER, orient = LEFT);

              back(id / 2)
              attach(CENTER)
              cube([d_t, t_w, h_w], anchor = FRONT);
            }

            slice = od + BRACKET_WIDTH;
            cube([BRACKET_SPLIT, slice, BRACKET_WIDTH], anchor = CENTER);
          }
        }
      }

      yflip_copy() {
        back(id / 2 + t_w) {
          cylinder(h = d_t, d = 3.25, anchor = CENTER, orient = UP);

          up(d_t / 3)
          cylinder(h = 4.25, d = 6.25, anchor = BOTTOM, orient = UP);

          down(d_t / 4)
          cylinder(h = 4.25, d = 6.25, anchor = TOP, orient = UP, $fn = 6);
        }
      }
    }
  }
  if (part == "top") {
    half_of() thing();
  } else {
    half_of(v=DOWN) thing();
  }

}


module make(size) {
  moveUp = (size / 2) + RUBBER_THICKNESS + (BRACKET_THICKNESS * 1.4) + (HORN_SIZE / 2);

  color("coral") handlebarBracket(size, "top");

  yrot(180)
  left(30)
  color("orangered") handlebarBracket(size, "bottom");

  up(moveUp)
  zrot(90)
  hornBracket(HORN_SIZE, "bottom");

  left(30)
  hornBracket(HORN_SIZE, "top");
}

make(14);

back(60)
make(22);
