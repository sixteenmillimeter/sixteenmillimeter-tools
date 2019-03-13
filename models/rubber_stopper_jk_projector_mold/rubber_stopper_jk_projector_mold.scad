

/**
 * Mold for Rubber Stopper for JK Projector Reels
 *
 * 2-part mold to cast stoppers in rubber or silicone.
 **/
 
 time=0;
 
  module rubber_stopper_jk_projector () {
    OD = 19;
    ID = 6.57;
    H = 23;
    TRIANGLE = 9.44 +2.5;
    ROUND_D = 2;

    $fn = 120;

    difference () {
        //outer cylinder
        cylinder(r = OD / 2, h = H, center = true);
        //rounded corners
        for (i = [0 : 2]) {
            rotate([0, 0, 120 * i]) {
                translate ([(TRIANGLE / 2) - (ROUND_D), 0, 0]) {
                    cylinder(r = ROUND_D / 2, h = H + 1, center = true);
                }
            }
        }
        //triangle 
        difference () {
            cylinder(r = TRIANGLE / 2, h = H + 1, center = true, $fn = 3);
            for (i = [0 : 2]) {
                rotate([0, 0, 120 * i]) {
                    translate ([(TRIANGLE / 2) - .5, 0, 0]) {
                        cube([ROUND_D, ROUND_D, H + 1], center = true);
                    }
                }
            }
        }
    } 
 }
 
 module rubber_stopper_jk_projector_mold_center() {
    OD = 25;
    H = 25;
    $fn = 120;
    difference () {
        cylinder(r = OD / 2, h = H, center = true);
        translate([0, 0, 1.01]) rubber_stopper_jk_projector ();
        translate([0, 0, 2]) {
            difference () {
                cube([25, 25, 25], center = true);
                translate([0, 0, 0]) cube([12, 12, 25], center = true);
            }
        }
    }
 }
 
module rubber_stopper_jk_projector_mold_side() {
    OD = 27;
    H = 25;
    $fn = 120;
    difference () {
        union () {
            cylinder(r = OD / 2, h = H, center = true);
            intersection () {
                cylinder(r = 29 / 2, h = H + 0.01, center = true);
                cube([30, 5, H], center = true);
            }
        }
        translate([0, 0, -(H / 2) + 1 -.01]) cylinder(r = 25 / 2, h = 2, center = true);
        cylinder(r = 23 / 2, h = H + 0.01, center = true);
        translate([0, 15, 0]) cube([30, 30, H + 1], center = true);
        translate([13, 0, 0]) rotate([0, 0, 45]) cube([1.5, 1.5, H + 1], center = true);  
    }
    translate([-13, 0, 0]) rotate([0, 0, 45]) cube([1.45, 1.45, H], center = true);
 }
 
 rotate([0, 0, time]) {
     rubber_stopper_jk_projector_mold_center();
     translate([0, -10, 0]) rotate([0, 180, 0]) rubber_stopper_jk_projector_mold_side();
     translate([0, 10, 0]) rotate([0, 180, 180]) rubber_stopper_jk_projector_mold_side();
 }