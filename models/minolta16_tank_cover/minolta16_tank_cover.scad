time = 0;
D = 55;

module tank_cover (thickness, DEBUG = false) {
    $fn = 100;
    //outer rim
	difference () {
    	cylinder(r = (D / 2) + thickness + 2, h = 5, center = true);
        translate([0, 0, 0]) cylinder(r = (D / 2) + thickness, h = 5 + 1, center = true);
        if (DEBUG){
            translate([(D + 10) / 2, 0, 0]) cube([D + 10, D + 10, D + 10], center = true);
        }
  	}
      //inner rim
    translate([0, 0, 0.5]) difference () {
    	cylinder(r = (D / 2), h = 2, center = true);
        translate([0, 0, 0]) cylinder(r = (D / 2) - 2, h = 2 + 1, center = true);
        if (DEBUG){
            translate([(D + 10) / 2, 0, 0]) cube([D + 10, D + 10, D + 10], center = true);
        }
  	}
        //connector
    translate([0, 0, 2.5]) difference () {
    	cylinder(r = (D / 2) + thickness + 2, h = 2, center = true);
        translate([0, 0, 0]) cylinder(r = (D / 2) - 2, h = 2 + 1, center = true);
        if (DEBUG){
            translate([(D + 10) / 2, 0, 0]) cube([D + 10, D + 10, D + 10], center = true);
        }
  	}
    //main funnel
    translate([0, 0, 11]) difference () {
    	cylinder(r1 = (D / 2) + thickness + 2, r2 = 9, h = 15, center = true);
        translate([0, 0, -.6]) cylinder(r1 = (D / 2) - 2, r2 = 7 - 2, h = 14, center = true);
        cylinder(r = 7 - 2, h = 20 + 1, center = true);
        if (DEBUG){
            translate([(D + 10) / 2, 0, 0]) cube([D + 10, D + 10, D + 10], center = true);
        }
  	}
    //tube1
    translate([0, 0, 13.5]) difference () {
    	cylinder(r = 8, h = 10, center = true);
        translate([0, 0, 0]) cylinder(r = 7 - 2, h = 10 + 1, center = true);
        if (DEBUG){
            translate([(D + 10) / 2, 0, 0]) cube([D + 10, D + 10, D + 10], center = true);
        }
  	}
}
rotate([0, 0, time]) tank_cover(2);