t = 0;
include <../../libraries/threads.scad>;
include <../../libraries/Triangles.scad>;

D = 50;
THICKNESS = 2.5;
H = 19.5;
ROUND = 8;
HANDLE_D = 13.25;
NOTCHES = 17;
NOTCH = 1.5;
FINE = 20;

module lomo_top_screw () {
    difference () {
        translate([0, 0, ROUND - 2]) minkowski () {
            cylinder(r = (D / 2) - ROUND, h = (H * 2) - ROUND, center = true, $fn = FINE);
            sphere(r = ROUND, center = true, $fn = FINE);
        }
        translate([0, 0, ROUND  - 2+ THICKNESS]) minkowski () {
            cylinder(r = (D / 2) - THICKNESS - ROUND, h = (H * 2) - ROUND, center = true, $fn = 200);
            sphere(r = ROUND, center = true, $fn = FINE);
        }
        translate([0, 0, H + ROUND - 4 -  3]) cylinder(r = (D / 2) + 1, h = H * 2, center = true);
        //half
        //translate([45, 0, 0]) cube([90, 90, 90], center = true);
    //}
        
        //bevel
        //inner bevel
        translate([0, 0, (H / 2) - ROUND - 1]) cylinder(r1 = (D / 2) - 2.5, r2 = (D / 2) - 2.5 + 1, h = 1, center = true, $fn = FINE);
        //outer bevel
        translate([0, 0, (H / 2) - ROUND - 1]) {
            difference () {
                cylinder(r = (D / 2) + .25, h = 1, center = true, $fn = FINE);
                cylinder(r2 = (D / 2) - .8, r1 = (D / 2) - .8 + 1, h = 1, center = true, $fn = FINE);
            }
        }
    }
    //reference cylinder
    //translate([0, 0, -6.6]) color("red") cylinder(r = 50 / 2, h = 19.57, center = true);

	//handle
	translate([0, 0, -15]) {
        difference() {
            cylinder(r1 = 16/ 2, r2 = 13 / 2, h = 54.5, $fn = FINE);
            //ring
            translate([0, 0, 31 + 14.5]) {
                difference () {
                        cylinder(r = HANDLE_D / 2 + 2, h = 20, center = true);
                        cylinder(r = HANDLE_D / 2 - .5, h = 20 + 1, center = true);
                }
            }
            for(i = [0 : NOTCHES]) {
                rotate([0, 0, i * (360 / NOTCHES)]) {
                    translate([0, HANDLE_D / 2 - .5, 31 + 14.5]) {
                       rotate([0.75, 0, 0]) rotate([0, 0, 45]) { 
                           Right_Angled_Triangle(a = NOTCH, b = NOTCH, height = 20, centerXYZ=[true, true, true]);
                       }
                    }
                }
		    }
        }
	}
    //attach handel with pyramid cylinder
    translate ([0, 0, -13.7]) {
        cylinder(r1 = 16 / 2 + 2, r2 = 16 / 2 - .1, h = 3, center = true, $fn = FINE);
    }
    //plate under cup
    translate([0, 0, -17.75]) cylinder(r = 31.5 / 2, h = 1, center = true, $fn = FINE);
	//screw
	//translate([0, 0, -37.5]) metric_thread (diameter=13.6, pitch=1.5 ,thread_size = 1.6, length = 21);
    //cylinder plug
    translate([0, 0, -37.5 + (21 / 2) - 1]) cylinder(r = 12 / 2, h = 21, center = true, $fn = FINE);
}
//import("./lomo_part_half.stl");
rotate([0, 0, t]) lomo_top_screw();