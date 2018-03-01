t = 0;
include <../../libraries/threads.scad>;

D = 50;
THICKNESS = 2.5;
H = 23;
ROUND = 6;

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
        translate([200, 0, 0]) cube([400, 400, 400], center = true);
        //reference cylinder
        //color("red") translate([0, 0, -H / 4]) cylinder(r = (D / 2), h = H, center = true);
    }
    /*
    //spindle
    translate([0, 0, 4]) cylinder(r1 = 12 / 2, r2 = 9 / 2, h = 40, center = true, $fn = 60);
    //spindle top
    translate([0, 0, 27]) difference () {
        minkowski() {
            cylinder(r = 5 / 2, h = 20, center = true, $fn = 60);
            sphere(r = 2, center = true, $fn = 60);
        }
        for (i = [0: 5]) {
            rotate([0, 0, i * (360 / 6)]) translate([4.7, 0, 0]) cylinder(r = 1, h = 30, center = true, $fn = 20);
        }
    }*/
	//handle
	translate([0, 0, -14.5]) {
		cylinder(r1 = 16/ 2, r2 = 13 / 2, h = 54.5, $fn = 100);
	}
	//screw
	translate([0, 0, -36]) metric_thread (diameter=13.8, pitch=1.5, length=20.5);
}

rotate([0, 0, t]) lomo_top_screw();