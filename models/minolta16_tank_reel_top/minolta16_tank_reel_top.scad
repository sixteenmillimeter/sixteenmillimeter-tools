time = 0;
D = 55;

module minolta16_tank_reel_top (DEBUG = false) {
    $fn = 100;
    //under lattuce
    for (i = [0 : 3]) {
         rotate([0, 0, i * (360 / 3)]) cube([D - 5.5, 4, 2], center = true);
    }  
    difference () {
    	cylinder(r = (D / 2) - 2.5, h = 2, center = true);
        translate([0, 0, 0]) cylinder(r = (D / 2) - 5, h = 2 + 1, center = true);
        if (DEBUG){
            translate([(D + 10) / 2, 0, 0]) cube([D + 10, D + 10, D + 10], center = true);
        }
  	}
    translate([0, 0, 4]) difference () {
    	cylinder(r = 11, h = 10, center = true);
        translate([0, 0, 2]) cylinder(r = 11 - 2, h = 10, center = true);
        if (DEBUG){
            translate([(D + 10) / 2, 0, 0]) cube([D + 10, D + 10, D + 10], center = true);
        }
  	}           
}

rotate([0, 0, time]) minolta16_tank_reel_top();