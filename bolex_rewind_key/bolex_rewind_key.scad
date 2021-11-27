$fn = 90;
//NOT RECOMMENDED FOR PLA OR ABS

module key () {
	difference () {
		cylinder(r = 6.7 / 2, h = 5, center = true);
		cylinder(r = 4.76 / 2, h = 5, center = true);
	}
	translate ([0, 0, -7.5]) {
		cylinder(r = 6.7 / 2, h = 10, center = true);
	}
}

module keyHole () {
	translate ([0, 0, 1.75]) {
		cube([10, 2, 1.5], center = true);
	}
}

module body () {
	translate([0, 0, -13.5]){
		cylinder(r = 5, h = 2, center = true);
	}
	translate([0, 0, -16]) {
		cylinder(r = 5, h = 3, center = true);
		translate([20, 0, 0]) {
			cylinder(r = 5, h = 3, center = true);
		}
		translate([10, 0, 0]){
			cube([20, 10, 3],center = true);	
		}
	}
}

module pinHole () {
    pin_d = 5.34;
	translate([20, 0, -16.5]) {
		cylinder(r = pin_d / 2, h = 4, center = true);
	}
}

module pin () {
      base_d = 8;
      base_h = 1;
      pin_d = 5.34 - 0.015;
      pin_h = 17.3;
      notch = 3;
      cylinder(r = base_d / 2, h = base_h, center = true); //base
      difference () {
        translate([0, 0, (pin_h/2) + (base_h/2)]) cylinder(r = pin_d / 2, h = pin_h, center = true);    //pin
        translate([0, 0, pin_h - (notch/2) + (base_h/2)]) cube([notch, notch, notch], center =true);
      }
      
}

module pinTop () {
      base_d = 8;
      base_h = 2;
      notch = 3 - 0.02;
      
      cylinder(r = base_d / 2, h = base_h, center = true); //base
      translate([0, 0, (notch / 2) + (base_h / 2)]) cube([notch, notch, notch], center = true);
}

module handle () {
    pin_d = 5.34 +.3;
    handle_d = 10.5;
    difference () {
        cylinder(r = handle_d/2, h = 13.75, center = true);
        cylinder(r = pin_d/2, h = 15, center = true);
    }
}

module pin_handle_plate (DECOYS = false) {
    translate([20, 0, -18]) pin();
    translate([10, 6, -17.5]) pinTop();
    translate([20, 13, -11.625]) handle();
        //decoys
    if (DECOYS) {
        translate([34, 7,-16.5]) cube([4, 4, 4], center = true);
        translate([-2, 7,-16.5]) cube([4, 4, 4], center = true);
        translate([19, 25, -16.5]) cube([4, 4, 4], center = true);
        translate([19,-14,-16.5]) cube([4, 4, 4], center = true);
    }
}

module helper () {
	translate([0, 15, -7.5]) {
		cylinder(r = 6, h = 20, center = true);
	}
}

module bolex_rewind_key ( DECOYS = false) {
    difference () {
        body();
        //pinHole();
    }
    translate([20, 0, -24.5 - 8.5]) cylinder(r = 5.2 / 2, h = 18);
    translate([20, 0, -24.5 - 8.5]) cylinder(r = 8 / 2, h = 1.5);

    difference () {
        key();
        keyHole();
    }
    //decoys
    if (DECOYS) {
        translate([32,0,-15.5]) cube([4, 4, 4], center = true);
        translate([-18,0,-15.5]) cube([4, 4, 4], center = true);
        translate([0,15,-15.5]) cube([4, 4, 4], center = true);
        translate([0,-15,-15.5]) cube([4, 4, 4], center = true);
    }
}

bolex_rewind_key();
