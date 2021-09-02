include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>
include <aqu-suction-cup-pin.scad>

// ALL VALUES IN MILLIMETERS

// ARC PRECISION
$fn = 50;
// PART INTERFERENCE/FIT COMPENSATION
$slop = 0.4;

/**
* FeedingRing
*/
module FeedingRingMOUNT() {

}

module FeedingRingARM(length=50) {

}

// RENDER

FeedingRingMOUNT();

FeedingRingARM();
