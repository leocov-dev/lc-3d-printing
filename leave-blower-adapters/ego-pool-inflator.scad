include <../_lib/BOSL2/std.scad>

$fn = 75;

WALL = 2.8;

module make() {
  tube(h = 60, id1 = 90, id2 = 82.5, wall = WALL){
    attach(TOP) tube(h = 50, id1 = 82.5, od2 = 21, wall = WALL)
      attach(TOP) tube(h = 45, od1 = 21, od2 = 19, wall = WALL)
        attach(TOP) torus(od = 19, id = 19 - WALL * 2);
  }
}




make();
