module pi(ver = 4) {
  if (ver == 4) {translate([- 28, 42.5, 1.5]) rotate([0, 0, - 90]) color("grey") import("ref/pi4.stl");}
  else if (ver == 3) {rotate([0, 0, - 90]) color("darkgrey") import("ref/pi3.stl");}
}
