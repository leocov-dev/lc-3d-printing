include <../vendor/BOSL2/std.scad>
include <../vendor/BOSL2/joiners.scad>

$fn = 100;
// fitment ajuster
$slop = 0.2;

// MM UNITS

// thickness of the 3d print walls
WALL_THICKNESS = 2.8;

HEIGHT=60;

CLIP_W=67;
CLIP_D=15;
CLIP_H=3;

TANK_RIM_W=12.1;
TANK_RIM_H=8;

TANK_LIP_W=7.2;
TANK_LIP_H=2;

PINCH=1;

module mockup() {
  right(WALL_THICKNESS+$slop)
  color("green") {
    cube([TANK_RIM_W, TANK_RIM_H, CLIP_W+(WALL_THICKNESS)+($slop*2)]);
    cube([TANK_RIM_W+TANK_LIP_W, TANK_LIP_H, CLIP_W+(WALL_THICKNESS)+($slop*2)], anchor=BACK+BOTTOM+LEFT);
  }

  left(WALL_THICKNESS+$slop)
  color("lightgreen") {
    cube([WALL_THICKNESS, HEIGHT, CLIP_W+(WALL_THICKNESS)+($slop*2)]);
  }
}

module lifter() {
  diff("rel") {
    force_tag() {
      linear_extrude(height = CLIP_W+(WALL_THICKNESS)+($slop*2))
        polygon([
            [0, -TANK_RIM_H],
            [WALL_THICKNESS, -TANK_RIM_H],
            [WALL_THICKNESS, TANK_RIM_H],
            [WALL_THICKNESS + TANK_RIM_W + $slop + $slop, TANK_RIM_H],
            [WALL_THICKNESS + TANK_RIM_W + $slop + $slop, 0],
            [WALL_THICKNESS + TANK_RIM_W  + $slop+ TANK_LIP_W + $slop, 0],
            [WALL_THICKNESS + TANK_RIM_W + TANK_LIP_W + $slop + $slop, - TANK_LIP_H - PINCH],
            [WALL_THICKNESS + TANK_RIM_W + TANK_LIP_W + WALL_THICKNESS, - TANK_LIP_H - PINCH],
            [WALL_THICKNESS + TANK_RIM_W + TANK_LIP_W + WALL_THICKNESS, TANK_RIM_H+(CLIP_H*1.25)],

            [CLIP_D, HEIGHT+(CLIP_H*0.5)-(CLIP_H*1.25)],
            [CLIP_D, HEIGHT+(CLIP_H*0.5)],

            [0, HEIGHT+(CLIP_H*0.5)],
            [0, 0],
          ]);

      right(WALL_THICKNESS + TANK_RIM_W + TANK_LIP_W + $slop)
      fwd(TANK_LIP_H + PINCH)
      cylinder(d = PINCH, h = CLIP_W+(WALL_THICKNESS)+($slop*2), anchor = FRONT + BOTTOM);
    }

    tag("rel") {
      back(HEIGHT+(CLIP_H*0.5))
      up(WALL_THICKNESS/2)
      cube([CLIP_D, (CLIP_H*0.5), CLIP_W+($slop*2)], anchor=BACK+LEFT+BOTTOM);

      right(WALL_THICKNESS+($slop/2))
      back(TANK_RIM_H)
      cylinder(r = $slop*2, h = CLIP_W+(WALL_THICKNESS*2)+($slop*2));

      right(WALL_THICKNESS+TANK_RIM_W+$slop+($slop/2))
      back(TANK_RIM_H)
      cylinder(r = $slop*2, h = CLIP_W+(WALL_THICKNESS*2)+($slop*2));

      right(WALL_THICKNESS+TANK_RIM_W+TANK_LIP_W+$slop+($slop/2))
      cylinder(r = $slop*2, h = CLIP_W+(WALL_THICKNESS*2)+($slop*2));
    }
        
    color("green") {
      tag("rel")
      right(12)
      fwd(12)
      down(WALL_THICKNESS / 2)
      cube([CLIP_D, CLIP_H * 5, CLIP_W + (WALL_THICKNESS * 2)]);
    }

  }
}

xrot(0) {
//  mockup();
  lifter();
}


