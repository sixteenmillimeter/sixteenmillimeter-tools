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

module bolex_matte_box_insert () {
	X = 35;
    Y = 35; 
    FRAME = 10;
  	difference () {
        union() {
          translate([0, FRAME/4- 2, 5/2]) {
              cube([X - .2, Y + FRAME-2, 2.9], center = true);
          }
          translate([0, FRAME/4- 2, 1]) {
              cube([X + 2 - .2, Y + FRAME -2, 1.9], center = true);
          }
        }
    	
    	rcube([X - 4, Y + 1, 16], d = 3, center = true, $fn = 20);
    	//translate([0, 0, 3.5]) rcube([X - 1, Y + 4, 3], d = 2, center = true, $fn = 20); 
    }
  translate([0, 23, 2]) rcube([4, 9, 3.9], d = 2, center= true, $fn=24);
}

rotate([0, 90, time]) bolex_matte_box_insert();