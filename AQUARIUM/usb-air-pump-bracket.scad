include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>
include <../lib/BOSL2/joiners.scad>

$fn = 50;
$interf = 0.4;


module pumpHook(th = 2, tab = 2) {
  dia = 30 + 15;
  supTh = 10;

  module hook() {
    hookH = 4;

    union() {
      cube([supTh / 3, hookH, th], anchor = CENTER + LEFT + FRONT);

      right_half()
      back(hookH)
      yscale(1 / 2)
      cylinder(d = supTh - ($interf * 6), h = th, anchor = CENTER);
    }
  }

  union()
    color("#a0e4ff") {
      zrot(- 90)
      back((dia / 2) + (supTh * 3) / 2)
      right(dia / 2 + supTh / 2 + tab) {
        front_half()
        difference() {
          union() {
            cube([(supTh / 2) + tab + dia / 2, dia + (supTh * 3), th], anchor = CENTER + RIGHT);

            cylinder(d = dia + supTh, h = th, anchor = CENTER);
          }
          cylinder(d = dia, h = th, anchor = CENTER);

          left(dia / 2 + (supTh / 2))
          back((dia + (supTh * 3)) / 4)
          cube([(supTh / 2) + tab, dia + (supTh * 3), th], anchor = CENTER + RIGHT);

          fwd(dia + supTh + tab / 2)
          cylinder(d = dia + supTh + tab, h = th, anchor = CENTER);
        }

        xflip_copy()
        right(dia / 2)
        hook();
      }
    }
}

module cordClip(d = 3, offset = 0) {
  wall = (d / 5) * 2;

  diff("mask")
  cube([d + wall, d, offset > 0 ? offset : 0.01], anchor = BOTTOM){
    attach(TOP) {
      difference() {
        cube([d + wall, d, d + wall], anchor = BOTTOM);

        up(wall / 2){
          cylinder(d = d + $interf, h = d, orient = BACK, anchor = CENTER + BACK){
            fwd((d) / 2)
            cube([d + $interf, d, d], anchor = CENTER);
          }
        }
      }

      xflip_copy()
      left((d + $interf) / 2)
      up(d + wall)
      bottom_half()
      right_half()
      xscale(1 / 2)
      zscale(1.5)
      cylinder(d = d / 1.75, h = d, orient = BACK, anchor = CENTER);

      xflip_copy()
      left((wall + d) / 2)
      up(wall + d)
      rounding_mask(l = d * 2, r = wall / 4, orient = FRONT, anchor = CENTER, $tags = "mask");

      xflip_copy()
      left(((wall + d) / 2) - (d / 1.75) / 2.0625)
      up(wall + d)
      rounding_mask(l = d * 2, r = wall / 4, orient = FRONT, anchor = CENTER, $tags = "mask");
    }
  }

}

module UsbAirPumpBracket(thickness = 3, width = 60, height = 60) {
  bracketW = width;
  bracketTh = thickness;
  bracketH = height;

  union()
    color("#bebfff") {
      difference() {
        diff("remove")
        cube([bracketW, bracketTh, bracketH], anchor = BOTTOM + BACK){
          attach(TOP) dovetail("female", slide = 10, width = 15, height = 8, radius = 1.5, round = true, $tags =
          "remove")
          ;
        }

        xflip_copy()
        left((bracketW / 2) - (bracketTh * 3))
        yrot(- 90)
        pumpHook(bracketTh + $interf, bracketTh);
      }


      up(bracketH / 5)
      fwd(bracketTh)
      xrot(90)
      cordClip(3.3);

      up(3.3)
      fwd(bracketTh)
      xrot(90)
      cordClip(3.3);
    }
}

module SingleCheckAndRegulate(thickness = 3, width = 60) {
  bracketW = width;
  bracketTh = thickness;
  bracketH = 85;

  valveHole = 6.55;
  valveOffset = 11;

  checkHole = 7;
  checkDia = 14.5;
  checkOffset = 61;
  checkHeight = 25;

  smallPartTh = 2;

  color("#ffc490")
  diff("remove"){
    cube([bracketW, bracketTh, bracketH], anchor = BOTTOM + BACK){
      attach(BOTTOM) dovetail("male", slide = bracketTh, width = 15 - ($interf / 2), height = 8 - ($interf / 3.5),
      radius = 1.45, round = true);
    }

    left(bracketW / 4)
    up(bracketH){
      cylinder(d = valveHole * 2, l = valveOffset, orient = FRONT);
      cylinder(d = valveHole + $interf, l = (valveOffset) * 2, orient = FRONT, $tags = "remove");

      down(checkOffset + (valveHole / 2))
      fwd(valveOffset + bracketTh)
      tube(od = checkDia + (smallPartTh * 2) + $interf, id = checkHole + $interf, h = smallPartTh, anchor = BOTTOM)
      attach(TOP) {
        tube(od = checkDia + (smallPartTh * 2) + $interf, id = checkDia + $interf, h = checkHeight, anchor = BOTTOM);

        difference() {
          back(checkDia / 2)
          cube([checkDia, valveOffset, checkHeight], anchor = CENTER + BOTTOM);

          cylinder(d = checkDia, h = checkHeight);
        }
      }
    }

    triH = valveHole;

    up(bracketH + .1) {
      right(bracketW / 2 + .1)
      yrot(180)
      right_triangle(
        [(bracketW) - (bracketW / 4) - (valveHole), triH, bracketTh * 10],
      orient = FRONT,
      anchor = LEFT + FRONT,
      $tags = "remove"
      );

      left(bracketW / 2 + .1)
      zrot(180)
      yrot(180)
      right_triangle([(bracketW / 4) - (valveHole), triH, bracketTh * 10], orient = FRONT, anchor = LEFT + FRONT, $tags
      = "remove");
    }
  }
}

THICKNESS = 3;
WIDTH = 60;
HEIGHT = 60;

UsbAirPumpBracket(THICKNESS, WIDTH, HEIGHT);

xflip_copy()
left((WIDTH / 2) - (THICKNESS * 3))
yrot(- 90)
pumpHook(THICKNESS, THICKNESS);

up(60)
SingleCheckAndRegulate(THICKNESS, WIDTH);
