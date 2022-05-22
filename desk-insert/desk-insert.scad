include <../_lib/lib_utils.scad>
///////////////////////////////////////////////////////////
// insert for desks with wire retention
//
///////////////////////////////////////////////////////////

$fn=75;
CUT_IN_HALF=true;

DESK_HOLE_RAD=39.5;  // in mm
DESK_TH=21;  // in mm

RIM_TH=3;  // in mm

BRIM_RAD=5;  // in mm
BRIM_TH=2;  // in mm
BRIM_EDGE_F=4;

$slop=0.33;  // in mm

WIRE_RAD=4;  // in mm
WIRE_SEP=30;  // in deg
WIRE_FILLET=1;
WIRE_COUNT=3;


module angle_disc(h, r) {
  r2=r+h/4;
//  translate([0,0,-h/2])
//    cylinder(h=h/2, r1=r, r2=r2);
  translate([0,0,h/2])
    mirror([0,0,1])
      cylinder(h=h/2, r1=r, r2=r2);
}

module insert_ring() {
  innerRad=DESK_HOLE_RAD-RIM_TH;
  totalThickness=DESK_TH+BRIM_TH;
  difference(){
    hole(d=totalThickness+2, r=innerRad, trans=[0,0,totalThickness+1]) {
      color("CornflowerBlue"){
        cylinder(h=BRIM_TH-(BRIM_TH/BRIM_EDGE_F), r1=DESK_HOLE_RAD, r2=DESK_HOLE_RAD+BRIM_RAD);
        translate([0,0,BRIM_TH-(BRIM_TH/BRIM_EDGE_F)])
          cylinder(h=BRIM_TH/BRIM_EDGE_F, r=DESK_HOLE_RAD+BRIM_RAD);
      }
      
      draft_per=0.02;
      
      translate([0,0,BRIM_TH]){
        color("PowderBlue")
          cylinder(h=DESK_TH, r1=DESK_HOLE_RAD, r2=DESK_HOLE_RAD-(DESK_HOLE_RAD*draft_per));
        
        color("MediumBlue"){
          rotate_count(10){
            translate([0, DESK_HOLE_RAD-(DESK_HOLE_RAD*draft_per/1.25), 0])
              cylinder(h=DESK_TH-(DESK_TH*0.25), r1=1, r2=0.35);
          }
        }
      }
  }
    angle_disc(RIM_TH, innerRad);
  }
}


module insert_plug() {
  spacing=$slop/sqrt(2);
  totalThickness=DESK_TH+BRIM_TH;
  radius=DESK_HOLE_RAD-RIM_TH-spacing;
  
  difference(){
    color("LawnGreen"){
      union(){
          angle_disc(RIM_TH, radius);
        
        cylinder(h=totalThickness, r=radius);
      }
    }
    
    color("Red"){
      slotWidth=WIRE_RAD*2;
      translate([0,0,totalThickness/2])
        mirror_copy([0,0,1])
          rotate_count(WIRE_COUNT, WIRE_SEP){
            translate([0,radius-WIRE_RAD,0]){
              translate([-WIRE_RAD,0,0]){
                cube([WIRE_RAD*2,WIRE_RAD*2,totalThickness/2]);
                translate([0,0,totalThickness/2])
                  innerRectFillet(s=[WIRE_RAD*2, WIRE_RAD*2],
                                  w=WIRE_FILLET,
                                  profile="flat");
            }
              
              cylinder(h=totalThickness/2, r=WIRE_RAD);
              translate([0,0,totalThickness/2])
                innerCircFillet(r=WIRE_RAD, w=WIRE_FILLET, profile="flat");
            }
          }
    }
    
  }
}

module make() {
  size=(DESK_HOLE_RAD+BRIM_RAD)*2;
  half([size,size,DESK_TH+BRIM_TH], CUT_IN_HALF){
    insert_ring();
    !insert_plug();
  }
}

make();
