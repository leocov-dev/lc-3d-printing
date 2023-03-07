include <../vendor/BOSL2/std.scad>
include <../vendor/BOSL2/joiners.scad>

$fn = 100;
// fitment ajuster
$slop = 0.6;

// thickness of the 3d print walls
WALL_THICKNESS = 2;


module kong_filler(hole_diameter, funel_diameter) {
  tip_height = 10;

  od = hole_diameter;
  id = hole_diameter - (WALL_THICKNESS * 2);
  top = 110;
  top_h = 70;


  up(tip_height / 2){

    tube(od = od, id = id, h = tip_height){
      position(TOP)
      tube(od1 = od, od2 = top, id1 = id, id2 = top - (WALL_THICKNESS * 2), h = top_h, anchor = BOTTOM);
    }


//    down((tip_height / 2))
//    xrot(180)
//    rounding_cylinder_mask(d = hole_diameter, rounding = 1);

  }
}

MM_CONV = 25.4;

//back_half(200)
kong_filler(0.975 * MM_CONV, 5 * MM_CONV);

left(3 * MM_CONV * 1.5)
kong_filler(15, 3 * MM_CONV);
