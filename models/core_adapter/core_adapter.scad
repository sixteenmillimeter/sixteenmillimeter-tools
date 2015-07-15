module core_adapter () {
    $fn = 100;
	difference () {
		union () {
			cylinder(r1 = 13.2, r2 = 12.8, h = 16.6, center = true);
			translate([0, 0, -8.8]) cylinder(r = 15, h = 1, center = true);
			translate([14.5, 0, -.5]) cube([3.6, 3.6, 17.6], center = true);
		}
		cube([8.3, 8.3, 21.5], center = true);
	}
}

core_adapter();
