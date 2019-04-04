$fn = 90;
time = 0;

include <../../libraries/knurledFinishLib_v2.scad>;

module bolex_rewind_knurled_handle () {
  difference () {
    knurled_cyl(13, 13, 2, 2, .3, 0, 0);
    cylinder(r = 5.6 / 2, h = 40, center = true);
  }
}

module bolex_rewind_knurled_handle_SPLIT (piece = 0) {
  difference () {
    bolex_rewind_knurled_handle();
    if (piece == 0) {
      translate([15, 0, 0]) cube([30, 30, 41], center = true);
      translate([0, 3.7, 13.75 / 2]) cube([2, 2, 5], center = true);
      translate([0, -3.7, 13.75 / 2]) cube([2, 2, 5], center = true);
    } else if (piece == 1) {
      difference () {
        translate([-15, 0, 0]) cube([30, 30, 41], center = true);
        translate([0, 3.7, 13.75 / 2]) cube([1.8, 1.8, 4.8], center = true);
        translate([0, -3.7, 13.75 / 2]) cube([1.8, 1.8, 4.8], center = true);
      }
    }
  }
}

rotate([0, 0, time]) {
  bolex_rewind_knurled_handle_SPLIT(0);
  translate([10, 0, 0]) bolex_rewind_knurled_handle_SPLIT(1);
}