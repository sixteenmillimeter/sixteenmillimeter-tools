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

module idle_roller (DEBUG = false) {
    $fn = 100;
    H = 21;
    IDLE_PLAY_SLOT = 8.1;
    
    //echo("ROLLER_CLEARANCE");
    //echo(H - 4);
    //translate([0, 0, 9]) cube([16, 16, 20], center = true);
    difference () {
        union () {
            cylinder(r = 20 / 2, h = 2, center = true);
            translate([0, 0, 1]) cylinder(r = 16 / 2, h = 4, center = true);
            translate([0, 0, 10]) cylinder(r = 14 / 2, h = 18, center = true);
            translate([0, 0, H - 3.5]) cylinder(r = 16 / 2, h = 4, center = true);
            translate([0, 0, H - 2]) cylinder(r = 20 / 2, h = 2, center = true);
        }
        //cylinder(r = (IDLE_PLAY_SLOT / 2) + .1, h = 50, center = true);
        if (DEBUG){
            translate([50, 0, 0]) cube([100, 100, 100], center = true);
        }
    }
}

module steenbeck_notch_detector () {
    difference () {
        union () {
            translate([0, 0, 1.5]) rotate([90, 0, 90]) rounded_cube([40, 43, 18], d = 8, center = true, $fn = 60);
            translate([0, 0, 1.5 - 12.5]) rotate([90, 0, 90]) cube([40, 43, 18], center = true, $fn = 60);
            translate([0, 0, -20 + 3 -  (28.75 - 16)]) cube([6, 40, 6],  center = true, $fn = 60);
        }
        translate([0, 0, -20 + 8.99]) {
            difference() {
                cube([10, 50 + 1, 25.01], center = true);
            }
        }
        //key void
        translate([0, 0, -20 + 3 -  (28.75 - 16)]) cube([60, 6, 6],  center = true, $fn = 60);
        //inner void
        translate([0, 0, -25]) cube([8, 50 + 1, 18], center = true);
        //remove half
         translate([25 , 0, 0]) cube([50, 50, 70], center = true);
        //void for microswitch
        translate([0, 0, 21]) cube([10, 40 + 1, 40], center = true);
        //remove sides
        translate([-12.5, 0, 22]) cube([10, 40 + 1, 40], center = true);
        translate([12.5, 0, 22]) cube([10, 40 + 1, 40], center = true);
        //void for arm
        translate([0, -10.01, -2]) cube([5, 20, 10], center = true);

        //void for bolts that mount microswitch
        translate([0, 22.5 / 2, 14 - 5]) {
            rotate([90, 0, 90]) cylinder(r = 3.25 / 2, h = 40, center = true, $fn = 50);
            translate([0, 0, -3.25 / 2]) cube([40, 3.25, 4], center = true);
            translate([0, 0, -4]) rotate([90, 0, 90]) cylinder(r = 3.25 / 2, h = 40, center = true, $fn = 50);

        }
        //
        translate([0, -22.5 / 2, 14 + 5]) {
            rotate([90, 0, 90]) cylinder(r = 3.25 / 2, h = 40, center = true, $fn = 50);
            translate([0, 0, -3.25 / 2]) cube([40, 3.25, 4], center = true);
            translate([0, 0, -4]) rotate([90, 0, 90]) cylinder(r = 3.25 / 2, h = 40, center = true, $fn = 50);
        }
    }
    //modified idle roller
    translate([-8, 14.5, -22]) difference() {
        idle_roller();
        translate([-25, -25, 0]) cube([50, 50, 50], center = true);
    }
    difference () {
        translate([-15, 0, -17]) union () {
            cylinder(r = 4, h = 19.5, center = true, $fn = 40);
            translate([5, 0, 0]) cube([10, 8, 19.5], center = true);
        }
    //void for bolt
        translate([-15, 0, -19.9]) cylinder(r = 2.35, h = 26, center = true, $fn = 40);
    }
}

module notch_cup () {
    difference() {
        translate([0, 0.5, 0]) cube([7, 13, 3], center = true);
        //arm void
        cube([4.75, 15, .8], center = true);
    }
    translate([0, -3, -1.5]) {
        intersection () {
            cube([7, 6, 6], center = true);
            translate([0, 0, .5]) rotate([0, 90, 0]) cylinder(r = 3, h = 10, center = true, $fn = 80);
        }
    }
    translate([2, -3, -1.5]) rotate([0, 90, 0]) {
        difference () {
            cylinder(r = 4.5, h = 3, center = true, $fn = 100);
            translate([-5, 0, 0]) cube([8, 8, 8], center = true);
            translate([0, -7, 0]) cube([8, 8, 8], center = true);
            translate([0, 7, 0]) cube([8, 8, 8], center = true);
            translate([0, 0, -2]) rotate([0, -5, 0]) cube([12, 12, 2], center = true);
        }
    }
    translate([-2, -3, -1.5]) rotate([0, 90, 0]) {
        difference () {
            cylinder(r = 4.5, h = 3, center = true, $fn = 100);
            translate([-5, 0, 0]) cube([8, 8, 8], center = true);
            translate([0, -7, 0]) cube([8, 8, 8], center = true);
            translate([0, 7, 0]) cube([8, 8, 8], center = true);
            translate([0, 0, 2]) rotate([0, 5, 0]) cube([12, 12, 2], center = true);
        }
    }
}

module steenbeck_notch_detector_base() {
    difference () {
        rounded_cube([80, 50, 6], d = 8, center = true);
        translate([10, 0, 58]) scale([1.05, 1.05, 2]) steenbeck_notch_detector();
        translate([-5, 0, -3.01]) {
            hex(r = 9/2, h = 3);
            cylinder(r = 5.25 / 2, h = 20, center = true, $fn = 40);
        }
    }
}

module steenbeck_notch_detector_base_dxf () {
        projection(cut = true) translate([0, 0, -1.5])   steenbeck_notch_detector_base();
    projection(cut = true) translate([0, 60, 1.5])   steenbeck_notch_detector_base();
}

//not for printing
//rotate([0, -90, 0]) film_16mm();
//microswitch([0, 0, 25], [0, 90, 180]);

//translate([0, 0, 20 - 8]) color("blue") steenbeck_notch_detector();
//translate([-10, 0, -17.5]) steenbeck_notch_detector_base();
//notch_cup();

//laser cutting
steenbeck_notch_detector_base_dxf();