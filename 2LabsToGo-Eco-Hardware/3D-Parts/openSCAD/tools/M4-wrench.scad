//M4-Ringschlüssel
$fn=60;

difference() {
    union() {
        cylinder(d=13, h=4);
        translate([0, -5, 0]) cube([100, 10, 4]);
    }
    translate([0, 0, -1]) cylinder(d=8.4, h=6, $fn=6);
}