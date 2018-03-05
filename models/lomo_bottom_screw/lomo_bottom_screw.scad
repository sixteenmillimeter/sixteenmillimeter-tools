t = 0;
include <../../libraries/threads.scad>;

//RESOLUTION
FINE = 200;

module base ( HEX = false) {
	D = 8.45 * 2;
	H = 20;
	//for grip
	BUMP = 2; //diameter
	BUMPS = 6;
	TOP_D = 19;
	TOP_H = 9.5;
	TOP_OFFSET = -24.5;
	
    union() {
        translate([0, 0, -15]) {
			cylinder(r = D / 2, h = H, center = true, $fn = FINE);
		}
        //hex version
		if (HEX) {
			translate([0, 0, TOP_OFFSET]) {
				cylinder(r = 11.1, h = TOP_H, center = true, $fn = 6);
			}
		} else {
			translate([0, 0, TOP_OFFSET]) {
				cylinder(r = TOP_D / 2, h = TOP_H, center = true, $fn = FINE); 
			}
		}
        for (i = [0 : BUMPS]) {
            rotate([0, 0, (360 / BUMPS) * i]) {
				translate([0, 8.9, TOP_OFFSET]) {
					cylinder(r = BUMP, h = TOP_H, center = true, $fn = 60);
				}
			}
        }
    }
}

module outer_screw (LEN) {
	OD = 10;
	PITCH = 1.5;
	THREAD = 1.6;
	
	difference () {
		translate([0, 0, -7.1]) metric_thread (diameter=OD, pitch=PITCH, thread_size = THREAD, length=LEN);
        //bevel top of screw
        translate([0, 0, LEN - 8]) difference() {
            cylinder(r = 8, h = 3, center = true, $fn = FINE);
            cylinder(r1 = 6, r2 = 3, h = 3.01, center = true, $fn = FINE);
        }
	}
}

module lomo_bottom_screw (ALT = false, HEX = false) {
	OD = 13.6 + .5;
	PITCH = 1.5;
	THREAD = 1.6;
	IN_LEN = 21;
	
	LEN = 17.1;
	ALT_LEN = 27.1;
    difference () {
        base(HEX);
		//inner screw negative
        translate([0, 0, -30]) union() {
            metric_thread (diameter=OD, pitch=PITCH, thread_size = THREAD, length = IN_LEN);
            translate([0, 0, 0.2]) {
				metric_thread (diameter=OD, pitch=PITCH, thread_size = THREAD, length = IN_LEN);
			}
        }
   }

    difference () {
        //outer screw
		if (ALT) {
			outer_screw(ALT_LEN);
		} else {
			outer_screw(LEN);
		}
        //hollow center
        cylinder(r = 3.8 / 2, h = 100, center = true, $fn = 60);
    }
    
}

translate([0, 0, 29]) rotate([0, 0, t]) lomo_bottom_screw();


