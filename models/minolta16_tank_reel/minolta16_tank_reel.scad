time = 0;
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

module center_piece () {
    $fn = 60;
    difference () {
       cylinder(r = 5, h = 16.5 + 1, center = true);
       cube([.5, 20, 16.5 + 1 + 1], center = true);
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

rotate([0, 0, time]) reel();