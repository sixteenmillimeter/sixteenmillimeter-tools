t = 0;
include <../../libraries/threads.scad>;

module base () {
    $fn = 100;
    union() {
        translate([0, 0, -15])cylinder(r = 8.45, h = 20, center = true);
        translate([0, 0, -24.5])cylinder(r = 11.1, h = 9.5, center = true, $fn = 6);
    }
}

module lomo_bottom_screw () {
    //base();
    difference () {
        //outer screw
        translate([0, 0, -7.1]) metric_thread (diameter=10, pitch=1.5,thread_size = 1.6, length=27.1);
        //taper top of screw
        translate([0, 0, 19]) difference() {
            cylinder(r = 8, h = 3.5, center = true, $fn = 100);
            cylinder(r1 = 6, r2 = 3, h = 4.5, center = true, $fn = 100);
        }
        //hollow center
        cylinder(r = 1.85, h = 100, center = true, $fn = 60);
    }
}
difference() {
    //color("green")
    //translate([37, -3.5, 0]) import("./lomo_part_fixed.stl");
    import("./lomo_part_half.stl");
    //translate([200, 0, 0]) cube([400, 400, 400], center = true);
}
rotate([0, 0, t]) difference() {
    color("green") lomo_bottom_screw();
    //translate([-100, 0, 0])cube([200, 200, 200], center = true);
}
