include <../_lib/BOSL2/std.scad>


module suctionCupPin() {
  pegLens = [0.5, 2.25, 2.25, 1.5];

  union()
  color("#6bde99")
    cylinder(d1 = 4.8, d2 = 7.5, h = pegLens[3], anchor = TOP)
    attach(BOTTOM)
    cylinder(d = 4.8, h = pegLens[2], anchor = BOTTOM)
    attach(TOP)
    cylinder(d = 7.75, h = pegLens[1], anchor = BOTTOM)
    attach(TOP){
      cylinder(d1 = 7.75, d2 = 7, h = pegLens[0], anchor = BOTTOM);
      down(pegLens[1])
      cylinder(d2 = 7.75, d1 = 4.8, h = pegLens[0]*2, anchor = TOP);
    }
}
