/**
 * Rubber Stopper for JK Projector Reels
 *
 * To be used as a negative in a 2-part mold to cast stoppers
 * in rubber or silicone.
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
 
 //reference
 //cylinder(r = 6.57 / 2, h = 50, center = true, $fn=60);
 rotate([0, 0, time]) rubber_stopper_jk_projector();