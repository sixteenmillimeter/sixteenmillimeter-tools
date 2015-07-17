$fn = 80;
time = 0;

module reel_mount () {
	$fn = 60;
	difference(){
		translate([0, 0, -1.5]) cube([7.5, 7.5, 21.5], center= true);
		for (i = [0:4]) {
			rotate([0, 0, (i * 90)]){
				translate([(7.5 / 2) + .4, (7.5 / 2) + .4, 18.5 / 2]) rotate([0, -15, 45]) cube([2.5, 7.5, 7.5], center = true);
			}
		}		
	}
	difference () {
		union() {
			translate([0, 0, (18.5 / 2) + (3.5 / 2)]) cylinder(r = 7.5 / 2, h = 3.5, center = true);
			translate([0, 0, (18.5 / 2) + (7.5 / 2)]) sphere(7.5 / 2, center = true);
		}
		translate ([0, 0, (18.5 / 2) + 7.5]) cube([10, 10, 2], center = true);
	}

	translate([0, 0, -(18.5/ 2) - (3 / 2) - 3]) cylinder(r = 16 /2, h = 3, center = true);
}

module s8_center () {
	height = 50; //doesnt matter
	fin_w = 2;
	center_d = 13.5;
	fin_l = (center_d / 2) + 4;
	for (i = [0:2]) {
		rotate([0, 0, (i * (360/3))]){
			translate([0, fin_l/2, 0]) cube([fin_w, fin_l, height], center = true);
		}
	}
	cylinder(r = center_d/2, h = height, center = true);
}

module core_adapter () {
	difference () {
		union () {
			cylinder(r1 = 13.2, r2 = 12.9, h = 16.6, center = true);
			translate([0, 0, -8.8]) cylinder(r = 15, h = 1, center = true);
			translate([14.5, 0, -.5]) cube([3.6, 3.6, 17.6], center = true);
		}
		s8_center();
	}
}

rotate([0, 0, time]) core_adapter();