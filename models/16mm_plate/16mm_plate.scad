time=0;

//https://commons.wikimedia.org/wiki/File:16mm_and_super16.png
FRAME_H = 7.49;
FRAME_W = 10.26;
FRAME_OUTER = 16 - FRAME_W;
module 16mm_plate () {
    difference () {
        cube([20, 40, 2], center = true);
        //translate([10.3, 0, 1.3]) rotate([0, 30, 0]) cube([8, 200, 4], center = true);
        //image void
        translate([-((20 - FRAME_W) / 2) + (FRAME_OUTER / 2), 0, 0]) cube([FRAME_W, FRAME_H, 2 + 1], center = true);
        //sound void
        translate([-((20 - 16) / 2) + (16 / 2) - (FRAME_OUTER / 4), 7.57, 0]) cube([(16 - FRAME_W) / 2, FRAME_H, 2 + 1], center = true);
    }
	translate([-8, -19, 1.3]) {
		for (i = [0 : 5]) {
			registration_pin(0, i * 7.57);
		}
	}
}

module registration_pin(x, y) {
	z = 3;
	w = 1.27 - .3;
	h = 1.9812 - .3;
	translate([x, y, 0]) {
        difference () {
            cube([h, w, z], center = true);
            translate([0, w/1.6, z - (w * 1.5)]) rotate([45, 0, 0]) cube([h, w, w], center = true);
            translate([0, -w/1.6, z - (w * 1.5)]) rotate([-45, 0, 0]) cube([h, w, w], center = true);
        }
    }
}

rotate([0, 0, time]) 16mm_plate();