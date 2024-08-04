//mini pump holder
$fn=80;

difference() {
    union() {
        cube([20, 4, 40]);
        translate([-2, 1, 5]) cube([20, 24, 30]);
        translate([-4, -20, 0]) cube([4, 24, 40]);
    }
    //translate([10, 14, 15]) cylinder(d=12, h=45);
    translate([8, 13, 3]) cylinder(d=16.5, h=51);
    //translate([-3, 4.75, 33]) cube([11, 10, 51]);
    translate([2, 17, 3]) cube([12, 10, 51]);
    translate([-7, -10, 10]) rotate([0, 90, 0]) cylinder(d=5.2, h=10);
    translate([-7, -10, 30]) rotate([0, 90, 0]) cylinder(d=5.2, h=10);
    //translate([10, -3, 7]) rotate([-90, 0, 0]) cylinder(d=3.6, h=10);
    }