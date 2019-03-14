/**
 * Sprocketed Roller Disc
 **/

time = 0;

module elmo_cl_sprocketed_roller_sprocket_disc () {
    SPROCKETS = 12;
    OUTER_D = 28.54;
    INNER_D = 14;
    H = 1;
    SPROCKET_H = 0.9;
    SPROCKET_W = 0.79;
    SPROCKET_L = 0.99;
    
    $fn = 200;

    //sub module
    module sprocket () {
      $fn = 40;
        //cube([SPROCKET_L, SPROCKET_W, SPROCKET_H], center = true);
        translate ([0, 0, -SPROCKET_H/2]) {
            difference () {
                translate([0, 0, 0]) scale([1, 1, 2.25]) rotate([90, 0, 90]) cylinder(r = SPROCKET_W/2, h = SPROCKET_L, center = true);
                translate([0, 0, -1]) cube([2, 2, 2], center = true);
                translate([1.5, 0, 0]) rotate([0, -5, 0]) cube([2, 2, 2], center = true);
                translate([-1.5, 0, 0]) rotate([0, 5, 0]) cube([2, 2, 2], center = true);
           }
       }

    }
    difference() {
    	cylinder(r = OUTER_D / 2, h = H, center = true);
        cylinder(r = INNER_D / 2, h = H + 1, center = true);
        translate([7 + 1.5, 0, 0]) cylinder(r = 2 / 2, h = H + 1, center = true, $fn = 30);
    }
  	
    for (i = [0: SPROCKETS - 1]) {
  		rotate([0, 0, (i * (360 / SPROCKETS)) + (360 / (SPROCKETS * 2))]) translate([OUTER_D /2 + 0.4, 0, 0]) rotate([0, 90, 0]) sprocket();
    }
}


rotate([0, 0, time]) elmo_cl_sprocketed_roller_sprocket_disc ();