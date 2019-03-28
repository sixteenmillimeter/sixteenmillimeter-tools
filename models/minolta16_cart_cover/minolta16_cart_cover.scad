
include <../../libraries/Minolta16.scad>;

time=0;

module minolta16_cart_cover () {
    H = 4;
    
    FOD = FEED_D + 3;
    TOD = TAKEUP_D + 3;
    MID = 17;
    MID_OFFSET = 2.55;

    difference () {
        union () {
            translate([SPACING / 2, 0, 0]) cylinder(r = (FOD + 3) / 2, h = H, center = true);
            translate([-SPACING / 2, TAKEUP_OFFSET_Y, 0]) cylinder(r = (TOD + 3) / 2, h = H, center = true);
            translate([0, MID_OFFSET, 0]) cube([SPACING, MID + 3, H], center = true);
        }
        translate([0, 0, 1.5]) union () {
            translate([SPACING / 2, 0, 0]) cylinder(r = FOD / 2, h = H, center = true);
            translate([-SPACING / 2, TAKEUP_OFFSET_Y, 0]) cylinder(r = TOD / 2, h = H, center = true);
            translate([0, MID_OFFSET, 0]) cube([SPACING, MID, H], center = true);
        }
    }
}

rotate([0, 0, time]) minolta16_cart_cover();
