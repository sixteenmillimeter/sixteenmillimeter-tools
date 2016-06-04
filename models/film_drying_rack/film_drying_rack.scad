time = 0;
IN = 25.4;

DOWEL_D = IN * (5 / 16);  //IN / 4;
echo("DOWEL_D");
echo(DOWEL_D); //5/16" = 7.9375, real = 7.6 - 8.09
//1/4" = 6.35, real = 3.2 - 3.44

THREADED_D = 12.17;//IN / 2; //1/2" = 12.7, real = 12.17
echo("THREADED_D");
echo(THREADED_D);

SPOKES = 6;
ANGLE = 360 / SPOKES;
MAX_Y = 12 * IN;
LEN = 231 + 85;
OFFSET = 10;
WIDTH = 30;
DISTANCE = (LEN / 2) - OFFSET;

DOWEL_OFFSET = (LEN / 2) - OFFSET + (IN / 8);
DOWEL_DISTANCE = (DOWEL_OFFSET * sin(ANGLE / 2)) * 2;
FEET = 34 * 1000;
RACK_D = SPOKES * DOWEL_DISTANCE;
echo("DIAMETER");
echo(RACK_D);
RACK_LEN = (FEET  / RACK_D) * 16;
echo(RACK_LEN);
echo(RACK_LEN / IN);

ROTATE = time / 2;

module rounded_cube (cube_arr = [1, 1, 1], d = 0, center = false) {
	off_x = 0;
	off_y = 0;
	r = d/2;
	union () {
		cube([cube_arr[0] - d, cube_arr[1], cube_arr[2]], center = center);
		cube([cube_arr[0], cube_arr[1] - d, cube_arr[2]], center = center);
		translate ([1 * (cube_arr[0] / 2) - r , 1 * (cube_arr[1] / 2)- r, 0]) cylinder(r = r, h = cube_arr[2], center = center);
		translate ([-1 * (cube_arr[0] / 2) + r, -1 * (cube_arr[1] / 2) + r, 0]) cylinder(r = r, h = cube_arr[2], center = center);
		translate ([1 * (cube_arr[0] / 2) - r, -1 * (cube_arr[1] / 2) + r, 0]) cylinder(r = r, h = cube_arr[2], center = center);
		translate ([-1 * (cube_arr[0] / 2) + r, 1 * (cube_arr[1] / 2)- r, 0]) cylinder(r = r, h = cube_arr[2], center = center);
	}
}

module laser_bed () {
	translate([0, 0, -.5]) cube([300, 500, 1], center = true);
}

module rack_side () {
  	for (i  = [0 : SPOKES / 2]) { 
   		rotate([0, 0, i * ANGLE]) {
      		difference () {
      			rounded_cube([LEN, WIDTH, IN / 4], d = IN / 4, center = true);
        
        		//center
        		cylinder(r = THREADED_D / 2, h = 10, center = true);
        		//ends
        		translate ([DISTANCE, 0, 0]) {
        			cylinder(r = DOWEL_D / 2, h = 10, center = true);
          		}
                translate ([-DISTANCE, 0, 0]) {
        			cylinder(r = DOWEL_D / 2, h = 10, center = true);
          		}
        	}
      }
  	}
}

module stand () {
  	difference () {
		rounded_cube([(LEN / 2) + 40, 40, IN / 4], d = DOWEL_D, center = true);
    	translate ([-(LEN / 4), 0, 0]) cylinder(r = (THREADED_D + 4) / 2, h = 275, center = true);
    }	
    
	difference () {
    	translate ([(LEN / 2) - 50, 0, 0]) rounded_cube([40, 150, IN / 4], d = DOWEL_D, center = true);
       	translate ([(LEN / 2) -50 + 10, 0, 0]) cube([20, IN / 4, 20], center = true);
    }
}

module stand_base() {
	difference () {
    	rounded_cube([40, 100, IN / 4], d = DOWEL_D, center = true);
       	translate ([-10, 0, 0]) cube([20, IN / 4, 20], center = true);
    }
}
module stand_printed_bearing () {
    $fn = 100;
    difference () {
        union () {
            cylinder(r = (THREADED_D + 4) / 2, h = IN / 4, center = true);
            translate([0, 0, -(IN / 8) - (3 / 2)]) cylinder(r = (THREADED_D + 12) / 2, h = 3, center = true);
        }
        cylinder(r = (THREADED_D + .5) / 2, h = 50, center = true);
    }
}
module drying_rack () {
  	//threaded rod
  	translate([0, 4 * IN, 0]) rotate([90, 0, 0]) cylinder(r = THREADED_D / 2, h = 36 * IN, center = true);
  	//dowels]
    rotate ([90, ROTATE, 0]) {
        for (i  = [0 : SPOKES / 2]) { 
            rotate([0, 0, i * ANGLE]) {
                translate ([DISTANCE, 0, 0]) {
                    cylinder(r = DOWEL_D / 2, h = 24 * IN, center = true);
                }
                translate ([-DISTANCE, 0, 0]) {
                    cylinder(r = DOWEL_D / 2, h = 24 * IN, center = true);
                }
            }
        }
    }
  
	translate([0, RACK_LEN / 2, 0]) rotate([90, ROTATE, 0]) rack_side();
    translate([0, -RACK_LEN / 2, 0]) rotate([90, ROTATE, 0]) rack_side();
    
    translate([0, (RACK_LEN / 2) + 20, 0]) rotate([90, 0, 0]) stand_printed_bearing();
     translate([0,- (RACK_LEN / 2) - 20, 0]) rotate([90, 0, 180]) stand_printed_bearing();
  
  	translate([0, (RACK_LEN / 2) + 20, -(LEN / 4)]) rotate([90, 90, 0]) stand();
    translate([0, (RACK_LEN / 2) +  20, -(LEN / 2) - 25]) rotate([90, 90, 90]) stand_base();
    
    translate([0, -(RACK_LEN / 2) - 20, -(LEN / 4)]) rotate([90, 90, 0]) stand();
    translate([0, -(RACK_LEN / 2) -  20, -(LEN / 2) - 25]) rotate([90, 90, 90]) stand_base();
  
}
module laser_plate () {
    translate([0, -90, 0]) projection() rotate([0, 0, ANGLE / 2]) rack_side();
    translate([15, 94, 0]) projection() rotate([0, 0, 0]) stand();
    translate([-110, 94, 0]) projection() rotate([0, 0, 0]) stand_base();
    
    //color("blue") laser_bed();
}

module printer_plate () {
    stand_printed_bearing();
    translate([30, 0, 0]) stand_printed_bearing();
}

//printer_plate();
//laser_plate();
rotate([0, 0, time]) drying_rack();
