/**
 * 16mm roller with parametric inputs.
 * TODO: Make actually parametric
 **/
module sprocketed_roller (SPROCKETS = 8) {
    
    echo(SPROCKETS, "SPROCKETS");
    if (SPROCKETS < 8) {
        echo("WARNING: Minimum suggested number of sprockets is 8");
    }
    
    SPROCKET_BASE_D = 19.05;
    SPROCKET_BASE_H = 2.7;

    INNER_D = 13.98;
    INNER_H = 10.6;

    TOP_BASE_D = 18.47;
    TOP_BASE_H = 2.96;

    LIP_D = 18.84;
    LIP_H = 0.33;

    HOLLOW_D = 4.7;
    HOLLOW_BASE_D = 12.01;
    HOLLOW_BASE_H = 6.09;

    TOP_D = 21.66;
    TOP_H = 1.4;

    SPROCKET_H = 0.9;
    SPROCKET_W = 0.79;
    SPROCKET_L = 0.99;

    $fn = 100;
    //sub module
    module sprocket () {
        //cube([SPROCKET_L, SPROCKET_W, SPROCKET_H], center = true);
        translate ([0, 0, -SPROCKET_H/2]) {
            difference () {
                translate([0, 0, 0]) scale([1, 1, 2.25]) rotate([90, 0, 90]) cylinder(r = SPROCKET_W/2, h = SPROCKET_L, center = true);
                translate([0, 0, -1]) cube([2, 2, 2], center = true);
                translate([1.5, 0, 0]) rotate([0, -5, 0]) cube([2, 2, 2], center = true);
                translate([-1.5, 0, 0]) rotate([0, 5, 0]) cube([2, 2, 2], center = true);
           }
       }
           
    }
    
    difference () {
        union () {
            cylinder(r = SPROCKET_BASE_D / 2, h = SPROCKET_BASE_H, center = true);
            translate([0, 0, (INNER_H / 2) + (SPROCKET_BASE_H / 2)]) cylinder(r = INNER_D / 2, h = INNER_H, center = true);
            translate([0, 0, (TOP_BASE_H / 2) +INNER_H + (SPROCKET_BASE_H / 2)]) cylinder(r = TOP_BASE_D / 2, h = TOP_BASE_H, center = true);
            translate([0, 0, (TOP_BASE_H / 2) + INNER_H + (SPROCKET_BASE_H / 2) - (TOP_BASE_H / 2) + (LIP_H / 2)]) cylinder(r = LIP_D / 2, h = LIP_H, center = true);
            translate([0, 0, (TOP_BASE_H / 2) + INNER_H + (SPROCKET_BASE_H / 2) + (TOP_BASE_H / 2) - (LIP_H / 2)]) cylinder(r = LIP_D / 2, h = LIP_H, center = true);
            translate([0, 0, (TOP_H / 2) + (TOP_BASE_H / 2) + INNER_H + (SPROCKET_BASE_H / 2) + (TOP_BASE_H / 2) - (LIP_H / 2)]) cylinder(r = TOP_D / 2, h = TOP_H, center = true);
        }
        cylinder(r = HOLLOW_D / 2, h = 100, center = true);
        translate([0, 0, (HOLLOW_BASE_H / 2) - (SPROCKET_BASE_H / 2)]) cylinder(r = HOLLOW_BASE_D/2, h = HOLLOW_BASE_H + 0.1, center = true);
    }
    for (i = [0: SPROCKETS]) {
        rotate([0, 0, i * (360 / SPROCKETS)]) translate([(SPROCKET_BASE_D / 2) + (SPROCKET_H / 2) - .15, 0, (SPROCKET_BASE_H / 2) - (SPROCKET_L / 2)]) rotate([0, 90, 0]) sprocket();
    }
}

sprocketed_roller();