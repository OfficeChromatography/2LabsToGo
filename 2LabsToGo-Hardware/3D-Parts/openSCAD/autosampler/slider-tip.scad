
$fn=80;

slider();

module rund() {
    difference() {
    cylinder(d=11.0, h=20);  //d war 11.75
    translate([-6.5, -6.9, -1]) cube([14, 8.35, 22]);
    }
}

module slider() {
    difference() { 
        union() {
        translate([-10.1, 0, 0]) cube([20.2, 20+10, 20]);
        translate([-10.1-3, -19, 0]) cube([3, 30+19, 20]);
        translate([10.1, -19, 0]) cube([3, 30+19, 20]);
        // in profile
        translate([-10.1, -10, 0]) cylinder(d=5, h=20);
        translate([10.1, -10, 0]) cylinder(d=5, h=20);
            cylinder(d=5, h=20);
        }
        //hole for the spindle
        translate([0, 25, -1]) cylinder(d=9, h=25); //import("tr8x8_nut.stl");
        //screws for Tr8x8 nut
        translate([9.5, 25, 10]) cylinder(d=2.7, h=14);
        translate([-9.5, 25, 10]) cylinder(d=2.7, h=14);
        translate([0, 25-9.5, 10]) cylinder(d=2.7, h=14);
        
        
        //Schraubenloch
        #translate([6, 20, 5]) rotate([-90, 0, 0]) cylinder(d=2.7, h=12);
        translate([-6, 20, 15]) rotate([-90, 0, 0]) cylinder(d=2.7, h=12);
    }
    translate([-15-3.6+5-0.3, 5, 8]) rotate([90, 0, 90]) end_stop_tip();
}

module end_stop_tip() {
    difference() {
        union() {
        translate([0, 12, 0]) rotate([0, 0, -90]) cube ([23, 10, 7.0]);
        translate([0, -2, 0]) rotate([0, 0, -90])
    cube([20.0, 5.8, 4.0]);
        }
    translate([-1, -12, 4]) rotate([0, 8, -90])
cube ([11, 10, 2.0]);
    translate([-1, -12, -2]) rotate([0, -8, -90])
cube ([11.0, 10, 2.0]);
    }
}