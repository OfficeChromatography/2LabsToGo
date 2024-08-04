$fn=80;

difference() {
    union() {
        cube([12.5, 5, 20]);
        translate([12.5-4, 0, 0]) cube([4, 18, 20]);
        translate([12.5, 18-5, 0]) cube([14, 5, 20]);
    }
    translate([12.5-10, -1, 10]) rotate([-90, 0, 0]) cylinder(d=4.2, h=10);
    translate([22, 10, 10]) rotate([-90, 0, 0]) cylinder(d=4.2, h=10);
    translate([22, 16.5, 10]) rotate([-90, 0, 0]) cylinder(d=8.2, h=10);
}
