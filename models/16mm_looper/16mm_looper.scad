PLATTER_D = 254;
PLATTER_THICKNESS = 3.25;
//bearing holder
BH_D = 115.85;
BH_H = 16 - 3.84;
//bearing
BEARING_D = 28.75;
BEARING_ID = 12.8;
BEARING_H = 8;

//alt bearings
//BEARING_D = 20;
//BEARING_ID = 8;
//BEARING_H = 8;

//bolt placement
BOLT_D = 5;
BOLT_W = 80.4;
BOLT_HEAD_D = 6.36;
BOLT_HEAD_H = 5;

BOLT_HEX = 8.1;
BOLT_HEX_H = 3.25;

HANDLE_MOUNT_L = 305;
HANDLE_MOUNT_W = 40;
HANDLE_MOUNT_THICKNESS = 6;
HANDLE_MOUNT_BOLT_L = 285;
HANDLE_MOUNT_BOLT_D = 5;

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

module bolt_voids () {
    $fn = 100;
    for (i = [0 : 4]) {
        rotate([0, 0, i * (360 / 4)]) translate([BOLT_W / 2, 0, 0]) cylinder(r = BOLT_D / 2, h = 50, center = true);    
    }
}

module bolt_head_voids () {
    for (i = [0 : 2]) {
        rotate([0, 0, i * (360 / 2)]) {
            translate([BOLT_W / 2, 0, (BH_H / 2) - BOLT_HEAD_H / 2 + 0.01]) {
                cylinder(r = BOLT_HEAD_D / 2, h = BOLT_HEAD_H, center = true);
            }
        }    
    }    
}

module bolt_hex_voids () {
   rotate([0, 0, 90]) for (i = [0 : 2]) {
        rotate([0, 0, i * (360 / 2)]) {
            translate([BOLT_W / 2, 0, (BH_H / 2) - (BOLT_HEX_H / 2) + 0.01]) {
                hexagon(BOLT_HEX, BOLT_HEX_H);
            }
        }    
    } 
    
}

module platter () {
    difference () {
        //main shape
        cylinder(r = PLATTER_D / 2, h = PLATTER_THICKNESS, $fn = 360);
        bolt_voids();
        cylinder(r = (BEARING_ID - 4) / 2, h = 50, center = true, $fn = 60);
    }
}

module bearing_holder () {
    $fn = 100;
    difference () {
        //main shape
        cylinder(r = BH_D / 2, h = BH_H, $fn = 360, center = true);
        //bolts
        bolt_voids();
        bolt_head_voids();
        bolt_hex_voids();
        //inner void
        cylinder(r = BEARING_ID / 2, h = 50, center = true, $fn = 60);
        //bearing void
        translate([0, 0, -(BH_H / 2) + (BEARING_H / 2) - 0.1]) {
            cylinder(r = BEARING_D / 2, h = BEARING_H, center = true);
        }
    }
}

module bearing_holder_test () {
    translate([0, 0, (PLATTER_THICKNESS / 2) + (BH_H / 2)]) {
        intersection() {
            bearing_holder();
            translate([BH_D / 4 - 10, BH_D / 4 - 10, 0]) cube([BH_D / 2 + 20, BH_D / 2 + 20, BH_H + 2], center = true);
        }
    }
}


module handle_mount () {
    difference() {
        cube([HANDLE_MOUNT_W, HANDLE_MOUNT_L, HANDLE_MOUNT_THICKNESS], center = true);
        translate ([0, HANDLE_MOUNT_BOLT_L / 2, 0]) {
            cylinder(r = HANDLE_MOUNT_BOLT_D / 2, h = 10, center = true, $fn = 50);
        }
        translate ([0, -HANDLE_MOUNT_BOLT_L / 2, 0]) {
            cylinder(r = HANDLE_MOUNT_BOLT_D / 2, h = 10, center = true, $fn = 50);
        }
        cylinder(r = HANDLE_MOUNT_BOLT_D / 2, h = 10, center = true, $fn = 50);
    }
}
//platter();
//projection() platter();
//bolt_hex_voids();
handle_mount();