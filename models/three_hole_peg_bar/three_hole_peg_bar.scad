$fn = 60;
time = 0;

L = 254;
W = 13;
H = 3;
CENTER_D = 6.39;
CENTER_H = 9.76;

SIDE_D = 3.24;
SIDE_L = 11.92;
SIDE_SPACE = 108 * 2; 

module rounded_bar (arr = [50, 10, 10], fn = 60) {
	$fn = fn;
	cube([arr[0] - arr[1], arr[1], arr[2]], center = true);
	translate ([(arr[0] / 2) - (arr[1] / 2), 0, 0]) {
		cylinder(r = arr[1] / 2, h = arr[2], center = true);
	}
	translate ([-(arr[0] / 2) + (arr[1] / 2), 0, 0]) {
		cylinder(r = arr[1] / 2, h = arr[2], center = true);
	}
}

module animation_peg_bar () {
    rounded_bar([L, W, H], $fn);
    translate([0, 0, (CENTER_H / 2) - .5]) round_peg(CENTER_D, CENTER_H);
    translate([(SIDE_SPACE / 2), 0, (CENTER_H / 2) ]) round_peg(CENTER_D, CENTER_H);
    translate([-(SIDE_SPACE / 2), 0, (CENTER_H / 2) ]) round_peg(CENTER_D, CENTER_H);
}

module round_peg (D = 6, H = 9) {
    union () {
        cylinder(r = D / 2, h = H - (D / 2), center = true);
        translate([0, 0, (H / 2) - (D / 4)]) {
            difference () {
                sphere(r = D / 2);
                translate([0, 0, -D]) cube([D*2, D*2, D*2], center = true);
            }
        }
    }
}

module center_part () {
    difference () {
        intersection () {
            animation_peg_bar(); 
            cube([L / 3, 30, 30], center = true); 
        }
        translate([L / 6, 9, 13 / 2]) cube([13, 13, 13], center = true);
        translate([L / 6, -9, -13 / 2]) cube([13, 13, 13], center = true);
        translate([-L / 6, -9, 13 / 2]) cube([13, 13, 13], center = true);
        translate([-L / 6, 9, -13 / 2]) cube([13, 13, 13], center = true);
    }
}

module three_parts () {
    translate([L / 3.2, 0, 0]) difference () {
        animation_peg_bar();
        center_part();
        translate([L / 2, 0, 0]) cube([L, 30, 30], center = true);
    }
    translate([-L / 3.2, W + 3, 0]) difference () {
        animation_peg_bar();
        center_part();
        translate([-L / 2, 0, 0]) cube([L, 30, 30], center = true);
    }
    translate([0, (W + 3) * 2, 0]) center_part();
}

//three_parts();

rotate([0, 0, time]) animation_peg_bar();