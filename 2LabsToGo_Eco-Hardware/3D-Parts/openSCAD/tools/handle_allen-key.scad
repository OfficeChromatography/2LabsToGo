//handle for allen keys

$fn=80;

allen_key_2mm();
//allen_key_1_5mm();

module allen_key_2mm() {
d1=2.9;  //2 mm
d2=12;
difference() {
    cylinder(d=d2, h=50);
    translate([0, 0, -1]) rotate([0, 0, 30]) cylinder(d=d1, h=55, $fn=6);
    translate([0, -d1/2, -1]) cube([10, d1, 35]);
    //translate([0, -2.3/2, 30-2.3]) cube([8, 10, 2.3]);
    }
}

module allen_key_1_5mm() {
d1=2.6;  //1.5 mm
d2=10;

difference() {
    cylinder(d=d2, h=50);
    translate([0, 0, -1]) rotate([0, 0, 30]) cylinder(d=d1, h=55, $fn=6);
    translate([0, -d1/2, -1]) cube([10, d1, 35]);
    //translate([0, -2.3/2, 30-2.3]) cube([8, 10, 2.3]);
    }
}