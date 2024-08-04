
$fn=80;

translate([74.6,10,55]) rotate([180,0,0]) motor_holder();

//for testing
//translate([92.2, 0, 0]) cylinder(d=5, h=40);
//translate([74.6, -2, 0]) cube([5, 2, 40]);
//translate([74.6+35.2, -2, 0]) cube([5, 2, 40]);


difference() {
    cube([215,20,20]);
    translate([215-85-76, 20-6.5, 9.5]) cylinder (h=20, r=4.15);
    translate([215-85, 20-6.5, 9.5]) cylinder (h=20, r=4.15); 
    rotate([90,0,0]) translate([39,10,-25])  cylinder (h = 40, r = 2.6); 
    rotate([90,0,0]) translate([215-75,10,-25])  cylinder (h = 40, r = 2.6); 
    rotate([90,0,0]) translate([39,10,-21]) cylinder (h = 6, r=5);
    rotate([90,0,0]) translate([215-75,10,-21]) cylinder (h=6, r=5);  
    translate( [215-5.5, 10, -2]) rotate([0, 0, 90]) cylinder(d=3.7, h=17); 
    translate( [215-5.5-54, 10, -2]) rotate([0, 0, 90]) cylinder(d=3.7, h=17);  
}   

module motor_holder() {
    d=4.6;  //hole positions corrected WS
    difference() {
    cube([35.2, 10, 35.2]);
    
    translate([d, -3, d]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24);
    translate([d, -1, d]) rotate([-90, 0, 0]) cylinder(d=5.7, h=4);
    translate([d+26.2, -2, d]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24); 
    translate([d+26.2, -1, d]) rotate([-90, 0, 0]) cylinder(d=5.7, h=4);
    translate([d, -2, d+26.2]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24);
    translate([d, -1, d+26.2]) rotate([-90, 0, 0]) cylinder(d=5.7, h=4);
    translate([d+26.2, -2, d+26.2]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24);
    translate([d+26.2, -1, d+26.2]) rotate([-90, 0, 0]) cylinder(d=5.7, h=4);
    
    translate([17.6, -1, 17.6]) rotate([-90, 0, 0]) cylinder(d=24.46, h=20);
    }
    
}    
