// Y-end_WS

$fn=80;

//y_axis_front();
cork();

color("blue", 1.0) {
//translate([182-1, 12, 20]) rotate([90, 0, 0]) endstop();
//translate([178, 4, 4]) rotate([90, 0, 180]) endstop_mech();
}

module y_axis_front() {
difference() {
    cube([215,20,20]);
        //cutout ball bearings
        translate([92.2, 12, 27])
        rotate([90,0,0])
        cylinder(h=10, r=24); 
        //cutout rods
        translate([215-85-76, 6, 9.5]) cylinder (h = 20, r=4.15);
        translate([215-85, 6, 9.5]) cylinder (h = 20, r=4.15);
        //cutout screws
        rotate([90,0,0]) translate([30,10,-25])  cylinder (h=40, r=2.6);
        rotate([90,0,0]) translate([215-54,10,-25])  cylinder (h=10, r=2.6);
        rotate([90,0,0]) translate([215-54,10,-22])  cylinder (h=25, r=2.6);
        rotate([90,0,0]) translate([215-54,10,-22+4])  cylinder (h=25, d=9.5);
        rotate([90,0,0]) translate([215-29.9,15.3,-25]) cylinder (h = 40, r=1.4);
        rotate([90,0,0]) translate([215-29.9+19,15.3,-25]) cylinder (h = 40, r=1.4);
        rotate([90,0,0]) translate([215-78.9+3.8,17.27,-21]) cylinder (h = 35, r=1.4);
       rotate([90,0,0]) translate([215-78.9+22.45,17.27,-21]) cylinder (h = 35, r=1.4);
        //counter sinks
        rotate([90,0,0]) translate([30,10,-5]) cylinder (h=20, r=5);
        rotate([90,0,0]) translate([215-54,10,-16]) cylinder (h=7, r=5);
        rotate([90,0,0]) translate([215-29.9,15.3,-4]) cylinder (h=20, r=3);
        rotate([90,0,0]) translate([215-29.9+19,15.3,-4]) cylinder (h=20, r=3);
        rotate([90,0,0]) translate([92.2,12,-30]) cylinder (h=40, r=1.4);
        translate([215-6.5, -1, 9]) cube([10, 12, 12]);
        translate([215-41, 9, 9]) cube([8.1, 12, 12]);
       translate([215-34, 3, 9]) cube([28, 14, 12]);
       translate([215-78.9, 3, 6.3]) cube([47, 9.7, 14.7]);
       translate([215-78.9, 4.8, 3.3]) cube([47, 1.5, 17.7]);
}
//support for optical endstop
difference() {
    union() {
    translate([215-32.9, 9, 8]) cube([6, 11, 12]);
    translate([215-32.9+6+12.5, 9, 8]) cube([14.4, 8, 12]);
    }
    rotate([90,0,0]) translate([215-29.9,15.3,-25]) cylinder (h=40, r=1.4);
    rotate([90,0,0]) translate([215-29.90+19,15.3,-25]) cylinder (h=40, r=1.4);
}
//support mech. endstop
translate([215-78.9, 3, 6.3]) cube([5, 1.8, 9]); 
translate([215-78.9+5+30, 3, 6.3]) cube([5, 1.8, 9]); 
}

module cork() {
    difference() {
    cylinder(d1=9, d2=9.5, h=3);
    string="T";
    translate([-2.6, -3.6, 2.5])
    linear_extrude(2.0) text(string, size = 6, direction = "ltr", spacing = 1 );  
    }
}

module endstop_mech() {
    cube([39.5, 16.2, 1.6]);
    translate([4, 2, 0]) cube([7, 12, 7]);
    translate([20.5, 7.5, 0]) cube([13, 9, 7]);
}