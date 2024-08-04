//LED housing UVA top

$fn=60;


UVA_housing();
//translate([0, 0, -11]) UVA_support();
//filterholder();
//UVA_filter_protect();




module UVA_housing() {
difference() {
union() {
    translate([-2,-8.38,14.54]) 
    cube([108,10,5]);
    rotate ([72,0,0]) translate([-2, 0, 0]) cube([108,16,14]); 
    translate([-2, 0.8, -8]) rotate([72,0,0])
    cube([108, 8, 17.24]);
    //rotate([18, 180, 0]) translate([-80-24, -18, -0.1]) filterholder();
    //rotate([18, 180, 0]) translate([-80-24, -5, -2.52]) cube([104, 13.8, 3]);
    
    }
    
    translate([14,2,2]) rotate([72,0,0]) 
    cube([76,12,14]);
    translate([28, 4, 1.4]) rotate([162,0,0]) 
    cube ([48,18,13]);
    translate([-3, 0, -8]) cube([110, 5, 28]);
    translate([26.5,3,-7.7]) rotate([72,0,0]) cube([51,9,25]);
    //holes for filter_protect
    translate([20, 5, -4]) rotate([90-18, 0, 0]) cylinder(d=2.8, h=10);
    translate([104-20, 5, -4]) rotate([90-18, 0, 0]) cylinder(d=2.8, h=10); 
    
    
    }
    difference() {
        union() {
            rotate([18, 180, 0]) translate([-80-24, -18, -0.1]) filterholder();
            rotate([18, 180, 0]) translate([-106, -5, -2.52]) cube([108, 13.8, 3]);
        }
    translate([26.5, -2, -5]) rotate([72, 0, 0]) cube([51, 10, 15]);
    translate([-3, 8.1, -15]) cube([110, 5, 28]);
        
        //holes for LED board
    translate([8, 0.5, -9]) rotate([-23, 0, 0]) cylinder(d=2.7, h=20);
    translate([104-8, 0.5, -9]) rotate([-23, 0, 0]) cylinder(d=2.7, h=20);
    }
    //translate([0, 0, -7.8]) cube([4, 4, 27.4]);
}

//Support for UVA board
module UVA_support() {
difference() {
    rotate([0,90,0]) translate([-2.65,0,0])
linear_extrude(height = 104, scale = 1) 
//polygon(points=[[0,0],[10.5,0],[6, 14.409]]);
polygon(points=[[0,0],[20,0],[4, 9.6]]);
    rotate([0,90,0]) translate([-3, 0, 14])
    cube([30,30,76]);
    }
    /*translate([14, 2.2, -8]) cube([3, 2, 9]);
    translate([14, 0, -10]) cube([3, 4.2, 2]);
    translate([88, 2.2, -8]) cube([3, 2, 9]);
    translate([88, 0, -10]) cube([3, 4.2, 2]);
    //test
    color("black", 0.6) {translate([14, 0, -8]) cube([76, 2, 10]); }  */
}

/*module filterholder() {
difference() {
cube([56, 26, 7.5]);
translate([2.5, 1, -1]) cube([51, 26, 7.5]);
#translate([4, -1, -1]) cube([48, 28, 10]);
translate([-1, 23.5, 0]) rotate([-18.2, 0, 0]) cube([60, 3, 9.5]); 
}
} */

module filterholder() {
    difference() {
        translate([-2, 0, 0]) cube([108, 29, 7.5]);
        translate([2.5+24, 2, -2.5]) cube([51, 28, 9]);
        translate([4+24+0.5, -1, -1]) cube([47, 30, 10]);
        translate([-3, 26.5, 0]) rotate([-18.2, 0, 0]) cube([110, 3, 9.5]); 
        //holes for filter_protect
    translate([20, 30, 3]) rotate([90-18, 0, 0]) cylinder(d=2.8, h=10);
    translate([104-20, 30, 3]) rotate([90-18, 0, 0]) cylinder(d=2.8, h=10); 
}
}

module UVA_filter_protect() {
    difference() {
        cube([76, 10, 2]);
        translate([6, 5, -1]) cylinder(d=3.2, h=4);
        translate([6+64, 5, -1]) cylinder(d=3.2, h=4);
    }
}