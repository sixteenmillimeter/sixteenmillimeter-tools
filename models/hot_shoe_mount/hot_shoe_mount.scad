time = 0;

	RAIL = 10;
  	RAIL_W = 10;

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

		translate([0, 2, 0]) cube([20,14.8+4,17.5], center=true);

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
        
        translate([0, 2, -25]) rcube([RAIL/2, RAIL, 50], d = .5, center = true, $fn = 12);
        translate([0, 0, -5]) rotate([0, 90, 0]) cylinder(r = 4 / 2, h = 50, center = true, $fn = 30);
		
	}
    
}

rotate([0, 0, time]) hot_shoe_mount();