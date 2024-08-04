//tool for miniature bearings
$fn=60;

difference() {
    union(){
        cube( [14.4, 15, 9]);
        translate([0, -50, 0]) cube([14.4, 50, 4]);
    }
    translate([14.4/2, 8.4, -1]) cylinder(d=10, h=12);
    translate([14.4/2-10/2, 8.4, -1]) cube([10, 10, 12]);
}