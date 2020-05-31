/* [Bolt holes in the corners] */

// Pick the size of the long threaded rods that run through
// the corners and hold everything together.
//
// These are the sizes that are commonly available at
// Home Depot or Lowes:
//
// 1/4 inch: 3.175
// #12     : 2.778125
// #10     : 2.38125 (default and recommended)
//
// Note: you should pick the same size and fudge factor
// for the frame parts.
bolt_size = 2.38125;

// Make the bolt holes this much bigger than the size of the bolt
// to give a more comfortable fit
bolt_hole_fudge = 0.2; // [0:0.25:1]


/* [Bolt holes for mounting to the rack] */

// The size of the bolt holes for mounting to the server rack.
// The default is for M6 bolts.
ear_bolt_size = 3;

// Make the ear bolt holes this much longer than they are wide
// in case the entire assembled rack is not precisely the right
// length.
ear_bolt_stretch = 3;

// Set the entire rack this far back into the rack. This provides
// space to prevent cage nuts from running into the nuts at the
// ends of the support rods.
setback = 6;


/* [Hidden] */

module copy_mirror(vec=[1, 0, 0]) {
    children();
    mirror(vec) children();
}

bolt_column_size = 12;
floor_depth = 3;

width = 33.1423 + bolt_column_size - floor_depth;
length = 90 + setback;
height = 5;
frame_width = 15.875;
distance_to_frame = 10;
distance_between_bolt_holes = 15.875 * 2;
ear_height = distance_to_frame + frame_width;

tray_depth = 5;
tray_slot_depth = 2.5;
spacer_depth = 3;
pcb_height = floor_depth + tray_depth + spacer_depth;
pillar_width = 10;
epsilon = 0.001;

bolt_radius = bolt_size + bolt_hole_fudge;

ear_bolt_radius = ear_bolt_size + bolt_hole_fudge;

copy_mirror() {
    translate([10, 0, 0]) {
        difference() {
            union() {
                // the main tray block
                translate([0, -epsilon, 0]) {
                    cube([width, length + epsilon, height]);
                }
                
                // the ear
                translate([0, -height, 0]) {
                    cube([width, height, ear_height]);
                }
                
                // reinforce the joint
                translate([0, 0, 0]) {
                    rotate([45, 0, 0]) {
                        cube([width, height-0.5, height-0.5]);
                    }
                }
                
                translate([bolt_column_size, 0, 0]) {
                    rotate([45, 0, 0]) {
                        cube([width - bolt_column_size, height+1, height+1]);
                    }
                }
            }
            
            // trim the back bolt hole column
            translate([ -4, length, -epsilon]) {
                rotate([0, 0, -45]) {
                    cube([5, 5, height + 2*epsilon]);
                }
            }
            
            // drill the bolt holes
            for (a=[setback + bolt_column_size/2, length-bolt_column_size/2]) {
                translate([bolt_column_size/2, a, -epsilon]) {
                    cylinder(   h=height + 2*epsilon,
                                r=bolt_radius,
                                center=false,
                                $fn=360);
                }
            }
        
            // cut a window in the floor
            translate([ pcb_height + bolt_column_size - floor_depth,
                        pillar_width + setback,
                        -epsilon]) {
                cube([  width - bolt_column_size + floor_depth - 2*tray_depth - 2*floor_depth,
                        length - 2*pillar_width - setback,
                        height + 2*epsilon]);
            }
            
            // cut the bolt hole in the ear
             for (a=[   width/2 - distance_between_bolt_holes/2,
                        width/2 + distance_between_bolt_holes/2]) {
                for (b=[-ear_bolt_stretch/2, ear_bolt_stretch/2]) {
                    translate([ a,
                                -height-epsilon,
                                ear_height - frame_width/2 + b]) {
                        rotate([-90,0,0]) {
                            cylinder(   h=height + 2*epsilon,
                                        r=ear_bolt_radius,
                                        center=false,
                                        $fn=360);
                        }
                    }
                }
                translate([ a - ear_bolt_radius,
                            -height-epsilon,
                            ear_height - frame_width/2 - ear_bolt_stretch/2]) {
                    cube([  ear_bolt_radius*2,
                            height + 2*epsilon,
                            ear_bolt_stretch]);
                }
            }
        }
    }
}