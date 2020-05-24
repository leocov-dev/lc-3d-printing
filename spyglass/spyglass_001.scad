$fn=75;

interf=0.3;
height=75;
radius=25;
thickness=1.75;
SLICE_IN_HALF=false;

module half(height, radius, active=true) {
  if (active==true) {
    scale=5;
    block=radius*scale;
    difference() {
      children();
      translate([0,-radius*1.5,-height/2])
        cube([block,block,height*scale]);
    }
  } else {
    children();
  }
}

module rotate_count(count) {
  for (i=[1 : count]){
    children();
    rotate([0,0,(360/count)*i])
      children();
  }
}

module make_section(height, radius, cap, rim) {
  make_tube(height, radius);
  if (cap)
    make_cap(height, radius);
  if (rim)
    make_rim(height, radius);
}

module make_tube(height, radius) {
  difference() {
    cylinder(h=height, r=radius);
    translate([0,0,-thickness/2])
      cylinder(h=height+thickness, r=radius-thickness);
  }
}

module make_cap(height, radius) {
  color("PowderBlue") {
    translate([0,0,height]){
      difference() {
        difference() {
          union() {
            cylinder(h=thickness*2, r=radius);
            translate([0,0,thickness*2])
              cylinder(h=thickness*2, r1=radius, r2=radius-thickness);
          }
          translate([0,0,-thickness])
            cylinder(h=thickness*6, r=radius-(thickness*2));
        }
        cylinder(h=thickness, r1=radius-thickness, r2=radius-thickness*2);
      }
    }
  }
}

module make_rim(height, radius) {
  rim_r = radius+thickness;
  bevel=thickness/2;
  rim_th=thickness*5;
  
  color("LightCoral") {
    difference(){
      translate([0,0,bevel])
        minkowski() {
          sphere(bevel);
          cylinder(h=(rim_th)-(bevel*2), r=rim_r-bevel);
        }
      
      translate([0,0,-rim_th/2])
        cylinder(h=rim_th*2, r=radius-thickness);
    }
  }
}

module make_retainer(height, radius) {
  color("Magenta"){
    difference(){
      difference(){
        cylinder(h=thickness*5, r=radius-thickness-interf/2);
        translate([0,0,-thickness/2])
          cylinder(h=thickness*6, r=radius-thickness*2-interf/2);
      }
      translate([-thickness/4,radius-thickness*3,-thickness/2])
        cube([thickness/2,thickness*3,thickness*6]);
    }
  }
}

module make_front(height, radius) {
  cap_height=height/3;
  
  color("SpringGreen"){
    translate([0,0,-cap_height - 1]){
    
    difference() {
      union(){
        cylinder(h=cap_height, r=radius);
        cylinder(h=cap_height+thickness*3, r=radius-thickness-(interf/2));
        
        translate([0,0,-5]){
          minkowski(){
            sphere(r=thickness);
            cylinder(h=thickness*3, r=radius);
          }
        }
      }
      translate([0,0,-cap_height/2])
        cylinder(h=cap_height*2, r=radius-thickness*2);
    }
    
    rotate_count(30) {
    translate([0, radius,0]) {
        rib_r=radius/28;
        translate([0,0,cap_height-rib_r])
          sphere(r=rib_r);
        translate([0,0,-rib_r])
          cylinder(h=cap_height, r=rib_r);
      }
    }
  }
  }
}



module make_eye(height, radius) {
  eye_height = height/8;
  
  color("SteelBlue"){
    translate([0,0,height+interf]){
      
      difference() {
        union(){
          cylinder(h=eye_height, r=radius);
          translate([0,0,-thickness*2])
            cylinder(h=eye_height+(thickness*2), r=radius-thickness-interf/2);
          
          translate([0,0,thickness+(eye_height-thickness*4)]){
            minkowski(){
              sphere(r=thickness);
              cylinder(h=thickness*2, r=radius);
            }
          }
        }
        
        translate([0,0,-eye_height/2])
          cylinder(h=eye_height*2, r=radius-thickness*2);
      }
    }
  }
}

module make_display(height, radius, count=3) {
  count = count-1;
  
  for (i=[0 : count]) {
    add_cap= i != count;
    add_rim=i>0;
    
    h_offset=(height-(thickness*5.5))*i;
    scaled_rad=radius-((thickness*2+interf) * i);
    
    translate([0,0,h_offset]) {
      make_section(height, scaled_rad, add_cap, add_rim);
      
      if (add_rim)
        make_retainer(height, scaled_rad);
    
      if (!add_cap)
        make_eye(height, scaled_rad);
    }
  }
  
  make_front(height, radius);
}

module make_for_print(height, radius) {
  separation=radius*2.8;
  
  // FRONT CAP
  translate([0,0,(height/2)-(thickness*4)-(interf/2)])
    make_front(height, radius);
  
  // FIRST SECTION
  translate([0, separation, 0])
    make_section(height, radius, true, false);
  
  // SECOND SECTION
  translate([separation,separation, 0]) {
    make_section(height, radius-(thickness*2+interf), true, true);
//    translate([separation,0,0])
//      make_retainer(height, radius-(thickness*2+interf));
  }
  
  // THIRD SECTION
  translate([separation, 0, 0])
    make_section(height, radius-((thickness*2+interf) * 2), false, true);
  
  // EYE PIECE
  translate([separation/2,separation/2, height+(interf*3)+(thickness*6)])
    rotate([180,0,0])
      make_eye(height, radius-((thickness*2+interf) * 2));
}

half(height*2, radius, SLICE_IN_HALF) {
//  make_display(height, radius);
  make_for_print(height, radius);
}