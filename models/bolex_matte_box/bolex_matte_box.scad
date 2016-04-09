time = 0;

module rcube (cube_arr = [1, 1, 1], d = 0, center = true, $fn = $fn) {
  r = d/2;
  union () {
    cube([cube_arr[0] - d, cube_arr[1], cube_arr[2]], center = center);
    cube([cube_arr[0], cube_arr[1] - d, cube_arr[2]], center = center);
    translate ([1 * (cube_arr[0] / 2) - r , 1 * (cube_arr[1] / 2)- r, 0]) {
          cylinder(r = r, h = cube_arr[2], center = center);
        }
    translate ([-1 * (cube_arr[0] / 2) + r, -1 * (cube_arr[1] / 2) + r, 0]) {
          cylinder(r = r, h = cube_arr[2], center = center);
        }
    translate ([1 * (cube_arr[0] / 2) - r, -1 * (cube_arr[1] / 2) + r, 0]) {
          cylinder(r = r, h = cube_arr[2], center = center);
        }
    translate ([-1 * (cube_arr[0] / 2) + r, 1 * (cube_arr[1] / 2)- r, 0]) {
          cylinder(r = r, h = cube_arr[2], center = center);
        }
    }
}

module bolex_matte_box () {
  	X = 35;
  	Y = 35;
  	FRAME = 10;
  
	  TAB_X = 10;
  	TAB_Z = 6;
  	TAB_Y = 49;
  
  	RAIL = 10;
  
  	difference () {
    	translate([0, 0, 5/2]) {
			rcube([X + FRAME, Y + FRAME, 8], d = 6, center = true, $fn = 64);
      	}
  		rcube([X, Y, 40], d = 2,  center = true, $fn = 20); //center
    	translate([0, FRAME/2, 5/2]) {
    		cube([X, Y + FRAME + 1, 3], center = true);
      	}
       	translate([0, FRAME/2, 1]) {
    		cube([X + 2, Y + FRAME + 1, 2], center = true);
      	}
    }

  	translate([(-Y / 2) - TAB_Y - 7, 0, 3.5]) {
    	difference () {
            rcube([RAIL + 7, RAIL + 7, 10], d = 1.5, center = true, $fn = 24);
    		rcube([RAIL, RAIL/2, 15], d = .5, center = true, $fn = 12);
      
    	rotate([0, 90, 0]) translate([0, 0, -7]) cylinder(r = 1, h = 10, center = true, $fn = 12);
      	} 
    }
  
    rotate ([0, 0, 90]) {
  		translate([0, (TAB_Y / 2) + (X / 2) + 1, 1.5]) cube([TAB_X, TAB_Y, TAB_Z], center = true);
    } 
}

module bolex_matte_box_full () {
  bolex_matte_box();
  difference () {
  	translate([0, 0, 6]) rotate([0, 0, 45]) cylinder(r1= 30, r2 = 40, h = 20, $fn = 4);
    translate([0, 0, 5.9]) rotate([0, 0, 45]) cylinder(r1= 25, r2 = 35, h = 20.2, $fn = 4);
  	//smooth edges
    translate([0, 30, 30]) rotate([45, 0, 0])cube([70, 10, 10], center = true);
    translate([0, -30, 30]) rotate([45, 0, 0])cube([70, 10, 10], center = true);
  	translate([30, 0, 30]) rotate([0, 45, 0])cube([10, 70, 10], center = true);
    translate([-30, 0, 30]) rotate([0, 45, 0])cube([10, 70, 10], center = true);
  
  }
}

module bolex_matte_box_front () {
	RAIL = 10;
  	RAIL_W = 10;
  
  	FRAME = 15;
  
  	TAB_X = 10;
  	TAB_Y = 39;
    TAB_Z = 4;
    O_Y = 40;
  
  	X = 55;
  	Y = 60;
  
    translate([0, 0, 1.5]) {
      difference () {
    	rcube([X + FRAME, Y + FRAME, TAB_Z], d = 6, center = true, $fn = 24);
  		rcube([X, Y, TAB_Z], d = 2,  center = true, $fn = 12);
      }
  	}
}

module bolex_matte_box_front_top () {
	RAIL = 10.6;
  	RAIL_W = 10;
  
  	FRAME = 15;
  
  	TAB_X = 10;
  	TAB_Y = 30;
    TAB_Z = 4;
    O_Y = 40;
  
  	X = 55;
  	Y = 60;
  
  	translate([-73.5, 0, 4.5]) {
      difference () {
          rcube([RAIL+7, RAIL+7, RAIL_W], d = 1.5, center = true, $fn = 24);
          rcube([RAIL, RAIL/2, RAIL_W], d = .5, center = true, $fn = 12);
    	  rotate([0, 90, 0]) translate([0, 0, -7]) cylinder(r = 1, h = 10, center = true, $fn = 12);  
      }
  	}
  
    rotate ([0, 0, 90]) {
  		translate([0, (TAB_Y / 2) + (X / 2) + 7.5, 1.5]) cube([TAB_X, TAB_Y, TAB_Z], center = true);
    } 
  	
    rotate ([0, 0, 90]) {
    	difference () {
  			translate([0, (TAB_Y / 2) + (X / 2) - 2.5, 2.5]) cube([TAB_X * 3, 10, TAB_Z+2], center = true);
      		translate([-10, 48, 2.5]) rotate([0, 0, 30])  cube([TAB_X * 3, 10, TAB_Z+2], center = true);
      		translate([10, 48, 2.5]) rotate([0, 0, -30])  cube([TAB_X * 3, 10, TAB_Z+2], center = true);
      	}
    	translate([0, (TAB_Y / 2) + (X / 2) - 7.5, 4.5]) cube([TAB_X * 3, 5, 2], center = true);
    }  	
}

rotate([0, 90, time]) bolex_matte_box_full();
