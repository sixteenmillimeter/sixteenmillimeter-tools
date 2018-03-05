t = 0;
include <../../libraries/threads.scad>;

FINE = 60;

module base () {
    $fn = FINE;
    BUMP = 2;
    BUMPS = 6;
    TOP_H = 9.5;
    union() {
        translate([0, 0, -15])cylinder(r = 8.45, h = 20, center = true);
        //hex top
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
        //negative cylinder (reference)
        //translate([0, 0, -20]) cylinder(r = 13.6 / 2, h = 20, center = true, $fn = 100);
        
        //negative plug (reference)
        //translate([0, 0, -20]) cylinder(r = 12 / 2, h = 20, center = true, $fn = FINE);
        translate([0, 0, -30]) {
            metric_thread (diameter=13.6 + .5, pitch=1.5, thread_size = 1.6, length = 20);
            translate([0, 0, 0.25]) metric_thread (diameter=13.6 + .5, pitch=1.5, thread_size = 1.6, length = 20);
        }
   }

    difference () {
        //outer screw
        //translate([0, 0, -7.1]) metric_thread (diameter=10, pitch=1.5, length=27.1);
        //taper top of screw
        translate([0, 0, 19]) difference() {
            cylinder(r = 8, h = 3.5, center = true, $fn = FINE);
            cylinder(r1 = 6, r2 = 3, h = 4.5, center = true, $fn = FINE);
        }
        //hollow center
        cylinder(r = 3.8 / 2, h = 100, center = true, $fn = 60);
    }
}
difference() {
    //color("green")
	//center
	translate([0, 0, 29]) lomo_bottom_screw();
 
    translate([-25, 0, 29]) cube([50, 50, 100], center = true);
}

//translate([0, 0, 7]) cylinder(r = 13.6 / 2, h = 20, center = true, $fn = 100);
        
translate([0, 0, -20]) rotate([0, 0, t]) difference() {

    //translate([-100, 0, 0])cube([200, 200, 200], center = true);
}

translate([0, 0, -30]) {
    //metric_thread (diameter=13.6, pitch=1.5 ,thread_size = 1.6, length = 20);
}


