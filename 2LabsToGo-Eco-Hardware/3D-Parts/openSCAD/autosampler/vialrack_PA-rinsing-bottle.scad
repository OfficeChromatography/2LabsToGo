//your vial data, correct respectively
d=11;  //vial OD plus 0.5 mm
d1=13; //vial cap OD + 0.5 mm
h=42.2;  //vial height including cap plus 0.5 mm
n=8;  //number of sample vials without rinsing vial
$fn=80;
b=6;

vial_rack();
//test vial
//color("white", 0.6) {translate([10, 10, 3-2]) cylinder(d=d, h=h); 
    //translate([10, 10, 3+h-3]) cylinder(d=d1, h=3);
    //}

module vial_rack() {
difference(){
    D=4.5;
union() {
difference() {
    cube([116, 20, 40]);
    //cut bottom
    //translate([-2, -7, -6]) cube([160, 40, 8]); 
    
    //Screw holes/slit
    translate([20+4.5, 20-D, -3]) cylinder(d=6.5, h=6);
    translate([20+10, 20-D, -3]) cylinder(d=6.5, h=6);
    translate([20+4.5, 20-D-6.5/2, -3]) cube([5.1, 6.5, 6]);    
    
    translate([20+14.5, D, -3]) cylinder(d=6.5, h=6);
    translate([20+14.5+5.1, D, -3]) cylinder(d=6.5, h=6);
    translate([20+14.5, D-6.5/2, -3]) cube([5.1, 6.5, 6]);
    
    translate([20+5+70, 20-D, -3]) cylinder(d=6.5, h=6);
    translate([20+5+70+5.1, 20-D, -3]) cylinder(d=6.5, h=6);
    translate([20+5+70, 20-D-6.5/2, -3]) cube([5.1, 6.5, 6]);
    
    translate([20+1.5+84, D, -3]) cylinder(d=6.5, h=6);
    translate([20+1.5+84+5.1, D, -3]) cylinder(d=6.5, h=6);
    translate([20+1.5+84, D-6.5/2, -3]) cube([5.1, 6.5, 6]);
          
    //cutout vials
    for(x = [10 : 14: 14*n-4])
    translate([x, 10, 1+b+2]) cylinder(d=d, h=h-4);
    
    //cutout back view
    for(f = [10 : 14: 14*n-4])
    translate([f-2.5-0.25, -7, 5-2+4+2]) cube([5.5, 30, 30-4.75]);
    
    
    //cutout rounding the walls
    for(f = [10 : 14: 14*n-4])
    translate([f-d/2+d/2, -7, 30-2+b]) rotate([-90, 0, 0]) cylinder(d=5.5, h=30);
    
    //holes for the needle
    for(g = [10 : 14: 14*n-4])
    translate([g, 10, -1]) cylinder(d=5, h=12);
}
//body rinsing vial
difference() {
    translate([116, -6, 0]) cube([35, 32, 54]);
    translate([133, 10, 3-2]) cylinder(d=30, h=60);
    translate([133-30/2, 10, 10]) cube([30, 18, 60]);
    //cutout top vial
    translate([133-30/2, 10, 56-10]) cube([30, 18, 7-2]);
    translate([133-30/2, -9, 10]) cube([30, 36, 36]);
    translate([132-5, -9, 1]) cube([10, 36, 35]);
    }
}
}
//support for positioning
translate([-2, 5, 0]) cube([3, 10, 2]);
//translate([150, 10, 23]) sphere(d=3.4);
translate([150, 0, 20]) cube([3, 20, 2]);
}
