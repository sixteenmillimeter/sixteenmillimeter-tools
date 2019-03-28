include <../../libraries/Minolta16.scad>;

time=0;

module minolta16_cart_takeup () {
        H = 15.95;
        D = 15.5;
        INNER_D = 14;
        difference() {
            cylinder(r = D / 2, h = H, center = true);
            translate([0, 0, .65]) cylinder(r = INNER_D / 2, h = H, center = true);
			translate([-3, 7, .65]) rotate([0, 0, 60]) cube([10, .5, H], center = true);
        }
        translate([0, 0, -(D / 2) + 1.5]) cylinder(r = 2, h = 3, center = true);
        for (i = [0:3]) {
            rotate([0, 0, i * 90]) translate([(D / 4) - .75, 1.25, -(D / 2) + 1.5]) cube([(D / 2) + 1, 1, 3], center = true);
        }
		
}

module minolta16_cart_takeup_cap () {
  INNER_D = TAKEUP_D - WALL_THICKNESS;
  difference () {
    union () {
        cylinder(r = TAKEUP_D / 2, h = 1, center = true);
        translate([TAKEUP_D / 4, TAKEUP_D / 4, 0]) {
            cube([TAKEUP_D / 2, TAKEUP_D / 2, 1], center = true);
        }
        translate([0, 0, -1.5]) cylinder(r = (13.87 / 2) + .2, h = 3, center = true);
    }
    translate([0, 0, .65]) cylinder(r = (13.87 / 2) - .5, h = 100, center = true);
  }
  translate([(TAKEUP_D / 2) - 1, 7.5, -1]) cube([1.8, 1.8, 1.8], center = true);
}

rotate([0, 0, time]) minolta16_cart_takeup();