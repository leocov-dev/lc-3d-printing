include <../lib/BOSL2/std.scad>

module screw(hole_d, hole_l, nut, cap) {
  cylinder(d = hole_d, h = hole_l * 2, anchor = CENTER, orient = RIGHT, $fn=100);

  right(hole_l / 2) cylinder(d = cap, h = hole_l * 2, anchor = BOTTOM, orient = RIGHT, $fn=100);

  left(hole_l / 2) cylinder(d = nut, h = hole_l * 2, anchor = TOP, orient = RIGHT, $fn = 6);
}


module slot_screw(hole_d, hole_l, nut, nut_h, cap) {
  cylinder(d = hole_d, h = hole_l, anchor = CENTER, orient = RIGHT, $fn=100);

  right(hole_l / 2) cylinder(d = cap, h = hole_l * 2, anchor = BOTTOM, orient = RIGHT, $fn=100);

  nut_width = (nut/2) * cos(360/12) * 2;

  left(hole_l / 2) cylinder(d = nut, h = nut_h, anchor = BOTTOM, orient = RIGHT, $fn = 6)
  attach(CENTER) cube([nut_h*5, nut_width, nut_h], anchor=LEFT);
}

//screw(1, 3, 5, 5);
slot_screw(1, 10, 5, 2, 5);
