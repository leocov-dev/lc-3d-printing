/**
* Lift up a Fluval Aquasky light so that it sits higher above the top of the aquarium.
* Customize the `lift` paramter to match your desired height increase (values in mm).
* Customize the `rimThickness` paramter to match your aquarium rim (values in mm).
*/

include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>

$fn = 100;

$interf = 0.4;

MIN_LIFT = 7.5;

module FluvalAquaskyLifters(lift = 15, rimThickness = 10) {
  lift = lift < MIN_LIFT ? MIN_LIFT : lift;

  lipWidth = 1.5;

  footLength = 47 + ($interf * 2);
  footWidth = rimThickness + $interf;

  topLength = footLength + (lipWidth * 2);

  supportLength = footLength * 2.5;
  supportHeight = MIN_LIFT / 2;

  totalWidth = footWidth + (lipWidth * 2);

  difference() {
    union() {
      cube([supportLength, totalWidth, lift], anchor = CENTER + BOTTOM);

      back(footWidth / 2)
      down(lipWidth * 8)
      cube([supportLength, lipWidth, lift], anchor = BOTTOM + FRONT);

      fwd(footWidth / 2)
      down(lipWidth * 2)
      cube([supportLength, lipWidth, lift], anchor = BOTTOM + BACK);

      right(footLength / 2)
      up(lift)
      cube([lipWidth, totalWidth, lipWidth], anchor = BOTTOM + LEFT);

      left(footLength / 2)
      up(lift)
      cube([lipWidth, totalWidth, lipWidth], anchor = BOTTOM + RIGHT);
    }

    union() {
      back(footWidth / 2)
      up(lift / 2)
      cube([supportLength, lipWidth, lift], anchor = BOTTOM + FRONT);

      halfFoot = topLength / 2;
      cylinderRadius = (supportLength - topLength) / 2;
      cylScaleFactor = (lift - supportHeight) / cylinderRadius;

      up(lift)
      right(halfFoot)
      zscale(cylScaleFactor)
      ycyl(r = cylinderRadius, h = totalWidth, anchor = LEFT);

      up(lift)
      left(halfFoot)
      zscale(cylScaleFactor)
      ycyl(r = cylinderRadius, h = totalWidth, anchor = RIGHT);
    }

    offsetCut = supportLength / 5.5;

    right(supportLength/2)
    cube([offsetCut, totalWidth * 2, totalWidth * 10], anchor = CENTER+RIGHT);
  }
}

FluvalAquaskyLifters(18, 12);
