t = 0;
include <../../libraries/threads.scad>;
include <../../libraries/Triangles.scad>;

D = 50;
THICKNESS = 2.5;
H = 23;
ROUND = 6;
HANDLE_D = 13.25;
NOTCHES = 17;
NOTCH = 1.5;

module lomo_top_screw () {
    difference () {
        translate([0, 0, ROUND + 2.75]) minkowski () {
            cylinder(r = (D / 2) - ROUND, h = (H * 2) - ROUND, center = true, $fn = 200);
            sphere(r = ROUND, center = true, $fn = 200);
        }
        translate([0, 0, ROUND + 2.75 + THICKNESS]) minkowski () {
            cylinder(r = (D / 2) - THICKNESS - ROUND, h = (H * 2) - ROUND, center = true, $fn = 200);
            sphere(r = ROUND, center = true, $fn = 200);
        }
        translate([0, 0, H + ROUND - 0.4]) cylinder(r = (D / 2) + 1, h = H * 2, center = true);
        //bevel
    }
	//handle
	translate([0, 0, -14.5]) {
        difference() {
            cylinder(r1 = 16/ 2, r2 = 13 / 2, h = 54.5, $fn = 100);
            for(i = [0 : NOTCHES]) {
                rotate([0, 0, i * (360 / NOTCHES)]) {
                    translate([0, HANDLE_D / 2, 31 + 14.5]) {
                       rotate([1, 0, 0]) rotate([0, 0, 45]) { 
                           Right_Angled_Triangle(a = NOTCH, b = NOTCH, height = 20, centerXYZ=[true, true, true]);
                       }
                    }
                }
		    }
        }
	}

	//screw
	translate([0, 0, -36]) metric_thread (diameter=13.6, pitch=1.5 ,thread_size = 1.6, length = 21);
}
//import("./lomo_part_half.stl");
rotate([0, 0, t]) lomo_top_screw();