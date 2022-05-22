include <../vendor/BOSL2/std.scad>
include <../vendor/BOSL2/hull.scad>
include <aqu-suction-cup-pin.scad>


// ALL VALUES IN MILLIMETERS

// ARC PRECISION
$fn = 50;

// PART INTERFERENCE/FIT COMPENSATION
$slop = 0.4;

/**
* FloatingPlantCorral
*/

MIN_HEIGHT = 37; // Should be slightly larger than suction cup diameter
STANDOFF = 8;
SUPPORT_D = 4; // Thickness of support structure beams
WALL_TH = 2; // Thickness of eyelet walls
TUBE_ID = 5; // Inner Diameter of aquarium tubing

module FloatingPlantCorralPIN() {
  FIT = $slop*6;

  TUBE_SLOP = TUBE_ID + $slop;

  color("#28a628")
  up(TUBE_SLOP/2) {
    //cyl(d = TUBE_SLOP, h = TUBE_SLOP * 3, rounding2 = TUBE_SLOP / 2, orient = LEFT, anchor = BOTTOM);
    cuboid(
      [TUBE_SLOP*3, TUBE_SLOP, TUBE_SLOP],
      chamfer=TUBE_SLOP/4,
      edges=[LEFT, FRONT+TOP, FRONT+BOTTOM, BACK+TOP, BACK+BOTTOM],
      anchor=RIGHT
    );

    ID = SUPPORT_D + FIT;

    left(WALL_TH/2)
    tube(h = TUBE_SLOP, od = ID + (WALL_TH * 1.5), id = ID, anchor = LEFT + CENTER);
  }
}

module FloatingPlantCorralEND(height = 50) {
  HEIGHT = (height > MIN_HEIGHT ? height : MIN_HEIGHT) + SUPPORT_D;
  CHAM = SUPPORT_D / 6;
  GAP = SUPPORT_D + SUPPORT_D + 4;

  color("#ff7676")
  up(MIN_HEIGHT) {
    cuboid(
      [SUPPORT_D, SUPPORT_D, HEIGHT],
    chamfer = CHAM,
    //      edges=[LEFT+FRONT, RIGHT+BACK, LEFT+BACK, RIGHT+FRONT, BOTTOM],
    anchor = CENTER + TOP
    );


    back((GAP / 2) - (SUPPORT_D / 2))
    down(HEIGHT)
    cuboid(
      [SUPPORT_D, GAP, SUPPORT_D],
    chamfer = CHAM,
    anchor = BOTTOM
    );

    back(GAP - SUPPORT_D)
    cuboid(
      [SUPPORT_D, SUPPORT_D, HEIGHT],
    chamfer = CHAM,
    edges = [LEFT + FRONT, RIGHT + BACK, LEFT + BACK, RIGHT + FRONT, BOTTOM, TOP + FRONT],
    anchor = CENTER + TOP
    );

    PIP=2;

    down(MIN_HEIGHT / 2 + PIP)
    back(GAP-(SUPPORT_D/2)) {

      up(MIN_HEIGHT/2)
      fwd(SUPPORT_D/2)
      cube([SUPPORT_D, STANDOFF+(SUPPORT_D/2), PIP], anchor=FRONT+BOTTOM);

      cube([SUPPORT_D, SUPPORT_D/2, MIN_HEIGHT], anchor = CENTER + BACK);

      down(MIN_HEIGHT/2)
      fwd(SUPPORT_D/2)
      cuboid(
        [SUPPORT_D, STANDOFF+(SUPPORT_D/2), HEIGHT-MIN_HEIGHT-PIP],
        chamfer=CHAM,
        edges=[BOTTOM+LEFT, BOTTOM+RIGHT, BACK+BOTTOM],
        anchor=TOP+FRONT
      );

      down(MIN_HEIGHT / 2)
      right_triangle([(MIN_HEIGHT / 2) - 4, STANDOFF, SUPPORT_D], orient = LEFT, anchor = LEFT + FRONT);

      up(MIN_HEIGHT / 2)
      right_triangle([(MIN_HEIGHT / 2) - 4, STANDOFF, SUPPORT_D], orient = RIGHT, anchor = LEFT + FRONT);


      intersection() {
        xrot(90)
        suctionCupPin();

        cube([SUPPORT_D, 10, 10], anchor = CENTER + FRONT);
      }
    }
  }
}

// RENDER

//front_half()
FloatingPlantCorralPIN();

right((SUPPORT_D/2) + WALL_TH/2) {
  FloatingPlantCorralEND(0);

  back(30)
  FloatingPlantCorralEND(45);

  back(30*2)
  FloatingPlantCorralEND(55);

  back(30*3)
  FloatingPlantCorralEND(65);
}
