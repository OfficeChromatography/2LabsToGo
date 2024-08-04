//needle pusher

$fn=100;

pusher_needle();  //Luer connector

module pusher_needle() {
    difference() {
        union() {
            translate([-1, 0, 6.2]) cube([22, 20, 25-0.2]);
            translate([-3.1, 0, 0]) cube([3, 20, 31]);
            translate([20.1, 0, 0]) cube([3, 20, 31]);
            translate([23, 0, 25/2-3+6+1-1]) cube([12, 20, 6]);
            translate([23+17, 18.2, 25/2-3+6+3+1-1]) rotate([90, 0, 0]) cylinder(d=18, h=18.2);
        }
    //hole for 6-mm bearings 
    translate([20/2, 25, 9+6]) rotate([90, 0, 0]) cylinder(d=8.2, h=30);
    //countersink front
    translate([20/2, 1.2, 9+6]) rotate([90, 0, 0]) cylinder(d=12, h=5);
    //countersink back
    translate([20/2, 22, 9+6]) rotate([90, 0, 0]) cylinder(d=12, h=3.2);
        
    //cutout for mouting screws
    translate([20/2-4.5, -2, 0]) cube([9, 25, 8]);
        
  //spindle head cutout motor ACT 16HSL3404
        r_spindle_head=2.1;
        h_spindle_head=6.2;
        d_spindle=5;
        r_spindle=d_spindle/2;
   //spindle cutout
    translate([20/2, 20-h_spindle_head-1, 19.5+6]) rotate([-90, 0, 0]) cylinder(r=r_spindle_head, h=h_spindle_head+2);
        
    //hole for screw to fix the spindle
    translate([-4, 20-h_spindle_head/2, 25-(25-19.5)+6]) rotate([0, 90, 0]) cylinder(d=3.7, h=14);
        
    //needle adapter  //luer-lock
    translate([23+17, 9, 25/2-3+6+3+1-1]) rotate([90, 0, 0]) cylinder(d=10.2, h=12);
    translate([23+17, 20, 25/2-3+6+3+1-1]) rotate([90, 0, 0]) cylinder(d=9.5, h=12, $fn=6);
    //hole for fixing screw M3
    translate([23+17, 18-4.5, 25/2+6+1-1]) rotate([0, 60, 0]) cylinder(d=2.7, h=10); 
    //test hole for fixing screw
    translate([23+17, 18-4.5, 6+1-1]) cylinder(d=1, h=10); 
    }
    //test for needle
    //translate([23+17, 20, 25/2-3+6+3+1-1]) rotate([90, 0, 0]) cylinder(d=1, h=40);
    
      
}