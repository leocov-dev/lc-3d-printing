include <../vendor/BOSL2/std.scad>
include <../vendor/BOSL2/hull.scad>
include <../vendor/BOSL2/joiners.scad>
include <../_lib/lib_cord_clip.scad>

$fn = 50;
$slop = 0.4;


module pumpHook(th = 2, tab = 2) {
  dia = 30 + 10;
  supTh = 12;

  module hook() {
    hookH = 4;

    union() {
      cube([supTh / 3, hookH, th], anchor = CENTER + LEFT + FRONT);

      right_half()
      back(hookH)
      yscale(1 / 2)
      cylinder(d = supTh - ($slop * 6), h = th, anchor = CENTER);
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

module UsbAirPumpBracket(thickness = 3, width = 60, height = 60) {
  bracketW = width;
  bracketTh = thickness;
  bracketH = height;

  union()
    color("#bebfff") {
      difference() {
        diff("remove")
        cube([bracketW, bracketTh, bracketH], anchor = BOTTOM + BACK){
          attach(TOP)
          dovetail(
          "female",
          slide = 10,
          width = 15,
          height = 8,
          radius = 1.5,
          round = true,
          $tags = "remove"
          )
          ;
        }

        xflip_copy()
        left((bracketW / 2) - (bracketTh * 3))
        yrot(- 90)
        pumpHook(bracketTh + $slop, bracketTh);
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
  bracketH = 70;

  valveHole = 7.3;
  valveOffset = 11;

  checkHole = 7;
  checkDia = 14.5;
  checkOffset = 61;
  checkHeight = 25;

  smallPartTh = 2;

  color("#ffc490")
    diff("remove"){
      cube([bracketW, bracketTh, bracketH], anchor = BOTTOM + BACK){
        attach(BOTTOM)
        dovetail(
        "male",
        slide = bracketTh,
        width = 15,
        height = 8,
        radius = 1.5,
        round = true
        );
      }

      left(bracketW / 4)
      up(bracketH){
        cylinder(d = valveHole * 2, l = valveOffset, orient = FRONT);
        cylinder(d = valveHole + $slop, l = (valveOffset) * 2, orient = FRONT, $tags = "remove");

        down(valveHole)
        fwd(bracketTh)
        {
          valveSpan=8.5+($slop*2);
          left(valveSpan/2)
          cube([2.5, 15, 10], anchor=BACK+TOP){
            attach(TOP)
            zrot(-90)
            right_triangle([15, 10, 2.5], orient = FRONT, anchor = FRONT);
          }
          right(valveSpan/2)
          cube([2.5, 15, 10], anchor=BACK+TOP){
            attach(TOP)
            zrot(-90)
            right_triangle([15, 10, 2.5], orient = FRONT, anchor = FRONT);
          }
        }

        // CHECK VALVE HOLDER
        down(checkOffset - (valveHole / 2))
        fwd(valveOffset + bracketTh)
        yrot(90)
        tube(od = checkDia + (smallPartTh * 2) + $slop, id = checkHole + $slop, h = smallPartTh, anchor = BOTTOM)
        attach(TOP) {
          tube(od = checkDia + (smallPartTh * 2) + $slop, id = checkDia + $slop, h = checkHeight, anchor = BOTTOM);

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
        right_triangle([(bracketW / 4) - (valveHole), triH, bracketTh * 10], orient = FRONT, anchor = LEFT + FRONT,
        $tags
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
