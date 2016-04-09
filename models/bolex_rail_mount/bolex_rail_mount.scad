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

module hot_shoe_mount() {
  difference() {
    cube([20,14.8,17.5], center=true);

    translate([0,-7.6,0]) {
      cube([9.4,2.5,17.6], center=true);
    }
  
    translate([-8.125,-0.60,0]) {
      cube([3.99,10,17.6], center=true);
    }
  
    translate([-9.65,-6.5,0]) {
      cube([1,2,17.9], center=true);
    }
  
  
    translate([8.125,-0.60,0]) {
      cube([3.99,10,17.6], center=true);
    }
  
    translate([9.65,-6.5,0]) {
      cube([1,2,17.9], center=true);
    }
    translate([0, -4, 6]) cube([6, 6, 6], center=true);
    
  }
}

module bolex_matte_box_rail () {
	RAIL = 10;
  	difference () {
  		union() {
			rotate([90, 0, 90]) hot_shoe_mount();
  			translate([0, -3, 7]) rotate([0, 90, 0]) rcube([RAIL+5, 28, 17.5], d = 3, center = true, $fn = 12);
  		}
  		translate([-75, -8, 7]) {
    		rotate([0, 90, 0]) {
      			rcube([RAIL, RAIL/2, 160], d = .5, center = true, $fn = 12);
        	}
      	}
    }
}

rotate([0, 0, time]) bolex_matte_box_rail();