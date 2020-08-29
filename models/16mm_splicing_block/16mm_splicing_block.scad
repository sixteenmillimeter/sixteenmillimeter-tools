IN=25.4;
FRAME_H = 7.49;
FRAME_W = 10.26;
FRAME_OUTER = 16 - FRAME_W;

PERF_OFFSET = (1.829 / 2) + .85;
SPACING_LONG = 7.62;

module 16mm_plate () {

    /*difference () {
        cube([20, 40, 2], center = true);
        //translate([10.3, 0, 1.3]) rotate([0, 30, 0]) cube([8, 200, 4], center = true);
        //image void
        translate([-((20 - FRAME_W) / 2) + (FRAME_OUTER / 2), 0, 0]) cube([FRAME_W, FRAME_H, 2 + 1], center = true);
        //sound void
        translate([-((20 - 16) / 2) + (16 / 2) - (FRAME_OUTER / 4), 7.57, 0]) cube([(16 - FRAME_W) / 2, FRAME_H, 2 + 1], center = true);
    }*/
	translate([0, 0, 1.3 - .5]) {
		for (i = [-5 : 5]) {
            if (abs(i % 2) == 1) {
                registration_pin(8 - PERF_OFFSET, i * SPACING_LONG);
            }
		}
	}
}

module rounded_cube (cube_arr = [1, 1, 1], d = 0, center = false) {
    $fn = 20;
  
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

module registration_pin(x, y) {
    
	z = 2.5;
	w = 1.27 - .4;
	h = 1.9812 - .4;
	translate([x, y, 0]) {
        difference () {
            rounded_cube([h, w, z], d = .5, center = true);
            translate([0, w/1.6, z - (w * 1.5)]) rotate([45, 0, 0]) cube([h + 1, w, w], center = true);
            translate([0, -w/1.6, z - (w * 1.5)]) rotate([-45, 0, 0]) cube([h + 1, w, w], center = true);
        }
    }
}

X = 38;
Y = 100;
Z = 6;

translate([0, 0, 2]) 16mm_plate();
difference() {
	cube([X, Y, (1/4)*IN], center = true);
    translate([0, 0, (1/5)*IN]) cube([16.25, Y + 1, (1/4)*IN], center = true);
    translate([0, SPACING_LONG * 2, (1/8)*IN]) {
        cube([(2 * IN) + 1, .4, (1/4)*IN], center = true);
    }
    translate([X / 2, SPACING_LONG * 2, (Z / 2) + .2 ]) {
        rotate([45, 0, 0]) cube([(2 * IN) + 1, 1, 1], center = true);
    }
    translate([0, 0, (1/8)*IN]) rotate([0, 0, 16]) {
        cube([X * 2, .4, (1/4)*IN], center = true);
    }
    translate([0, 0, (Z / 2) + .2]) rotate([0, 0, 16]) {
        translate([X, 0, 0]) rotate([45, 0, 0]) cube([X * 2, 1, 1], center = true);
    }
}
