$fn = 75;

translate([- 20, 22, 170])
  #sphere(d = 16);


//intersection() {
//translate([-100,-100,0])
//#cube([200,200,170]);

scale(1.45) {
  import("./ref/Lockcap.stl");
  import("./ref/Track.stl");
  import("./ref/Spiral.stl");
  import("./ref/TopCap_2.0.stl");
}

//import("./ref/Stronger_Marble_Machine_3.stl");
//import("./ref/Track-big.stl");
