include <../_lib/BOSL2/std.scad>

$fn = 100;
// fitment ajuster
$slop = 0.3;

// thickness of the 3d print walls
WALL_THICKNESS = 2;

// ------
// Make a template to mark a tube to notch
//
// params:
//   od_main   - outer diameter of tube to notch     - INCHES
//   od_target - outer diameter of tube to attach to - INCHES
//   angle     - angle between tubes (0-85)          - DEGREES
module tube_notcher(od_main, od_target, angle) {
  main_mm = constrain(od_main, 0.1, 100) * 25.4;
  target_mm = constrain(od_target, 0.1, 100) * 25.4;

  MAIN = main_mm; //constrain(main_mm, WALL_THICKNESS, target_mm);
  TARGET = od_target * 25.4;
  ANGLE = constrain(angle, 0, 80);

  little_extra = adj_ang_to_opp((MAIN / 2) + WALL_THICKNESS, ANGLE);
  template_height = (adj_ang_to_hyp(TARGET / 2, ANGLE) + little_extra) + (0.75 * 25.4);

  up(template_height)
  yrot(ANGLE + 90)
  diff("sub") {
    yrot(ANGLE) {
      zflip_copy()
      tube(id = MAIN, wall = WALL_THICKNESS, l = template_height, anchor = BOTTOM);

      xflip_copy()
      right((MAIN / 2) + WALL_THICKNESS)
      tag("sub")
      cylinder(d = WALL_THICKNESS / 2, h = template_height, anchor = BOTTOM);
    }

    chop = (template_height * 2) + little_extra;

    #cylinder(d = TARGET, h = chop, anchor = CENTER, orient = LEFT);
    tag("sub"){
      cylinder(d = TARGET, h = chop, anchor = CENTER, orient = LEFT);
      cube([chop, MAIN + TARGET, template_height * 2], anchor = TOP);
    }
  }
}

tube_notcher(1, 2, 45);
