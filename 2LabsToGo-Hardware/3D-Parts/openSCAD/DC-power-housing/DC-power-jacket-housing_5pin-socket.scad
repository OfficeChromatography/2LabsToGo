 //DC power jacket housing

use <threads.scad>

$fn=80;
h=35;

connector_block();
//cover();

module thread() {
    metric_thread (diameter=16, pitch=1.5, length=26);
}

module connector_block() {
    h=34;
    difference() {
        union() {
            translate([0, 0, 0]) cube([60, 25, h]);
        }
        //hole for plateholder plug
        translate([30, 12.5, 14]) thread(); 

        //cable channel
        translate([5, 4.5, 14]) cube([50, 16, 13]);
        //translate([5, 5.5, 14]) cube([50, 15, 15]);
        translate([5, 8, -1]) cube([50, 16, 15]);
        //cutout alu-profile
        translate([-2, 18, -2]) cube([70, 8, 22]);
        
        //screw holes for M3x20
        translate([10, -2, 10]) rotate([-90, 0, 0, ]) cylinder(d=3.2, h=12);
        translate([10, -2, 10]) rotate([-90, 0, 0, ]) cylinder(d=6.5, h=2+4);  
        translate([60-20, -2, 10]) rotate([-90, 0, 0, ]) cylinder(d=3.2, h=12);
        translate([60-20, -2, 10]) rotate([-90, 0, 0, ]) cylinder(d=6.5, h=2+4);  
        }
}

module connector_block_2() {
    h=50;
    difference() {
        translate([0, 0, 0]) cube([60, 18, h]);
        translate([60-14, 9, h-10]) rotate([0, 90, 0]) cylinder(d=5.7, h=16); //thread(); 
        translate([10, 9, 3]) cylinder(d=8, h=24);
        translate([10, 9, h-20]) cylinder(d=15.2, h=20); //thread();
        translate([30, 9.5, h-14]) cylinder(d=9.5, h=24);
        translate([30, 9.5, 11]) cylinder(d=8.5, h=24); 
        translate([10, 9.5, h-16]) cylinder(d=9.5, h=24);
        translate([10, 9.5, 11]) cylinder(d=8.5, h=24); 
        //cable channel
        translate([5, 5, -1]) cube([60, 16, 20]);
        //screw holes
        translate([30, -2, h-10]) rotate([-90, 0, 0, ]) cylinder(d=2.8, h=10);
        translate([20, -2, 10]) rotate([-90, 0, 0, ]) cylinder(d=3.2, h=10);
        translate([20, -2, 10]) rotate([-90, 0, 0, ]) cylinder(d=6.5, h=2+2.5);
        translate([40, -2, 10]) rotate([-90, 0, 0, ]) cylinder(d=3.2, h=10);
        translate([40, -2, 10]) rotate([-90, 0, 0, ]) cylinder(d=6.5, h=2+2.5);    
    }
}

module cover() {
    difference() {
        translate([0, 0, 0]) cube([60, 25, 13]);
        //hole for plateholder cable plug
        translate([30, 12.5, -1]) cylinder(d=19.8, h=13.2, $fn=6); 
        //hole for backlight plug
        //translate([15, 12.5, -1]) cylinder(d=12.5, h=4);
        string = str("cover socket");
        //translate ([8, 10, 12])         linear_extrude(2.0) text(string, size = 6, direction = "ltr", spacing = 1 );
    }
}

module nut_guide() {
    difference() {
        cube([50, 13, 2.5]);
        translate([0, 6.5, -1]) cylinder(d=15, h=4, $fn=6);
        
    }
}