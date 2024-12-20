$fn=100;

    //select part to render => uncomment
pusher_body();
//test shaft
//translate([39/2, 7, 9]) rotate([90, 0, 0]) cylinder(d=6.1, h=93);

module pusher_body() {
    translate([0, 0, 0]) motor_holder();
    translate([0, 0, 0]) back_on_profile_3();
    
    //test needle
    //#translate([49.5, -back-30, 25/2+1-1]) rotate([-90, 0, 0]) cylinder(d1=1.2, d2=1.2, h=50);
}

module motor_holder() {
    difference() {
    cube([39, 10+4, 39]);
    //holes for motor screws
    translate([4, -2, 4]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24);
    translate([4, -2, 4]) rotate([-90, 0, 0]) cylinder(d=5.7, h=10);
    translate([4+31, -2, 4]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24); 
    translate([4+31, -2, 4]) rotate([-90, 0, 0]) cylinder(d=5.7, h=10);
    translate([4, -2, 4+31]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24);
    translate([4, -2, 4+31]) rotate([-90, 0, 0]) cylinder(d=5.7, h=10);
    translate([4+31, -2, 4+31]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24);
    translate([4+31, -2, 4+31]) rotate([-90, 0, 0]) cylinder(d=5.7, h=10);
    //hole for spindle
    translate([19.5, -2, 19.5]) rotate([-90, 0, 0]) cylinder(d=7, h=24);
    //hole for motor
    translate([19.5, 7.5+4, 19.5]) rotate([-90, 0, 0]) cylinder(d=22.5, h=5);
        
    //cutout shaft
    translate([39/2, 7, 9]) rotate([90, 0, 0]) cylinder(d=6.2, h=9);
    }
}

back=76;
shaft=back+7+10;

module back_on_profile_3() {
    difference() {
        union() {
        translate([9.5, -back, -6]) cube([20, back, 6]);
        translate([0, 0, -6 ]) cube([39, 14, 6]);
        translate([9.5, -back-10, -6]) cube([20, 10, 25]);    
        translate([9.5+20, -back-10-4, -6]) cube([30-5-9.5/2+2, 9.5, 25]);
        translate([9.5+20, -back-10+3, -6]) cylinder(d=14, h=25);
        translate([54-9.5/2+0.5+2, -back-10+0.75, -6]) cylinder(d=9.5, h=25);
        }
        
        //guiding hole for needle
        translate([49.5, -back-10-5, 25/2+1-1]) rotate([-90, 0, 0]) cylinder(d1=1.2, d2=1.2, h=5);
        translate([49.5, -back-10-4+2, 25/2+1-1]) rotate([-90, 0, 0]) cylinder(d=5.4, h=8);        
        //for testing
        //#translate([49.5, -86.5, 25/2+1]) rotate([-90, 0, 0]) cylinder(d=12, h=32);
        
        
    //screw holes to mount the needle pusher on the e-axis (M5x10 screws)
    translate([19, -10, -8]) cylinder(d=5.2, h=16);
    translate([19, -10, -2]) cylinder(d=10, h=10);
    translate([19, -50, -8]) cylinder(d=5.2, h=16);
    translate([19, -50, -2]) cylinder(d=10, h=10);
        
    //cutout shaft
    translate([39/2, 7, 9]) rotate([90, 0, 0]) cylinder(d=6.2, h=115);
    //cutout screw to fix the shaft
    translate([6, -81, 9]) rotate([0, 90, 0]) cylinder(d=3.6, h=14);
        
    //srews for stabilizing the needle guide part
    translate([14, -back-10+5, -7]) cylinder(d=2.7, h=14);
    translate([14, -back-10+5, -7]) cylinder(d=5.7, h=4.5);    
    translate([9.5+20-4.5, -back-10+5, -7]) cylinder(d=2.7, h=14);
    translate([9.5+20-4.5, -back-10+5, -7]) cylinder(d=5.7, h=4.5);    
    }
    echo("shaft: ", shaft, " mm");
}