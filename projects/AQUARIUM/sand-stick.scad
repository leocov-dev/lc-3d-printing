include <../vendor/BOSL2/std.scad>

$fn = 100;

DIA = 2.5;
$slop = 0.2;

module SandStickHandle(d=2.5) {
  thickness=d+2.5;

  difference() {
    union() {
      cylinder(h = 30, d = thickness, anchor = TOP);
      sphere(d = thickness);
      down(30) sphere(d = thickness);

      down(15)
      sphere(d=thickness*2);

      down(15)
      cylinder(h = 30, d = thickness*1.5);

      up(5) {
        sphere(d = thickness * 2);
        cylinder(h = 35, d = thickness * 2);
      }
      up(40)
      sphere(d=thickness*2);
    }

    down(5)
    cylinder(h = 30, d = d, anchor = TOP);
  }
}

module SandStickEnd(d=2.5, w=30) {
  thickness=d+2.5;

  difference() {
    union() {
      cylinder(h = 30, d = thickness, anchor = TOP);
      sphere(d = thickness);
      down(30) sphere(d = thickness);

      down(26)
      prismoid(size1=[2,w], size2=[2,thickness*1.5], h=30, anchor = TOP);

      down(30)
      cylinder(h=2, d=thickness*1.5, orient=LEFT, anchor=LEFT);
    }

    up(5)
    cylinder(h = 30, d = d, anchor = TOP);
  }
}

SandStickEnd(d=DIA+$slop, w=20);
left(10)
SandStickEnd(d=DIA+$slop, w=30);
left(20)
SandStickEnd(d=DIA+$slop, w=40);

left(30)
down(10.8)
xrot(180)
SandStickHandle(DIA+$slop);
