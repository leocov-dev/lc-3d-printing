include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>

$fn = 100;

INTERF = 0.4;

module straightSection(d, wall, l) {
  cornerRad = wall / 3;

  width = d + (wall * 2);

  difference() {
    cuboid(
      [width, l, width],
    rounding = cornerRad,
    edges = [
      FRONT,
        BOTTOM + LEFT,
        BOTTOM + RIGHT,
        TOP + LEFT,
        TOP + RIGHT
      ],
    anchor = BACK + BOTTOM
    );

    up(wall)
    cylinder(d = d, h = l, anchor = BOTTOM + FRONT, orient = FRONT);

    up(width / 2)
    cube([d, l, width], anchor = BOTTOM + BACK);

    fwd(l / 4)
    cube([d, l / 2, width], anchor = BOTTOM + BACK);
  }

  xflip_copy()
  fwd(l * (3 / 4))
  right((d / 2) - (d / 6))
  up(width)
  zrot(90)
  difference() {
    right_triangle([width / 3, d / 6, l / 2], orient = RIGHT, anchor = BACK + LEFT + BOTTOM);
    zrot(- 90)
    rounding_angled_edge_mask(h = l / 2, r = cornerRad, ang = atan((width / 3) / (d / 6)), anchor = BOTTOM, orient =
    BACK);
  }
}

module curvedSection(d, arc, arcRad, wall) {
  l = 2;
  width = d + (wall * 2);
  cornerRad = wall / 3;

  off = cornerRad - (cornerRad * sin(45));

  arcPortion=arc/3;

  finalRad = arcRad+width/2;

  difference() {
    path_extrude2d(arc(r = finalRad, angle = [0, arc]), caps = false)
    difference() {
      left(off) back(off)
      rect(size = width, rounding = cornerRad, anchor = FRONT + RIGHT);

      left(width / 2)
      back(width / 2) {
        circle(d = d);
        rect(size = d, anchor = FRONT);
      }
    }

    path_extrude2d(arc(r = finalRad - wall, angle = [0 + arcPortion, arc - arcPortion]), caps = false)
    fwd(wall)
    rect(size = [d, width], anchor = FRONT + RIGHT);
  }


  path_extrude2d(arc(r = finalRad - wall, angle = [0 + arcPortion, arc - arcPortion]), caps = false)
  color("red") {
    cornerAngle = 180-atan((width / 3) / (d / 6));
    cornerOffset = (d / 6) - (cornerRad * tan(cornerAngle/2));

    left(width/2 - wall)
    xflip_copy()
    left((width/2)-wall)
    back(width)
    union() {
      fwd(cornerRad)
      right(cornerOffset)
      zrot(90-cornerAngle)
      arc(r = cornerRad, angle = cornerAngle, wedge = true);

      more = cornerRad * sin(90-cornerAngle);
      more2 = sqrt(sqr(cornerRad) - sqr(more));
      polygon([
          [0,-cornerRad],
          [cornerOffset, -cornerRad],
          [cornerOffset+more2, -cornerRad+more],
          [0, -width/3]
        ]);

      rect(size=[cornerOffset, cornerRad], anchor=BACK+LEFT);
    }
  }

}

module BendHolder(tubeDia = 5, bendArc = 90, bendRad = 5, wallThickness = 1, endSupport = 5) {
  rad=max(bendRad+(tubeDia/2)+wallThickness, bendRad+(tubeDia/2)+wallThickness+1);

  right(rad)
  straightSection(tubeDia, wallThickness, endSupport);
  curvedSection(tubeDia, bendArc, rad, wallThickness);

  back(rad)
  zrot(-90)
  xflip()
  straightSection(tubeDia, wallThickness, endSupport);
}

TUBE_DIA=5.5+INTERF;
WALL_THICKNESS=0.4*3;

BendHolder(TUBE_DIA, 90, 5, WALL_THICKNESS, 8);
BendHolder(TUBE_DIA, 90, 15, WALL_THICKNESS, 8);

fwd(30)
BendHolder(TUBE_DIA, 90, 1.5, WALL_THICKNESS, 8);

fwd(30)
BendHolder(TUBE_DIA, 90, 10, WALL_THICKNESS, 8);
