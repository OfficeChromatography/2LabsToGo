//distance tool 28.5 mm

difference() {
    union() {
        cube([22.5, 20, 15]);
        translate([-5, 0, -3]) cube([22.5+10, 20, 3]);
    }
    string = str("dist. tool");
    #translate ([27, 7, -1.5]) rotate([0, 180, 0])
    linear_extrude(2.0) text(string, size = 6, direction = "ltr", spacing = 1 );
}