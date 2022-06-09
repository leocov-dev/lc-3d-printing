include <../vendor/BOSL2/std.scad>
include <../vendor/BOSL2/joiners.scad>

$fn = 100;
// fitment ajuster
$slop = 0.6;

// thickness of the 3d print walls
WALL_THICKNESS = 2;

BALL_DIAMETER = 76;
BELT_WIDTH = 40;
BELTH_THICKNESS = 4.8;
NUB_LEN = 12;
NUB_FWD = 16;
NUB_UP = 3.5;
ARM_ARC = 88;

RAD = (BALL_DIAMETER / 2) + WALL_THICKNESS + $slop;
CLIP_H = RAD + (WALL_THICKNESS * 2) + $slop;
CLIP_W = RAD / 1.5;
CLIP_ROUNDING = CLIP_W / 20;

module pokeball_holder_clip(diameter, belt_width, belt_thickness) {
  color("green") {
    back(RAD + WALL_THICKNESS) {
      cuboid([CLIP_W, WALL_THICKNESS, CLIP_H], rounding = CLIP_ROUNDING, anchor = CENTER + BACK, edges = [BOTTOM + LEFT,
          BOTTOM + RIGHT]);

      up(CLIP_H / 2)
      back(belt_thickness / 2)
      top_half()
      tube(h = CLIP_W, od = belt_thickness + (WALL_THICKNESS * 2), id = belt_thickness, orient = RIGHT);

      xrot(- 90)
      grid2d(size = [CLIP_W - (belt_thickness * 2), CLIP_H - (belt_thickness * 2)], n = [5, 6], stagger = "alt")
      top_half()
      sphere(r = belt_thickness / 4);

      CURVE_OR = 400;
      diff("clip") {
        up(CLIP_H / 2)
        back(belt_thickness + WALL_THICKNESS)
        tube(h = CLIP_W, or = CURVE_OR, wall = WALL_THICKNESS, orient = RIGHT, anchor = BACK, $fn = 200){
          tag("clip")
          pie_slice(ang = 352.75, h = CLIP_W + 5, r = CURVE_OR + 5, anchor = CENTER, spin = 90);
        }
      }

      back(belt_thickness)
      up((CLIP_H/4) - (CLIP_H/12))
      xrot(90)
      grid2d(size = [CLIP_W - (belt_thickness * 2), (CLIP_H / 2) - (belt_thickness * 2)], n = [5, 3], stagger = "alt")
      top_half()
      sphere(r = belt_thickness / 3.5);

      //      down(belt_thickness / 2)
      //      back(belt_thickness)
      //      cuboid([CLIP_W, WALL_THICKNESS, CLIP_H + belt_thickness], anchor = CENTER + FRONT);

      down((CLIP_H/2) + 3.5)
      back(belt_thickness-1.9)
      cylinder(h = CLIP_W, d = belt_thickness, orient = RIGHT, anchor = CENTER + BACK + LEFT);

      up(CLIP_H / 4)
      fwd(WALL_THICKNESS)
      xrot(90)
      zrot(90)
      dovetail("male", w = WALL_THICKNESS * 4, h = WALL_THICKNESS, slide = CLIP_W, taper = 1, radius = 0.2, round =
      true, anchor = BOTTOM);
    }
  }
}

module pokeball_holder_back(diameter, belt_width, belt_thickness) {
  diff("cut") {
    tag("cut")
    sphere(r = RAD);
    cuboid([CLIP_W, RAD, CLIP_H], rounding = CLIP_ROUNDING, anchor = FRONT, edges = [TOP + RIGHT, TOP + LEFT, BOTTOM +
      RIGHT, BOTTOM + LEFT]);
  }
}

module pokeball_holder_arms(diameter, nub_len, offset_fwd, offset_up, arm_arc) {
  RAD = (diameter / 2) + WALL_THICKNESS + $slop;
  CUT = RAD / 1.3;

  yscale(1.02, cp = [0, RAD, 0])
  yrot(45)
  diff("cut") {
    sphere(r = RAD);

    tag("cut")
    sphere(r = diameter / 2);

    tag("cut")
    xrot(90)
    cylinder(h = RAD, r1 = 0, r2 = arm_arc, anchor = BOTTOM);

    yrot_copies([0, 90]){
      tag("cut")
      fwd(RAD / 2)
      yscale(3)
      zflip_copy()
      cylinder(h = RAD, r1 = 0, r2 = CUT, anchor = BOTTOM);

      FWD_OFFSET = offset_fwd;
      H_OFFSET = offset_up;

      tag("keep")
      yrot(45)
      zflip_copy()
      up(RAD - WALL_THICKNESS - H_OFFSET)
      fwd(FWD_OFFSET)
      yrot(90)
      cyl(d = WALL_THICKNESS * 2, h = nub_len, rounding = WALL_THICKNESS / 2, anchor = CENTER);
    }
  }

}

module pokeball_holder() {
  diff("att") {
    pokeball_holder_arms(BALL_DIAMETER, NUB_LEN, NUB_FWD, NUB_UP, ARM_ARC);
    pokeball_holder_back(BALL_DIAMETER, BELT_WIDTH, BELTH_THICKNESS);

    tag("att")
    back(RAD)
    up(CLIP_H / 4)
    xrot(- 90)
    zrot(90)
    dovetail("female", w = WALL_THICKNESS * 4, h = WALL_THICKNESS / 1.75, slide = CLIP_W, taper = 1, radius = 0.2,
    round
    = true, anchor = BOTTOM);
  }
}

pokeball_holder();
//pokeball_holder_clip(BALL_DIAMETER, BELT_WIDTH, BELTH_THICKNESS);


