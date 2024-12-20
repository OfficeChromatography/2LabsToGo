//Motorhalterung Autosampler

$fn=80;
h=71;
w=5.5;

motor_holder();
//mounting_profile();

module motor_holder() {
difference() {
    translate([-21, 0, 0]) cube([42, h, 5]);
    translate([21-w, h-w, -1]) cylinder(d=3.2, h=7);
    translate([21-w, h-w, 2.5]) cylinder(d=5.7, h=7);
    translate([-21+w, h-w, -1]) cylinder(d=3.2, h=7);
    translate([-21+w, h-w, 2.5]) cylinder(d=5.7, h=7);
    translate([-21+w, h-w-31, -1]) cylinder(d=3.2, h=7);
    translate([-21+w, h-w-31, 2.5]) cylinder(d=5.7, h=7); 
    translate([21-w, h-w-31, -1]) cylinder(d=3.2, h=7);
    translate([21-w, h-w-31, 2.5]) cylinder(d=5.7, h=7);
    translate([0, h-w-31/2, -1]) cylinder(d=27.5, h=7);
}
//mounting ears
difference() {
    union() {
        translate([21, 25, 0]) cube([15, 20, 5]);
        translate([-36, 25, 0]) cube([15, 20, 5]);
    }
    translate([27, 35, -1]) cylinder(d=5.2, h=7);
    translate([-27, 35, -1]) cylinder(d=5.2, h=7);
    }
//mounting on profile
    difference() {
        union() {
            translate([-13.1, 0, 0]) cube([26.2, 5, 85]);
            //translate([-13.1, 5, 65]) cube([3, 13, 20]);
            //translate([10.1, 5, 65]) cube([3, 13, 20]);
    }
    translate([0, -1, 35]) rotate([-90, 0, 0]) cylinder(d=5.2, h=10);
    translate([0, -1, 85-15]) rotate([-90, 0, 0]) cylinder(d=5.2, h=10);
}
}

module mounting_profile() {
    difference() {
        union() {
            translate([-13.1, 0, 0]) cube([26.2, 5, 85-7.5]);
            //translate([-13.1, 5, 65-7.5]) cube([3, 13, 20]);
            //translate([10.1, 5, 65-7.5]) cube([3, 13, 20]);
            translate([-13.1, 5, 0]) rotate([0, 90, 0]) cylinder(d=10, h= 26.2);  //round
        }
    translate([0, -1, 25]) rotate([-90, 0, 0]) cylinder(d=5.2, h=10);
    translate([0, -1, 85-20]) rotate([-90, 0, 0]) cylinder(d=5.2, h=10);
    translate([-15, 5, -6]) cube( [30, 6, 12]);
    translate([0, -1, 2.5]) rotate([-90, 0, 0]) cylinder(d=5.2, h=10);   
        }
}


module rund() {
    difference() {
    cylinder(d=11.75, h=18);
    translate([-6.5, -6.92, -1]) cube([14, 8.35, 22]);
    }
    //cube([11.5/2, 2, 20]);
    //translate([0, 1.43, 0]) cube([12, 4.5, 10]);
}