include <../../libraries/Minolta16.scad>;

time=0;

module feed () {
  INNER_D = FEED_D - WALL_THICKNESS;
  1_OFFSET_Z = (CART_H / 2) - (CAP_LIP_H / 2);
  
  difference () {
    union () {
        cylinder(r = FEED_D / 2, h = CART_H, center = true);
        translate([-FEED_D / 4, FEED_D / 4, 0]) {
            cube([FEED_D / 2, FEED_D / 2, CART_H], center = true);
        }
    }
    translate([0, 0, WALL_THICKNESS]) cylinder(r = INNER_D / 2, h = CART_H, center = true);
	//notch
    //translate([-(FEED_D / 2) + 1, 6, (CART_H / 2) - 1]) cube([2, 2, 2], center = true);
     //film neg
    translate ([-FEED_D / 2, FILM_NEG_OFFSET_Y, WALL_THICKNESS / 2]) {
      cube([FEED_D, FILM_NEG_Y, CART_H], center = true);
    }
    //cap neg
    //translate([0, 0, FEED_CAP_OFFSET_Z]) feed_cap_neg();
  }
}

module feed_cap() {
    cylinder(r = FEED_D / 2, h = CART_H, center = true);
}

module feed_cap_neg () {
    INNER_D = FEED_D - CAP_LIP;

    difference () {
        cylinder(r = FEED_D / 2, h = CAP_LIP_H, center = true);
        translate([0, 0, WALL_THICKNESS]) cylinder(r = INNER_D / 2, h = CART_H, center = true);
        translate([-FEED_D / 4, FEED_D / 4, 0]) {
            cube([FEED_D / 2, FEED_D / 2, CART_H], center = true);
        }
    }
}

module takeup () {
  INNER_D = TAKEUP_D - WALL_THICKNESS;
  difference () {
    union () {
        cylinder(r = TAKEUP_D / 2, h = CART_H, center = true);
        translate([TAKEUP_D / 4, TAKEUP_D / 4, 0]) {
            cube([TAKEUP_D / 2, TAKEUP_D / 2, CART_H], center = true);
        }
    }
	//notch
    //translate([(TAKEUP_D / 2) - 1, 7.5, (CART_H / 2) - 1]) cube([2, 2, 2], center = true);
    translate([0, 0, WALL_THICKNESS]) cylinder(r = INNER_D / 2, h = CART_H, center = true);
     //film neg
    translate ([TAKEUP_D / 2, FILM_NEG_OFFSET_Y - TAKEUP_OFFSET_Y, WALL_THICKNESS / 2]) {
      cube([TAKEUP_D, FILM_NEG_Y, CART_H], center = true);
    }
  }
}

module connector () {
    cube([CONNECT_X, CONNECT_Y, CONNECT_Z], center = true);
}

module minolta16_cartridge (DEBUG = true) {
    translate([SPACING / 2, 0, 0]) feed();
    translate([-SPACING / 2, TAKEUP_OFFSET_Y, 0]) takeup();
    translate([CONNECT_OFFSET_X, CONNECT_OFFSET_Y, CONNECT_OFFSET_Z]) {
        connector();
    }
  //debug
  if (DEBUG) { 
    //plane
    translate ([0, FILM_NEG_OFFSET_Y , .25]) {
      cube([SPACING, .14, 16], center = true);
    }
  }
}

rotate([0, 0, time]) minolta16_cartridge(false);

