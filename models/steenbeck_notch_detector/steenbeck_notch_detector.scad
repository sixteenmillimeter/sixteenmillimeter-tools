IN = 25.4;

module hex (r = 1, h = 1, center = false) {
	cylinder(r = r, h = h, center = center, $fn = 6);
}

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

module microswitch (position = [0, 0, 0], rotation = [0, 0, 0]) {
	translate(position) {
		rotate(rotation) {
            difference () {
                rounded_cube([16, 28, 9.5], d = 4, center = true, $fn = 40);
                //bolt voids
                translate([-5, 22.5 / 2, 0]) cylinder(r = 3/ 2, h = 10, center = true, $fn = 50);
                translate([5, -22.5 / 2, 0]) cylinder(r = 3/ 2, h = 10, center = true, $fn = 50);
            }
            
			translate([10, 8, 0]) rotate([0, 0, -7]) cube([1, 28, 4], center = true);
			translate([8 + 7, 14 + 8, 0]) cylinder(r = 2.5, h = 4, center = true);
			translate([0, -19, 0]) cube([6, 11, 9.5], center = true);
            
            //bolts
                translate([-5, 22.5 / 2, 0]) cylinder(r = 3/ 2, h = 40, center = true, $fn = 50);
                translate([5, -22.5 / 2, 0]) cylinder(r = 3/ 2, h = 40, center = true, $fn = 50);
		}
	}
}

module perf () {
    W = 0.072 * IN;
    L = 0.05 * IN;
    translate([(10.26 / 2) + (W / 2), 0, 0]) rounded_cube([W, L, 10], d = 0.2, center = true);
}

module frame () {
   W = 10.26;
   L = 7.49;
   cube([W, L, 10], center = true);
}

module film_16mm (LEN = 100) {
    C = ((12 * IN) / 40);
    THICK = 0.0047 * IN;
    FRAMES = ceil(100 / C);
    echo(FRAMES);
    difference () {
        cube([16, LEN, THICK], center = true);
        for (i = [0 : FRAMES]) {
            translate([0, (C * i) - (LEN / 2), 0]) frame();
            translate([0, (C * i) - (LEN / 2) + (C / 2)]) perf();
        }
    }
}

module steenbeck_notch_detector () {
    difference () {
        union () {
            cube([18, 40, 40], center = true);
            translate([0, 0, -20 + 3]) rounded_cube([40, 40, 6], d = 6, center = true, $fn = 60);
        }
        translate([0, 0, -20 + 8.99]) {
            difference() {
                cube([8, 50 + 1, 18], center = true);
                //angled top
                translate([4, 0, 9]) rotate([0, 45, 0]) cube([6, 40 + 1, 6], center = true);
                translate([-4, 0, 9]) rotate([0, 45, 0]) cube([6, 40 + 1, 6], center = true);
            }
        }
        //void for microswitch
        translate([0, 0, 11]) cube([9.75, 40 + 1, 20], center = true);
        //void for arm
        translate([0, -10.01, -2]) cube([5, 20, 10], center = true);
    }
}

rotate([0, -90, 0]) film_16mm();
microswitch([0, 0, 25], [0, 90, 180]);
translate([0, 0, 20 - 8]) color("blue") steenbeck_notch_detector();