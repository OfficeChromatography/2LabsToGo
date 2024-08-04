//UVC-LED housing

$fn=60;

UVC_housing();
//filterholder();
//UVC_filter_protect();

module UVC_housing() {
difference() {
    union() {
        UVC_module();
        rotate([90, 90, 50]) translate([-80, 0, 2]) filterholder();
    //translate([26.5, 8.4, 2]) cube([6.7, 22, 6.7]);
    
    }
    rotate([90, 270, 50]) translate([26.5, -24.5, 2]) cube([51, 22, 2]); 
    //screws for filter-protect
    translate([22, 20, 20]) rotate([90, 0, -90+50]) cylinder(d=2.7, h=20);
    translate([22, 20, 104-20]) rotate([90, 0, -90+50]) cylinder(d=2.7, h=20);
    translate([0, 10, 7.9]) rotate([0, 90, -40]) cylinder(d=2.7, h=10);
    translate([0, 10, 104-7.9]) rotate([0, 90, -40]) cylinder(d=2.7, h=10);
}    
//#rotate([90, 90, 50]) translate([-80, 0, 2]) filterholder();
}

module UVC_module() {
difference() {
    translate([0, 0, -2])
linear_extrude(height = 108, scale = 1) 
//polygon(points=[[0,0],[72,0],[16.713, 19.917]]);
    polygon(points=[[0,0],[72,0],[10, 11.92]]);
translate([1,-2,2])
linear_extrude(height = 100, scale = 1) 
polygon(points=[[0,0],[72,0],[10, 11.92]]);
    rotate ([0,0,50]) translate([2,-10,27]) cube([12,22,50]);
}
}

module filterholder() {
difference() {
translate([-24, 0, 0]) cube([104, 16, 2.8]);  //104 war 56
translate([2.5, 1, 0]) cube([51, 15, 2]);
//translate([3.75, 0, 0]) cube([48.5, 13, 8]);
translate([3.75, 2, -1]) cube([48.5, 18, 8]);
}
}

module UVC_filter_protect() {
    difference() {
        cube([76, 8, 2]);
        translate([6, 4.5, -1]) cylinder(d=3.2, h=4);
        translate([6+64, 4.5, -1]) cylinder(d=3.2, h=4);
    }
}