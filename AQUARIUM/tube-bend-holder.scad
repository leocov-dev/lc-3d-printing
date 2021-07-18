include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>

$fn = 100;

INTERF = 0.4;

pegLens = [0.5, 2.25, 2.25, 1.5];
pegHeight = pegLens[0]+pegLens[1]+pegLens[2]+pegLens[3];

module straightSection(d, wall, l, flatEnds=false) {
  cornerRad = wall / 3;

  width = d + (wall * 2);

  rounedEdges = flatEnds ?
    [
      BOTTOM + LEFT,
      BOTTOM + RIGHT,
      TOP + LEFT,
      TOP + RIGHT
    ] :
    [
      FRONT,
      BOTTOM + LEFT,
      BOTTOM + RIGHT,
      TOP + LEFT,
      TOP + RIGHT
    ];

  difference() {
    cuboid(
      [width, l, width],
    rounding = cornerRad,
    edges = rounedEdges,
    anchor = BACK + BOTTOM
    );

    up(wall)
    cylinder(d = d, h = l, anchor = BOTTOM + FRONT, orient = FRONT);

    up(width / 2)
    cube([d, l, width], anchor = BOTTOM + BACK);

    fwd(l / 4)
    cube([d, l / 2, width], anchor = BOTTOM + BACK);
  }

  clip_width = d/5;
  clip_height = width/2;

  xflip_copy()
  fwd(l * (3 / 4))
  right((d / 2) - (clip_width))
  up(width)
  zrot(90)
  difference() {
    right_triangle([clip_height, clip_width, l / 2], orient = RIGHT, anchor = BACK + LEFT + BOTTOM);
    zrot(- 90)
    rounding_angled_edge_mask(
      h = l / 2,
      r = cornerRad,
      ang = atan((clip_height) / (clip_width)),
      anchor = BOTTOM,
      orient = BACK
    );
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
    clip_width = d/5;
    clip_height = width/2;

    cornerAngle = 180-atan(clip_height / clip_width);
    cornerOffset = clip_width - (cornerRad * tan(cornerAngle/2));

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
          [0, -clip_height]
        ]);

      rect(size=[cornerOffset, cornerRad], anchor=BACK+LEFT);
    }
  }

}

module suctionCupPin() {
  cylinder(d1=7, d2=7.75, h=pegLens[0], anchor=BOTTOM)
    attach(TOP) cylinder(d=7.75, h=pegLens[1], anchor=BOTTOM)
    attach(TOP) cylinder(d=4.8, h=pegLens[2], anchor=BOTTOM)
    attach(TOP) cylinder(d1=4.8, d2=7.5, h=pegLens[3], anchor=BOTTOM);
}

module suctionCupMount(d, arc, arcRad, wall) {
  cornerRad = wall / 3;
  width = d + (wall * 2);
  topDia = 8;
  mntHeight = width - pegHeight;

  suctionCupPin()
    attach(TOP) cylinder(d=topDia, h=mntHeight, anchor=BOTTOM);

  if (arc>0) {
    angle = arc / 2;
    offVec = (topDia / 2) / sin(angle / 2);
    off = (offVec * sqrt(2)) / 2;
    rad = arcRad - (width / 2) + wall;

    intersection() {
      cylinder(r = rad, h = width, anchor = BOTTOM);

      difference() {
        left(off)
        fwd(off)
        up(pegHeight)
        zrot(arc / 4)
        pie_slice(r = rad + offVec, ang = angle, l = mntHeight);

        left(off)
        fwd(off)
        up(pegHeight)
        zrot(arc / 4)
        rounding_angled_edge_mask(
        h = 5,
        r = topDia / 2,
        ang = angle,
        anchor = BOTTOM
        );
      }
    }

    chamf = 2.5;

    intersection() {
      left(off)
      fwd(off)
      up(pegHeight)
      zrot(arc / 4)
      path_extrude2d(arc(r = rad + offVec - wall, angle = [0, angle]), caps = false)
      polygon([
          [0, 0],
          [- chamf, 0],
          [0, - chamf]
        ]);

      cylinder(r = rad, h = width);
    }
  } else {
    up(pegHeight)
    cylinder(d=width-(cornerRad*2), h=mntHeight);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module BendHolder(tubeDia = 5, bendArc = 90, bendRad = 5, wallThickness = 1, endSupport = 5, suctionCup=false) {
  RAD=max(bendRad+(tubeDia/2)+wallThickness, bendRad+(tubeDia/2)+wallThickness+1);

  right(bendArc>0 ? RAD: 0)
  straightSection(tubeDia, wallThickness, endSupport);

  if (bendArc>0) {
    curvedSection(tubeDia, bendArc, RAD, wallThickness);

    zrot(bendArc - 90)
    back(RAD)
    zrot(- 90)
    xflip()
    straightSection(tubeDia, wallThickness, endSupport);

    if (suctionCup) {
      suctionCupMount(tubeDia, bendArc, RAD, wallThickness);
    }
  } else {
    back(bendRad)
    straightSection(tubeDia, wallThickness, bendRad, true);

    back(bendRad)
    zrot(180)
    straightSection(tubeDia, wallThickness, endSupport, false);

    if (suctionCup) {
      width = tubeDia + (wallThickness * 2);
      back(bendRad/2)
      down(width)
      suctionCupMount(tubeDia, bendArc, RAD, wallThickness);
    }
  }
}

TUBE_DIA=5.5+INTERF;
WALL_THICKNESS=0.4*3;

BendHolder(TUBE_DIA, 90, 10, WALL_THICKNESS, 8, true);

//left(50)
//BendHolder(TUBE_DIA, 90, 10, WALL_THICKNESS, 8, true);
