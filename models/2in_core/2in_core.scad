module core (oW, decoy = false) {
	coreH = 16;
	iW = 15.3;
	oW = oW / 2;
     $fn = 100;
    
	module cyl (R) {
		cylinder(r = R, h = coreH, center = true);
	}

	module inner_core_shape (coreR, trans, cubeW, cubeL) {
		union () {
			cyl(coreR);
			translate([trans, 0, 0]) {
				cube([cubeW, cubeL, coreH], center = true);
			}
		}
	}

	module inner_core () {
		difference () {
			inner_core_shape(iW, iW + .5, 6, 7);
			inner_core_shape(iW - 2, iW - .5, 4, 4);
		}
	}
	module clip () {
		translate([oW - 2, 0, 0]) {
			rotate(45, [0, 0, 1]){
				cube([6, 1, coreH], center = true);
			}
		}
	}

	module outer_clip () {
		translate([oW - 2, 0, 0]) {
			difference() {
				rotate(45, [0, 0, 1]){
					cube([8, 4, coreH], center = true);
				}
				translate([3.9, 0, 0]) {
					cube([6, 8, coreH], center = true);
				}
			}
		}
	}

	module outer_core () {
		difference () {
			union () {
				difference () {
					cyl(oW);
					cyl(oW - 2);
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
					translate ([iW + ((oW - iW) / 2) - 1, 0, 0]) {
						cube([oW - iW - 5.7, 2, coreH] ,center = true);
					}
				} else {
					translate ([iW + ((oW - iW) / 2) - 1, 0, 0]) {
						cube([oW - iW - 1, 2, coreH] ,center = true);
					}
				}
			}
		}
	}

	union () {
		inner_core();
		outer_core();
		supports(6);
	}	
}

core(50, true);
