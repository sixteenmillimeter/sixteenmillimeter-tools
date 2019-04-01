time = 0;
D = 55;

module funnel () {
	   $fn = 50;
	difference () {
       cylinder(r1 = (25.4 / 8) * 0.7 + .5, r2 = (25.4 / 8) * 1.3 + .5, h = 15, center = true);
		cylinder(r1 = ((25.4 / 8) * 0.7) - 1, r2 = ((25.4 / 8) * 1.3) - 1, h = 15 + .1, center = true);
	}
	translate([0, 0, 17.5]) difference () {
       cylinder(r2 = 20 + .5, r1 = (25.4 / 8) * 1.3 + .5, h = 20, center = true);
		cylinder(r2 = 20 - 1, r1 = ((25.4 / 8) * 1.3) - 1, h = 20 + .1, center = true);
	}
}

module tank (thickness, DEBUG = false) {
    $fn = 100;
    H = 16.5 + 3;
    //main body
	difference () {
    	cylinder(r = (D / 2) + thickness, h = H + thickness, center = true);
        translate([0, 0, thickness]) cylinder(r = (D / 2), h = H + thickness, center = true);
        //for intake
        //translate([0, 34, -7]) cube([6.5, 20, 2.5], center = true);
        translate([0, 39, 1]) rotate([0, 0, 35.5]) translate ([0, -13, -6]) rotate([0, 90, 90]) cylinder(r = 2, h = 13, center = true);
        if (DEBUG){ //
            translate([(D + 10) / 2, 0, 0]) cube([D + 10, D + 10, D + 10], center = true);
        }
  	}
    //light trap
    translate([0, 39, 1]) rotate([0, 0, 35.5]) {
        //
        translate([0, -6, 0]) rotate([0, -90, 180]) {
            difference () {
                union () {
                    //bend(5);
                    translate([-5.75, -6, 0]) cube([12, 11, 10], center = true);
                }
                bend(2);
            }
        }
        translate ([0, -13, -6]) {
            rotate([0, 90, 90]) {
                difference () {
                    union () {
                        cylinder(r = 5, h = 15, center = true);
                        translate([2.75, 0, 0]) cube([6, 10, 15], center = true);
                    }
                    cylinder(r = 2, h = 15 + 1, center = true);
                    translate([0, 3, -10]) rotate([50, 0, 0]) cube([15, 25, 15], center = true);
                }
            }
        }
        translate([0, 0, 2.5]) barbed_fitting();
    }
}

module barbed_fitting () {
    ID = 25.4 / 4;
    D = 4;
    H = 15;
    difference () {
        union () {
            for (i = [0 : 2]) {
                translate([0, 0, i * (H / 3)]) cylinder(r1 = (ID * 1.15) / 2, r2 = (ID * 0.85) / 2, h = H / 3, center = true);
            }
        }
        cylinder(r = D / 2, h = H * 2, center = true);
    }
}


module bend (R = 4) {
    difference () {
        rotate_extrude(convexity = 10, angle = 90, $fn = 60) {
            translate([6, 0, 0]) circle(r = R);
        }
        translate([15, 0, 0]) cube([30, 30, 30], center = true);
        translate([0, 15, 0]) cube([30, 30, 30], center = true);
    }
}

//translate([0, 0, 19]) reel();
//translate([0, 0, 25]) tank_inner();

rotate([0, 0, time]) tank(2);
//translate([0, 0, 39]) tank_cover(2);

//rotate([180, 0, 0]) funnel();