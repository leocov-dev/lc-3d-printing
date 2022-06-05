include <../vendor/BOSL2/std.scad>

$fn = 100;
// fitment ajuster
$slop = 0.6;

// thickness of the 3d print walls
WALL_THICKNESS = 1.2;

MM_CONV = 25.4;

// ------
// Make a template to mark a tube to notch
//
// params:
//   od_main   - outer diameter of tube to notch     - INCHES
//   od_target - outer diameter of tube to attach to - INCHES
//   angle     - angle between tubes (0-85)          - DEGREES
module tube_notcher(od_main, od_target, angle, extra=0.75) {
  main_mm = constrain(od_main, 0.1, 100) * MM_CONV;
  target_mm = constrain(od_target, 0.1, 100) * MM_CONV;
  extra_mm = constrain(extra, 0.25, 2) * MM_CONV;

  MAIN = main_mm; //constrain(main_mm, WALL_THICKNESS, target_mm);
  TARGET = od_target * MM_CONV;
  ANGLE = angle-90;

  little_extra = adj_ang_to_opp((MAIN / 2) + WALL_THICKNESS, ANGLE);
  template_height = (adj_ang_to_hyp(TARGET / 2, ANGLE) + little_extra) + extra_mm;
  chop = (template_height * 3) + little_extra;

  up(template_height)
  zrot(180)
  yrot(180-ANGLE)
  diff("sub") {
    yrot(ANGLE) {
      zflip_copy()
      tube(id = MAIN, wall = WALL_THICKNESS, l = template_height, anchor = BOTTOM);

      xflip_copy()
      right((MAIN / 2) + WALL_THICKNESS)
      tag("sub")
      cylinder(d = WALL_THICKNESS / 2, h = template_height, anchor = BOTTOM);
    }

    #cylinder(d = TARGET, h = chop, anchor = CENTER, orient = LEFT);
    tag("sub"){
      cylinder(d = TARGET, h = chop, anchor = CENTER, orient = LEFT);
      cube([chop, MAIN + TARGET, template_height * 2], anchor = TOP);
    }
  }

  corner_ang = (180-ANGLE-90);
  echo("ANGLE=", ANGLE, ", corner_ang=", corner_ang);

  target_half_hyp = adj_opp_to_hyp(TARGET/2, chop/2);

  debug_hyp = [[0, 0, 0], [-target_half_hyp, 0, 0]];
  target_part_ang = adj_opp_to_ang(TARGET/2, chop/2);
  target_part_ang_B = target_part_ang-corner_ang;
//  up(template_height)
//  yrot(target_part_ang_B)
//  stroke(debug_hyp);


//  corner_x = ang_hyp_to_opp(target_part_ang_B, target_half_hyp);
//  corner_b = ang_hyp_to_opp(ANGLE+target_part_ang, target_half_hyp);
//  corner_y = template_height - corner_x;
//
//  cornerA = [[chop/2, 0, TARGET/2], [0, 0, TARGET/2], [MAIN/2, 0, template_height]];
//  pathA = arc(cp=[0, 0, TARGET], points=[[-(MAIN/2)-WALL_THICKNESS, 0, 0], [-corner_x, 0, 0]]);

  opp_ang = 180-ANGLE;
  opp_ang_quarter = opp_ang/4;

  hyp = 2*hyp_ang_to_opp(template_height, opp_ang_quarter);
  ang = hyp_adj_to_ang(template_height, hyp/2);
  corner_x = hyp_ang_to_adj(hyp, 90-ang);
  corner_y = hyp_ang_to_opp(hyp, 90-ang);

  pathA = [[0,0,template_height], [-corner_x,0,corner_y]];
//  stroke(pathA, color="lightgreen");
}

tube_notcher(25.6/MM_CONV, 42/MM_CONV*500, 180-110, 0.75);
