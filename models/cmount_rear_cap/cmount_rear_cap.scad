module cmount_rear_cap () {
    $fn = 200;
    ID = 25.26;
    OD = 30;
    H = 6.55;
    T = 2.15;
    difference () {
        cylinder(r = OD / 2, h = H, center = true);
        translate([0, 0, T]) cylinder(r = ID / 2, h = H, center = true);
    }
}

cmount_rear_cap();