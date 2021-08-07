include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>

$fn = 100;
$interf = 0.6;

// All values expressed in millimeters
ELITE_D = 13;
ELITE_L = 65;

WALL_THICKNESS = 4;

RIB = 0.6;

module clip(w = 20, h = 50, d = 5, th = 2) {
  ANG = 3;

  fwd(d / 2)
  up(h) {
    difference() {
      tube(id = d, od = d + (th * 2), h = w, orient = RIGHT, anchor = CENTER);
      xrot(- 90 + ANG)
      angle_pie_mask(ang = 180 - ANG, d = d + (th * 3), l = w, orient = RIGHT);
    }
  }


  cube([w, th, h], anchor = BOTTOM + FRONT);

  clipLen = h - (h / 5);

  xrot(ANG, cp = [0, - d, h]){
    fwd(d)
    up(h)
    cube([w, th, clipLen], anchor = TOP + BACK);


    fwd(d)
    up(h - clipLen) {
      difference() {
        tube(id = d, od = d + (th * 2), h = w, orient = RIGHT, anchor = CENTER + BACK);


        fwd(d - (th / 4))
        xrot(- 270)
        angle_pie_mask(ang = 290, d = d + (th * 3), l = w, orient = RIGHT);
      }
    }
  }
}

module NerfDartHolder(d = ELITE_D, l = ELITE_L) {

  dia = d+$interf;

  num = 5;
  lineLength = (dia * (num - 1)) + (WALL_THICKNESS * (num - 1));

  union() {
    intersection() {
      union() {
        difference() {
          line_of(l = lineLength, n = num) cylinder(d = dia + (WALL_THICKNESS * 2), h = l);
          line_of(l = lineLength, n = num) cylinder(d = dia, h = l);
        }
        line_of(l = lineLength, n = num) tube(od = dia, id1 = dia - (RIB*2), id2=dia, h = l / 30);
      }

      cube([lineLength + dia + WALL_THICKNESS, dia + WALL_THICKNESS, l], anchor = BOTTOM);
    }

    up(l / 3)
    line_of(l = lineLength, n = num) zscale(4) torus(id = dia - RIB, od = dia + RIB);

    clipW = lineLength/2;
    clipH = l/1.5;
    clipD = 5;
    clipTh = 2;

    up(l-clipH-clipD)
    fwd(((dia+WALL_THICKNESS)/2) + (clipTh/1.25))
    clip(clipW,clipH, clipD, clipTh);
  }
}

//front_half()
NerfDartHolder();
