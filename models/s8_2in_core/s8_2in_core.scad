time=0;

module core (outerWidth) {
	coreH = 8;
	innerWidth = 15.3;
	outerWidth = outerWidth / 2;
    $fn = 100;
    
	module cyl (R, pad = 0) {
		cylinder(r = R, h = coreH + pad, center = true);
	}

	module inner_core_shape (coreR, trans, cubeW, cubeL, pad = 0) {
		union () {
			cyl(coreR, pad);
			translate([trans, 0, 0]) {
				cube([cubeW, cubeL, coreH + pad], center = true);
			}
		}
	}

	module inner_core () {
		difference () {
			inner_core_shape(innerWidth, innerWidth + .5, 6, 7);
			inner_core_shape(innerWidth - 2, innerWidth - .5, 4, 4, 2);
		}
	}
	module clip () {
		translate([outerWidth - 2, 0, 0]) {
			rotate(45, [0, 0, 1]){
				cube([6, 1, coreH], center = true);
			}
		}
	}

	module outer_clip () {
		translate([outerWidth - 2, 0, 0]) {
			difference() {
				rotate(45, [0, 0, 1]){
					cube([8, 4, coreH], center = true);
				}
				translate([3.9, 0, 0]) {
					cube([6, 8, coreH + 1], center = true);
				}
			}
		}
	}

	module outer_core () {
		difference () {
			union () {
				difference () {
					cyl(outerWidth);
					cyl(outerWidth - 2, 1);
				}
				outer_clip();
			}
			clip();
		}
	}

	module supports (x) {
		for (i = [0 : x]) {
			rotate ([0, 0, i * 360 / (x + 1)]) {
				if (i == 0) {
					translate ([innerWidth + ((outerWidth - innerWidth) / 2) - 1, 0, 0]) {
						cube([outerWidth - innerWidth - 5.7, 2, coreH] ,center = true);
					}
				} else {
					translate ([innerWidth + ((outerWidth - innerWidth) / 2) - 1, 0, 0]) {
						cube([outerWidth - innerWidth - 1, 2, coreH] ,center = true);
					}
				}
			}
		}
	}

	union () {
		inner_core();
		outer_core();
		supports(6);
		difference () {
			cylinder(r = outerWidth - 1.1, h = 2, center = true);
			inner_core_shape(innerWidth - 2, innerWidth - .5, 4, 4, 2);
			outer_clip();
		}
	}	
}

rotate([0,0, time]) core(50);