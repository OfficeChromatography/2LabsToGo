
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
        translate([9.5, 25, -1]) cylinder(d=2.7, h=14);
        translate([-9.5, 25, -1]) cylinder(d=2.7, h=14);
        translate([0, 25-9.5, -1]) cylinder(d=2.7, h=14);
        
        
        //Schraubenloch
        translate([6, 20, 5]) rotate([-90, 0, 0]) cylinder(d=2.8, h=12);
        translate([-6, 20, 15]) rotate([-90, 0, 0]) cylinder(d=2.8, h=12);
    }
}