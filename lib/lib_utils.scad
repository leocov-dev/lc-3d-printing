/**
* cut a model in half, removing the +x portion
*/
module half(bounds, active=true) {
  x=bounds[0] + (bounds[0]*0.1);
  y=bounds[1] + (bounds[1]*0.1);;
  z=bounds[2] + (bounds[2]*0.1);;
  
  if (active==true) {
    difference() {
      children();
      translate([0,-y/2,-(bounds[2]*0.1)/2])
        color("Crimson")
          cube([x/2,y,z]);
    }
  } else {
    children();
  }
}

module mirror_copy(v=[0,0,1], offset=[0,0,0]){
  children();
  mirror(v)translate(offset)children();
}

/**
* duplicate and rotate the children around the y axis
*/
module rotate_count(count, deg=0) {
  if (count == 1){
    children();
  } else if (count > 1){
    for (i=[1 : count-1]){
      children();
      if (deg>0){
        rotate([0,0,deg*i])
          children();
      } else {
        rotate([0,0,(360/count)*i])
          children();
      }
    }
  }
}

/**
* cut a hole in child objects along the Z axis
*/
module hole(d, r, draft=0, trans=[0,0,0], rot=[0,0,0]){
  difference(){
    children();
    translate(trans){
      rotate(rot)
      rotate([180,0,0]){
        if (draft>0) {
          opp_ang=90-draft;
          top_r=r+(d/sin(opp_ang)*sin(draft));
          cylinder(h=d, r1=top_r, r2=r);
        } else {
          cylinder(h=d, r=r);
        }
      }
    }
  }
  
}

/**
*
*/
module multiHull(){
    for (i = [1 : $children-1])
        hull(){
            children(0);
            children(i);
        }
}

/**
*
*/
module sequentialHull(){
    for (i = [0: $children-2])
        hull(){
            children(i);
            children(i+1);
        }
}

module innerRectFillet(s=[2,2], w=1, profile="flat"){
  w=w/sqrt(2);
  if(profile=="flat"){
    translate([-w,-w,0])
      cube([s[0]+w*2, s[1]+w*2, w*0.1]);
    CubePoints = [
      [     -w,      -w,   0 ],  //0
      [ s[0]+w,      -w,   0 ],  //1
      [ s[0]+w,  s[1]+w,   0 ],  //2
      [     -w,  s[1]+w,   0 ],  //3
      [      0,       0,  -w ],  //4
      [   s[0],       0,  -w ],  //5
      [   s[0],    s[1],  -w ],  //6
      [      0,    s[1],  -w ]]; //7
      
    CubeFaces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]]; // left
      
    polyhedron( CubePoints, CubeFaces );
  }
  else if(profile=="round"){
    f_fn=$fn/4;
    translate([-w,-w,-w]){
      difference(){
        cube([s[0]+w*2, s[1]+w*2, w+w*0.1]);
        union(){
          mirror_copy(offset=[0,s[1]+w*2, 0])
            rotate([0,90,0])
              cylinder(h=s[0]+w*2, r=w, $fn=f_fn);
          mirror_copy(offset=[s[0]+w*2,0,0])
            rotate([0,90,90])
              cylinder(h=s[1]+w*2, r=w, $fn=f_fn);
          
        }
      }
    }
  } else{
    assert(false, "profile must be one of [\"flat\", \"round\"]");
  }
}


module innerCircFillet(r=2, w=1, profile="flat", $fn=$fn){
  w=w/sqrt(2);
  if(profile=="flat"){
    cylinder(h=w*0.1, r=r+w);
    translate([0,0,-w])
      cylinder(h=w, r1=r, r2=r+w);
  }
  else if(profile=="round"){
    points=[[-w,r], [-w,0], [0,0], [w*0.1, 0], [w*0.1, r+w], [0,r+w]];
    arc = [ for (a = [0 : 9 : 90]) w * [ sin(a), -cos(a)] ];
    moved = [ for (i = arc) i+[-w, r+w]];
    
    rotate_extrude()
      rotate([0,0,90])
        polygon(concat(points, moved), convexity=5);
    
  } else{
    assert(false, "profile must be one of [\"flat\", \"round\"]");
  }
}