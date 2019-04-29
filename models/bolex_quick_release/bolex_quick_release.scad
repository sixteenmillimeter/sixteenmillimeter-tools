
$fn = 30;
plate_center = [-1.35, -3.5, 5.5];
time=0;

module base_plate (holes_on = true) {
	difference () {
		translate(plate_center) cube([50, 90, 11], center = true);
		sides_flat();
		sides_angled();
		divot();
		front_top_angled();
		front_top_flat();
		if (holes_on) {
			holes();
		} else {
			//translate([0, (71.5 / 2) - 34, 0]) cylinder(r = 6.5 / 2, h = 100, center = true);
		}
		
	}
}

module sides_flat () {
	x = 26.2;
	z = -7.3;
	side = [10, 100, 11];
	translate(plate_center) {
		union () {
			translate([x, 0, z]) cube(side, center = true);
			translate([-x, 0, z]) cube(side, center = true);
		}
	}
}

module sides_angled() {
	x = 28.4;
	z = .9;
	angle = 29;
	side = [10, 100, 12];
	translate(plate_center) {
		union () {
			translate([x, 0, z]) rotate([0, angle, 0]) cube(side, center = true);
			translate([-x, 0, z]) rotate([0, -angle, 0]) cube(side, center = true);
		}
	}
}

module divot() {
	z = 6.6;
	deep = 10;
	back = [40.5, 39, deep];
	slider = [4.8, 10, deep];
	cent = [31, 10, deep];
	left_angle = [70, 20, deep];
	right_straight = [20, 50, deep];
	right_angle = [15, 15, deep];
	translate(plate_center) {
		union () {
			translate([-1, -22.5, z]) cube(back, center = true);
			translate([16.9, -22 - (39 / 2), z]) cube(slider, center = true);
			translate([3.75, -2.1, z]) cube(cent, center = true);
			translate([8.3, 35, z]) rotate([00, 0, 83]) cube(left_angle, center = true);
			translate([-8.8, 35.9, z]) cube(right_straight, center = true);
			translate([-8.3, 10.4, z]) rotate([00, 0, 42]) cube(right_angle, center = true);
		}
	}
}

module front_top_angled () {
	x = 26.8;
	y = 41;
	z = 1.5;
	angle_y = 17;
	angle_z = 18;
	angle_x = 4;
	side = [10, 15, 11];
	translate(plate_center) {
		union () {
			translate([x, y, z]) rotate([angle_x, angle_y, angle_z]) cube(side, center = true);
			translate([-x, y, z]) rotate([angle_x, -angle_y, -angle_z]) cube(side, center = true);
		}
	}
}

module front_top_flat () {
	x = 25.3;
	y = 42;
	z = -7.3;
	sides = [10, 10, 11];
	angle_z = 19;
	translate(plate_center) {
		union () {
			translate([x, y, z]) rotate([0, 0, angle_z]) cube(sides, center = true);
			translate([-x, y, z]) rotate([0, 0, -angle_z]) cube(sides, center = true);
		}
	}
}

module holes () {
	translate([-1.5, -5, 0]){
		//base reference
		// cube([50, 71.5, 40], center = true);
		//holes
		translate([0, (71.5 / 2) - 12, 0]) cylinder(r = 10 / 2, h = 100, center = true);
		translate([0, (71.5 / 2) - 34, 0]) cylinder(r = 6.5 / 2, h = 100, center = true);
		translate([(-50 / 2) + 18, (71.5 / 2) - 62, 0]) cylinder(r = 10 / 2, h = 100, center = true);
	}

}

rotate([0, 0, time]) base_plate(holes_on= true);