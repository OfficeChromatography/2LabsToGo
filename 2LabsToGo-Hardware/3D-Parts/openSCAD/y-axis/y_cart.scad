$fn=80;
distance=111;

y_moving();
//belt_plate();
//timing_belt();

module bearing() {
difference() {
    cube([20, 24, 14]);
    translate([10, -1, 10]) rotate([-90, 0, 0]) cylinder(d=15, h=26);
    }
}

module y_moving() {
    difference() {
        union() {
            cube([120, 90, 7]);
            translate([0, 90, 0]) cube([120, 5, 4]);
            translate([51, 24, 0]) cube([10, 40, 15]);
        }
        translate([12, 56, 4]) cube([20, 24, 4]);
        translate([12+76, 56, 4]) cube([20, 24, 4]);
        //cutout for M4 screw fitting to the positioning holes of the plate holder
        translate([4.5, 68, -1]) cylinder(r=2.0, h=12);
        translate([4.5+distance, 68, -1]) cylinder(r=2.0, h=12);
        //cutout pulley
        translate([60-25/2, -1, 1]) cube([25, 25, 7]);
        //cutout screw belt plate
        translate([55, 24+20, 7+4]) rotate([0, 90, 0]) cylinder(d=3.7, h=16);
        translate([50, 24+20, 7+4]) rotate([0, 90, 0]) cylinder(d=4.2, h=5);
        //translate([61-3.2, 24+20, 7+4]) rotate([0, 90, 0]) cylinder(d=7.7, h=4.2, $fn=6);
        //cutout screw endstop
        translate([120-8-8, 90+5-3.6, 1.5])  cube([8, 5, 3]); 
        
        //cutout magnets
        translate([4, 22+8.1/2, 3.5]) cube([9, 8.1, 3], center=true);
        translate([4, 79.9+8.1/2, 3.5]) cube([9, 8.1, 3], center=true);
        translate([120-4, 22+8.1/2, 3.5]) cube([10, 8.1, 3], center=true);
        translate([120-4, 79.9+8.1/2, 3.5]) cube([10, 8.1, 3], center=true);
        //cutout timing belt
        translate([55, 24+43.25, 7]) rotate([0, 0, -90]) timing_belt();
        
    string="100.5%";
    translate([85, 20, 6.5])     linear_extrude(2.0) text(string, size = 6, direction = "ltr", spacing = 1 );
    }
    translate([12, 56, 2]) bearing();
    translate([12+76, 56, 2]) bearing();
    /*D=2.5;
    R=0.75;
    for (i=[0:15])
        translate([57+7, 23.7+R+i*D+0.75, 10]) cylinder(r=R, h=8);
    */
    
    //tip for endstop
    translate([120-12, 90-10, 7]) cube([12, 10, 12]);
}

module belt_plate() {
    D=2.5;
    R=0.75;
    
    difference() {
        union() {
            cube([40, 10, 8]);
            //for (i=[0:15])
        //translate([R+i*D+0.75, 5, 0]) cylinder(r=R, h=8);
        }
    translate([20, -2, 4]) rotate([-90, 0, 0]) cylinder(d=4.2, h=15);
    //translate([20, -2, 4]) rotate([-90, 0, 0]) cylinder(d=6.2, h=5, $fn=6);
    }    
}

module timing_belt() {
difference() {
    cube([44, 1, 10,]);
    D=2.5;
    R=0.75;
    for (i=[0:16])
        translate([i*D+2, 1, -1]) cylinder(r=R, h=12);
}
}