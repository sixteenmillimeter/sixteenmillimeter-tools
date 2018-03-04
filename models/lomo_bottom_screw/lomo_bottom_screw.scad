t = 0;
include <../../libraries/threads.scad>;

module base () {
    $fn = 100;
    BUMP = 2;
    BUMPS = 6;
    TOP_H = 9.5;
    union() {
        translate([0, 0, -15])cylinder(r = 8.45, h = 20, center = true);
        //translate([0, 0, -24.5])cylinder(r = 11.1, h = 9.5, center = true, $fn = 6);
		translate([0, 0, -24.5]) cylinder(r = 19 / 2, h = TOP_H, center = true); 
        for (i = [0 : BUMPS]) {
            rotate([0, 0, (360 / BUMPS) * i]) translate([0, 8.9, -24.5]) cylinder(r = BUMP, h = TOP_H, center = true, $fn = 60);
        }
    }
}

module lomo_bottom_screw () {
    difference () {
        base();
        //
        translate([0, 0, -20]) cylinder(r = 14 / 2, h = 20, center = true, $fn = 100);
    }

    difference () {
        //outer screw
        translate([0, 0, -7.1]) metric_thread (diameter=10, pitch=1.5, length=27.1);
        //taper top of screw
        translate([0, 0, 19]) difference() {
            cylinder(r = 8, h = 3.5, center = true, $fn = 100);
            cylinder(r1 = 6, r2 = 3, h = 4.5, center = true, $fn = 100);
        }
        //hollow center
        cylinder(r = 3.8 / 2, h = 100, center = true, $fn = 60);
    }
}
difference() {
    //color("green")
	//center
	translate([0, 0, 29]) lomo_bottom_screw();
    //translate([37, -3.25, 0]) import("./lomo_part_fixed.stl");
    translate([-50, 0, 29]) cube([100, 100, 100], center = true);
}

translate([0, 0, -20]) rotate([0, 0, t]) difference() {
    rotate([0, 180, 0]) import("../lomo_top_screw/lomo_top_screw.stl");
    //translate([-100, 0, 0])cube([200, 200, 200], center = true);
}


