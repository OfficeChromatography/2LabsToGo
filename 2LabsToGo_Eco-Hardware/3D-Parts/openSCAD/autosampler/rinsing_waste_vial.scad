//rinsing + waste vial

$fn=80;

//vial();
//translate([0, 0, 51-4]) vial_cap();
vial_cap();

module vial() {
    $fn=100;
    difference() {
        cylinder(d=30, h=51);
        translate([0, 0, 3]) cylinder(d=28, h=51);
    }
}

module vial_cap() {
    difference() {
        union() {
            translate([0, 0, 0]) cylinder(d=29.2, h=4);
            translate([0, 0, 4]) cylinder(d=30, h=2);
        }
        translate([0, 0, -1]) cylinder(d=14, h=6.6); //0.4 mm Membran
    }
}