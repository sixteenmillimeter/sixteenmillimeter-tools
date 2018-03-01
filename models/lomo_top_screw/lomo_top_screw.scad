t = 0;
include <../../libraries/threads.scad>;


D = 50;
THICKNESS = 2.5;
H = 23;
ROUND = 6;

module handle () {
    cylinder(r1 = 16 / 2, r2 = 12.6 / 2, h = 54.2, center = true, $fn = 100);     
}

module lomo_top_screw () {
    difference () {
        translate([0, 0, ROUND + 2.75]) minkowski () {
            cylinder(r = (D / 2) - ROUND, h = (H * 2) - ROUND, center = true, $fn = 100);
            sphere(r = ROUND, center = true, $fn = 100);
        }
        translate([0, 0, ROUND + 2.75 + THICKNESS]) minkowski () {
            cylinder(r = (D / 2) - THICKNESS - ROUND, h = (H * 2) - ROUND, center = true, $fn = 100);
            sphere(r = ROUND, center = true, $fn = 100);
        }
        translate([0, 0, H + ROUND - 0.4]) cylinder(r = (D / 2) + 1, h = H * 2, center = true);
        //CUT IN HALF
        //translate([200, 0, 0]) cube([400, 400, 400], center = true);
        //reference cylinder
        //color("red") translate([0, 0, -H / 4]) cylinder(r = (D / 2), h = H, center = true);
        //hole
        translate([20, 0, -20]) cylinder(r = 3 / 2, h = 20, center = true, $fn = 60);
    }
    
     //handle
    translate([0, 0, 12]) handle();
     //screw
    translate([0, 0, -37]) {
        translate([0, 0, 1] ) metric_thread (diameter=13.8, pitch=1.5,thread_size = 1.6, length = 21);
         translate([0, 0, 21.5 / 2]) cylinder(r = 12.2 / 2, h = 21.5, center = true, $fn = 100);
    }
    
}
//translate([0, 0, -45]) rotate([0, 180, 0]) import("../lomo_bottom_screw/lomo_part_half.stl");
//rotate([0, 0, t]) lomo_top_screw();

metric_thread (diameter=13.8, pitch=1.5,thread_size = 1.6, length = 21);