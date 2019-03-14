
time = 0;
/**
 * Super-8 to 16mm Reel Adapter. Designed to be used on a JK optical
 * printer, but will work with rewinds as well.
 *
 **/
module s8_16mm_reel_adapter () {
    BOTTOM_D = 21.53;
    BOTTOM_H = 1.5;
    D = 12.72;
    H = 10;
    SQUARE = 8.1;
    TAPER = 1.4;
    PEG_H = 9;
    PEG_L = 3.18;
    PEG_W = 2;
    
    $fn = 200;
    
    difference () {
        union () {
            cylinder(r = BOTTOM_D / 2, h = BOTTOM_H, center = true);
            translate([0, 0, (BOTTOM_H / 2) + H / 2]) cylinder(r = D / 2, h = H, center = true);
            translate([0, 0, (BOTTOM_H / 2) + H + (TAPER / 2)]) cylinder(r1 = D / 2, r2 = (D / 2) - TAPER, h = TAPER, center = true);
        }
        cube([SQUARE, SQUARE, 60], center = true);
    }
    for (i = [0 : 2]) {
        rotate([0, 0, i * 120]) translate([0, (D / 2) + (PEG_L / 2) - (PEG_W / 2), (BOTTOM_H / 2) + (PEG_H / 2)]) cube([PEG_W, PEG_L, PEG_H], center = true);
        rotate([0, 0, i * 120]) translate([0, (D / 2) + (PEG_L / 2) + (PEG_W / 3), (BOTTOM_H / 2) + (PEG_H / 2)]) cylinder(r = PEG_W / 2, h = PEG_H, center = true, $fn = 40);
    }
}

module reel_reference () {
    SQUARE = 7.95;
    translate([0, 0, 12.3 - 1]) {
        difference() {
            union() {
                translate([0, 0, -(12.3 / 2)]) cube([SQUARE, SQUARE, 12.3], center = true);
                rotate([0, 90, 0]) cylinder(r = SQUARE / 2, h =8, center = true);
                rotate([0, 90, 90]) cylinder(r = SQUARE / 2, h =8, center = true);
            }
            for (i = [0 : 4]) {
                rotate([0, 0, i * 90]) translate([0, 4.9, 1]) rotate([12, 0, 0]) cube([SQUARE, 2, 10], center = true);
            }
        }
        
    }
    translate([0, 0, (39 / 2)]) cylinder(r = 6.57 / 2, h = 39, center = true, $fn = 60);    
}
rotate([0, 0, time]) s8_16mm_reel_adapter();
//color("red") translate([0, 0, -2])  reel_reference();