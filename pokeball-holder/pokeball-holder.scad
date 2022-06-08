include <../vendor/BOSL2/std.scad>
include <../vendor/BOSL2/joiners.scad>

$fn = 100;
// fitment ajuster
$slop = 0.6;

// thickness of the 3d print walls
WALL_THICKNESS = 1.2;

module pokeball_holder_clip(diameter, belt_width, belt_thickness) {
  color("magenta") {
    RAD = (diameter / 2) + WALL_THICKNESS + $slop;
    CLIP_H = RAD + (WALL_THICKNESS * 2) + $slop;
    CLIP_W = (RAD / 1.5);
    CLIP_ROUNDING = CLIP_W / 20;


    back(RAD + WALL_THICKNESS) {
      cuboid([CLIP_W, WALL_THICKNESS, CLIP_H], rounding = CLIP_ROUNDING, anchor = CENTER + BACK, edges = [BOTTOM + LEFT,
          BOTTOM + RIGHT]);

      up(CLIP_H / 2)
      back(belt_thickness / 2)
      top_half()
      tube(h = CLIP_W, od = belt_thickness + (WALL_THICKNESS * 2), id = belt_thickness, orient = RIGHT);

      xrot(-90)
      grid2d(size=[CLIP_W-(belt_thickness*2), CLIP_H-(belt_thickness*2)], n=[5,6], stagger="alt")
      top_half()
      sphere(r=belt_thickness/3);

      back(belt_thickness)
      xrot(90)
      grid2d(size=[CLIP_W-(belt_thickness*2), CLIP_H-(belt_thickness*2)], n=[5,6], stagger="alt")
      top_half()
      sphere(r=belt_thickness/3);

      down(belt_thickness/2)
      back(belt_thickness)
      cuboid([CLIP_W, WALL_THICKNESS, CLIP_H+belt_thickness], anchor = CENTER + FRONT);

      down((CLIP_H+belt_thickness)/2)
      back(belt_thickness+WALL_THICKNESS)
      cylinder(h=CLIP_W, d=belt_thickness, orient=RIGHT, anchor=CENTER+BACK+LEFT);

      zflip_copy()
      up(CLIP_H/4)
      fwd(WALL_THICKNESS)
      xrot(90)
      zrot(90)
      dovetail("male", w=WALL_THICKNESS*4, h=WALL_THICKNESS, slide=CLIP_W, taper=1, anchor=BOTTOM);
    }
  }
}

module pokeball_holder_back(diameter, belt_width, belt_thickness) {

  RAD = (diameter / 2) + WALL_THICKNESS + $slop;
  CLIP_H = RAD + (WALL_THICKNESS * 2) + $slop;
  CLIP_W = RAD / 1.5;
  CLIP_ROUNDING = CLIP_W / 20;

  diff("cut") {
    tag("cut")
    sphere(r = RAD);
    cuboid([CLIP_W, RAD, CLIP_H], rounding = CLIP_ROUNDING, anchor = FRONT, edges = [TOP + RIGHT, TOP + LEFT, BOTTOM +
      RIGHT, BOTTOM + LEFT]);
  }
}

module pokeball_holder(diameter) {
  RAD = (diameter / 2) + WALL_THICKNESS + $slop;
  CUT = RAD / 1.3;

  diff("cut") {
    sphere(r = RAD);

    tag("cut")
    sphere(r = diameter / 2);

    tag("cut")
    xrot(90)
    cylinder(h = RAD, r1 = 0, r2 = diameter * 1.75, anchor = BOTTOM);

    yrot_copies([0, 90]){
      tag("cut")
      fwd(RAD / 2)
      yscale(3)
      zflip_copy()
      cylinder(h = RAD, r1 = 0, r2 = CUT, anchor = BOTTOM);

      FWD_OFFSET = 9;
      H_OFFSET = 1.25;

      tag("keep")
      yrot(45)
      zflip_copy()
      up(RAD - WALL_THICKNESS - H_OFFSET)
      fwd(FWD_OFFSET)
      yrot(90)
      cyl(d = WALL_THICKNESS * 2, h = 8.5, rounding = WALL_THICKNESS / 2, anchor = CENTER);
    }
  }

}

BALL_DIAMETER = 60;
BELT_WIDTH = 40;
BELTH_THICKNESS = 3;

//pokeball_holder(BALL_DIAMETER);
pokeball_holder_back(BALL_DIAMETER, BELT_WIDTH, BELTH_THICKNESS);
pokeball_holder_clip(BALL_DIAMETER, BELT_WIDTH, BELTH_THICKNESS);
