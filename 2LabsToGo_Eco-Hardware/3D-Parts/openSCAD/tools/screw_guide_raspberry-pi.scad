//screw guide raspberry pi electronic box
$fn=80;

    difference() {
        cylinder(d=7, h=30);
        translate([0, 0, -2]) cylinder(d=5.6, h=45);
    }
    difference() {
        translate([0, -4.2, 0]) cube([20, 1.4, 15]);
        string1 = str("screw-");
        translate ([3, -3, 10]) rotate([90, 0, 0])
        linear_extrude(2.0) text(string1, size = 3, direction = "ltr", spacing = 1 );
        string2 = str("guide");
        translate ([3, -3, 5]) rotate([90, 0, 0])
        linear_extrude(2.0) text(string2, size = 3, direction = "ltr", spacing = 1 );
    }