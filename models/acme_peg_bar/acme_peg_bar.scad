$fn = 160;
time = 0;

L = 254;
W = 13;
H = 3;
CENTER_D = 6.39;
CENTER_H = 9.76;
SIDE_D = 3.24;
SIDE_L = 11.92;
SIDE_SPACE = 192; //SPACE BETWEEN INNER PARTS

//http://www.cartoonsupplies.com/content/acme-pegbar-plastic

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
    //cube([20, W, H], center = true);
    translate([0, 0, (CENTER_H / 2) - .5]) center_peg(CENTER_D, CENTER_H);
    translate([(SIDE_SPACE / 2) + (SIDE_L / 2), 0, (CENTER_H / 2) + .3 ]) side_peg(SIDE_D, SIDE_L, CENTER_H);
    translate([-(SIDE_SPACE / 2) - (SIDE_L / 2), 0, (CENTER_H / 2) + .3 ]) side_peg(SIDE_D, SIDE_L, CENTER_H);
}

module center_peg (D = 6, H = 9) {
    cylinder(r = D / 2, h = H - (D / 2), center = true);
    translate([0, 0, (H / 2) - (D / 4)]) {
        difference () {
            sphere(r = D / 2, center = true);
            translate([0, 0, -D]) cube([D*2, D*2, D*2], center = true);
        }
    }
}

module side_peg (D = 3, L = 11, H = 9) {
    rounded_bar([L, D, H - (D / 2)], fn = $fn);
    translate([0, 0, (H / 2) - (D / 4)]) {
            difference () {
                    union () {
                            rotate([0, 90, 0]) cylinder(r = D / 2, h = L - D,  center = true);
                            translate([(L / 2) - (D / 2), 0, 0]) sphere(r = D / 2, center = true);
                            translate([-(L / 2) + (D / 2), 0, 0]) sphere(r = D / 2, center = true);
                    }
                    translate([0, 0, -L]) cube([L * 2, L * 2, L * 2], center = true);
            }
    }
}

module small_printer_animation_peg_bar () {
    difference () {
        animation_peg_bar();
        translate([150 + 20, 0, 0]) cube([300, 300, 300], center = true);
        translate([20, 0, .75]) {
            difference (){
                cube([5, 13  + 1, 1.5], center = true);
                cube([5, 4, 10], center = true);
            }
        }
    }
    translate([20, 20, 0]) {
        difference () {
            animation_peg_bar();
            translate([150 - 20, 0, 0]) cube([300, 300, 300], center = true);
            translate([-20, 0, -.75]) {
                cube([5, 13  + 1, 1.5], center = true);
                cube([5, 4, 10], center = true);
            }
        }    
    }

}

module three_piece_animation_peg_bar () {
    difference () {
        animation_peg_bar();
        translate([150 + (254 / 6), 0, 0]) cube([300, 300, 300], center = true);
        translate([-150 - (254 / 6), 0, 0]) cube([300, 300, 300], center = true);
        translate([(254 / 6), 0, .75]) {
            difference (){
                cube([5, 13  + 1, 1.5], center = true);
                cube([5, 4, 10], center = true);
            }
        }
        translate([-(254 / 6), 0, .75]) {
            difference (){
                cube([5, 13  + 1, 1.5], center = true);
                cube([5, 4, 10], center = true);
            }
        }
    }
    translate([(254 / 3), 20, 0]) {
        difference () {
            animation_peg_bar();
            translate([150 - (254 / 6), 0, 0]) cube([300, 300, 300], center = true);
            translate([-(254 / 6), 0, -.75]) {
                cube([5, 13  + 1, 1.5], center = true);
                cube([5, 4, 10], center = true);
            }
        }    
    }
    translate([(254 / 3), -20, 0]) {
        difference () {
            animation_peg_bar();
            translate([150 - (254 / 6), 0, 0]) cube([300, 300, 300], center = true);
            translate([-(254 / 6), 0, -.75]) {
                cube([5, 13  + 1, 1.5], center = true);
                cube([5, 4, 10], center = true);
            }
        }    
    }

}

//small_printer_animation_peg_bar();
//three_piece_animation_peg_bar();
rotate([0, 0, time]) animation_peg_bar();
