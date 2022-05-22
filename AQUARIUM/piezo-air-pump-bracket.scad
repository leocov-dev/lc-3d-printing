include <../_lib/BOSL2/std.scad>
include <../_lib/BOSL2/hull.scad>
include <../_lib/BOSL2/joiners.scad>
include <aqu-suction-cup-pin.scad>
include <../_lib/lib_cord_clip.scad>

$fn = 50;
$slop = .4;

module PiezoAirPumpBracket(thickness = 3, width = 60, height = 60) {
  bracketW = width;
  bracketTh = thickness;
  bracketH = height;
  union() {
    diff("remove") {
      cube([bracketW, bracketTh, bracketH], anchor = BOTTOM + BACK){
        down(10)
        attach(FRONT) {
          xrot(180)
          suctionCupPin();
        }
      }
      fwd(bracketTh / 2)
      xrot(90)
      zrot(90) {
        fwd(bracketW / 2)
        rounding_angled_edge_mask(h = bracketTh * 2, d = bracketW, ang = 90, $tags="remove");
        back(bracketW / 2)
        rounding_angled_edge_mask(h = bracketTh * 2, d = bracketW, ang = 90, $tags="remove");
      }
    }

    up(27)
    left((bracketW/2) - 5)
    fwd(bracketTh)
    xrot(90)
    cordClip(3.3);
    up(35)
    left((bracketW/2) - 5)
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
      cube([bracketW, bracketTh, bracketH], anchor = BOTTOM + BACK);

      // ADJ VALVE HOLDER
      right(bracketW/4)
      up(bracketH) {
        cylinder(d = valveHole * 2, l = valveOffset, orient = FRONT);
        cylinder(d = valveHole + $slop, l = (valveOffset) * 2, orient = FRONT, $tags = "remove");

        down(valveHole)
        fwd(bracketTh)
        {
          diff("remove") {
            valveSpan = 8.5 + ($slop * 2);
            left(valveSpan / 2)
            cube([2.5, 15, 10], anchor = BACK + TOP){
              attach(TOP)
              zrot(- 90)
              right_triangle([15, 10, 2.5], orient = FRONT, anchor = FRONT);
            }
            right(valveSpan / 2)
            cube([2.5, 15, 10], anchor = BACK + TOP){
              attach(TOP)
              zrot(- 90)
              right_triangle([15, 10, 2.5], orient = FRONT, anchor = FRONT);
            }

            fwd(15)
            cylinder(h=100, d=20, orient=LEFT, anchor=CENTER+LEFT, $tags="remove");
          }
        }
      }
      triH = valveHole;
      xflip()
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

      // CHECK VALVE HOLDER
      left(bracketW / 4)
      up(bracketH){
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
    }
}

THICKNESS = 3;
WIDTH = 60;
HEIGHT = 60;

PiezoAirPumpBracket(THICKNESS, WIDTH, HEIGHT);

up(60)
SingleCheckAndRegulate(THICKNESS, WIDTH);
