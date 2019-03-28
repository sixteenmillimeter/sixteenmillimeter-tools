
include <../../libraries/Minolta16.scad>;

time=0;

module minolta16_cart_case () {
    H = 19;
    
    FOD = FEED_D + 3;
    FID = FEED_D + .5;
    TOD = TAKEUP_D + 3;
    TID = TAKEUP_D + .5;
    MID = 17;
    MID_OFFSET = 2.55;

    difference () {
        union () {
            translate([SPACING / 2, 0, 0]) cylinder(r = FOD / 2, h = H, center = true);
            translate([-SPACING / 2, TAKEUP_OFFSET_Y, 0]) cylinder(r = TOD / 2, h = H, center = true);
            translate([0, MID_OFFSET, 0]) cube([SPACING, MID, H], center = true);
        }
        translate([0, 0, -1]) union () {
            translate([SPACING / 2, 0, 0]) cylinder(r = FID / 2, h = H, center = true);
            translate([-SPACING / 2, TAKEUP_OFFSET_Y, 0]) cylinder(r = TID / 2, h = H, center = true);
            translate([0, MID_OFFSET - .25, 0]) cube([SPACING, MID - 2, H], center = true);
        }
    }
}

rotate([180, 0, time + 180]) minolta16_cart_case();
