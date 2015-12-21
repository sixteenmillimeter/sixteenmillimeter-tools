time=0;
module hot_shoe_mount() {

	difference() {

		cube([20,14.8,17.5], center=true);

		translate([0,-7.6,0]) {
			cube([9.4,2.5,17.5], center=true);
		}
	
		translate([-8.125,-0.60,0]) {
			cube([3.99,10,17.5], center=true);
		}
	
		translate([-9.65,-6.5,0]) {
			cube([1,2,17.9], center=true);
		}
	
	
		translate([8.125,-0.60,0]) {
			cube([3.99,10,17.5], center=true);
		}
	
		translate([9.65,-6.5,0]) {
			cube([1,2,17.9], center=true);
		}
		translate([0, -4, 6]) cube([6, 6, 6], center=true);
		
	}
}

rotate([0,0, time])  hot_shoe_mount();