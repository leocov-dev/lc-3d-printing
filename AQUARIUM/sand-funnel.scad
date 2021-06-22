include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>

$fn = 100;

INTERF = 0.4;

MIN_HEIGHT=10;

module SandFunnel(d1=10, d2=30, h=100, wall=2.5) {
  height = h < 10 ? MIN_HEIGHT : h;

  h_att = 18;
  h_rest = h - h_att - wall;

  fac = 0.6;

  difference() {
    tube(id = d1, od = d1 + (wall * 2), h = h_att)
    attach(TOP)
    tube(id1 = d1 - (2.5 * 2), id2 = d2 * fac - (wall * 2), od1 = d1 + (wall * 2), od2 = d2 * fac, h = h_rest/5)
    attach(TOP)
    tube(id1 = d2 * fac - (wall * 2), id2 = d2 - (wall * 2), od1 = d2 * fac, od2 = d2, h = h_rest - (h_rest/5))
    attach(TOP)
    cylinder(d=d2, h=wall);

    left(d2)
    up(h-(h*0.65))
    scale([1,1,3])
    sphere(d=d2*5, anchor=BOTTOM);
  }
}

SandFunnel(22, 90, 150);
