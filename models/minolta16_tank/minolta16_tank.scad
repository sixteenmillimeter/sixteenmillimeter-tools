D = 55;

module equilateralTriangle (side=10, height=10, center=false){
  translate(center==true ? [-side/2,-sqrt(3)*side/6,-height/2] : [0,0,0]) 
    linear_extrude(height=height)
      polygon(points=[[0,0],[side,0],[side/2,sqrt(3)*side/2]]);
}

module spiral (START_D = 10, SPACING = 5, THICKNESS = 2, H = 10, SPIRALS = 39) {
    $fn = 80;
    START_R = START_D / 2;
    ROT = (360 / $fn);
    union () {
        for (i = [0 : $fn]) {
            rotate ([0, 0, i * ROT]) {
                for (x = [0: (SPIRALS - 1)]) {
                      spiral_facet(i, x, START_R, SPACING, THICKNESS, H);
                }
            }
        }
    }
}

module spiral_static_res (START_D = 10, SPACING = 5, THICKNESS = 2, H = 10, SPIRALS = 39) {
    $fn = 80;
    
    START_R = START_D / 2;
    
    SPACING_MAX = ((SPIRALS - 1) * (SPACING + THICKNESS));
    STEP_SIZE = ((SPACING + THICKNESS) / $fn); 
    STEP_OFFSET_MAX = $fn * STEP_SIZE;
    
    MAX_R = START_R + SPACING_MAX + STEP_OFFSET_MAX;
    echo(MAX_R);
    
    ROT = (360 / $fn);
    for (x = [0 : (SPIRALS - 1)]) {
        
        for (i = [0 : $fn]) {
            rotate ([0, 0, i * ROT]) spiral_facet(i, x, START_R, SPACING, THICKNESS, H);
        }
    }
}

module spiral_facet (i, x, START_R, SPACING, W, H) {
    STEP_SIZE = ((SPACING + W) / $fn); 
    
    STEP_OFFSET =  i * STEP_SIZE;
    SPIRAL_START_OFFSET = (x * (SPACING + W));
    
    ACTUAL_R = START_R + SPIRAL_START_OFFSET + STEP_OFFSET;
    L = 2 * (ACTUAL_R * tan((360 / $fn) / 2));
    ANGLE = -atan( STEP_SIZE / (L / 2) ) / 2;
    OFFSET = START_R - (W / 2) + SPIRAL_START_OFFSET + STEP_OFFSET;
    
    translate ([OFFSET, 0, - H / 2]) {
        rotate ([0, 0, ANGLE]) {
            cube([W, L, H], center=true);
        }
    }
}

module spiral_top (START_D = 10, SPACING = 5, THICKNESS = 2, H = 10, SPIRALS = 39) {
    $fn = 80;
    START_R = START_D / 2;
    union () {
        for (i = [0 : $fn]) {
            rotate ([0, 0, i * (360 / $fn)]) {
                for (x = [0: (SPIRALS - 1)]) {
                      spiral_top_facet(i, x, START_R, SPACING, THICKNESS, H);
                }
            }
        }
    }
}

module spiral_top_facet (i, x, START_R, SPACING, W, H) {
    STEP_SIZE = ((SPACING + W) / $fn); 
    
    STEP_OFFSET =  i * STEP_SIZE;
    SPIRAL_START_OFFSET = (x * (SPACING + W));
    
    ACTUAL_R = START_R + SPIRAL_START_OFFSET + STEP_OFFSET;
    L = 2 * (ACTUAL_R * tan((360 / $fn) / 2));
    ANGLE = -atan( STEP_SIZE / (L / 2) ) / 2;
    OFFSET = START_R - (W / 2) + SPIRAL_START_OFFSET + STEP_OFFSET;
    
    translate ([OFFSET, 0, - H / 2]) {
        rotate ([0, 0, ANGLE]) {
            //cube([W, L, H], center=true);
            rotate([90, 0, 0]) equilateralTriangle(side = W, height = L, center = true);
        }
    }
}
//rotate([90, 0, 90]) equilateralTriangle(side = 2, height = 5, center = true);
//cube([5, 2, 2] ,center = true);

module trapshape(L = 3) {
        difference () {
            cube([6, L, 4], center = true);
            translate([2.8, 0, 2]) rotate([0, 45, 0]) cube([5, L + 1, 4], center = true);
            translate([-2.8, 0, 2]) rotate([0, -45, 0]) cube([5, L + 1, 4], center = true);
        }
        
}

module trapshape2 () {
    difference () {
        cube([5, 10, 8], center = true);
        //mid
        translate([0, 0, -4]) rotate([45, 0, 0]) cube([5 + 1, 7, 7], center = true);
        //back (tank side)
        translate([0, -5, 4]) rotate([45, 0, 0]) cube([5 + 1, 5, 5], center = true);
        //front
        translate([0, 5, 4]) rotate([45, 0, 0]) cube([5 + 1, 5, 5], center = true);
        //top angles
        translate([2.5, 0, 5]) rotate([0, 45, 0]) cube([5, 10, 5], center = true);
        translate([-2.5, 0, 5]) rotate([0, 45, 0]) cube([5, 10, 5], center = true);
        //front angles
        translate([2.5, 0, 0]) rotate([-45, 0, 0]) translate([0, 0, 5]) rotate([0, 45, 0]) cube([5, 11, 5], center = true);
        translate([-2.5, 0, 0]) rotate([-45, 0, 0]) translate([0, 0, 5]) rotate([0, 45, 0]) cube([5, 11, 5], center = true);
        //back angles
        translate([2.5, 0, 0]) rotate([45, 0, 0]) translate([0, 0, 5]) rotate([0, 45, 0]) cube([5, 11, 5], center = true);
        translate([-2.5, 0, 0]) rotate([45, 0, 0]) translate([0, 0, 5]) rotate([0, 45, 0]) cube([5, 11, 5], center = true);
        
    }
    
}

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

module center_piece () {
    $fn = 60;
    difference () {
       cylinder(r = 5, h = 16.5 + 1, center = true);
       cube([.5, 20, 16.5 + 1 + 1], center = true);
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
            
module tank_inner (DEBUG = false) {
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

module bottom () {
    //spiral(START_D = 12, THICKNESS = 2, SPACING = .5, SPIRALS = 8, H = 3);
    spiral_static_res(START_D = 12, THICKNESS = 2, SPACING = .5, SPIRALS = 8, H = 3);
    translate ([0, 0, 1.55]) {
      spiral_top(START_D = 12, THICKNESS = 2, SPACING = .5, SPIRALS = 8, H = 2);
    } 
 }

module reel () {
    $fn = 100;
    translate([0, 0, -9]) for (i = [0 : 5]) {
         rotate([0, 0, i * (360 / 5)]) cube([D - 3, 3, 2], center = true);
    }
    translate([0, 0, -9]) difference () {
    	cylinder(r = (D / 2) - 1.5, h = 2, center = true);
        translate([0, 0, 0]) cylinder(r = (D / 2) - 5, h = 2 + 1, center = true);
  	}
	translate([0, 0, -5.5]) bottom();
	translate([0, 0, -1]) rotate([0, 0, 85]) center_piece(0);
}

translate([0, 0, 19]) reel();
translate([0, 0, -1.25]) tank(2);
translate([0, 0, 39]) tank_cover(2);
translate([0, 0, 25]) tank_inner();
//rotate([180, 0, 0]) funnel();