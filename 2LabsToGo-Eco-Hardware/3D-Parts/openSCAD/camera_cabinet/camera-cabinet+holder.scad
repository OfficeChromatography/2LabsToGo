//camera tower

$fn=60;

use <UVC_housing.scad>
//use <UVA_housing.scad>
use <UVA_housing-new.scad>

    //to be printed:
camera_tower();
//cam_top();
//UVC_filter_protect();  //2 needed
//UVA_filter_protect();  //2 needed
//holder();
//facing();
//UVA_housing();

module cam_top() {
    
    rotate([-180, 0, -90]) translate([-125, -105, 0]) import("camera_top.stl");
    string1 = str("cam-plug");
    translate ([15, -47, -3.5]) rotate([0, 180, 0])
    linear_extrude(2.0) text(string1, size = 6, direction = "ltr", spacing = 1 );
}

module camera_tower() {
difference() {
    union() {
        base_2();
        translate([0, 0, 3]) cubus_2();
        translate([34.5, 50, 0]) cube([17.5, 2, 113]);
        translate([34.5, -52, 0]) cube([17.5, 2, 113]);
        translate([-52, 50, 0]) cube([17.5, 2, 113]);
        translate([-52, -52, 0]) cube([17.5, 2, 113]);
    }
    //holes for cam top
        translate([37.5, 47.5, -10]) cylinder(d=2.7, h=20);
        translate([-30, 47.5, -10]) cylinder(d=2.7, h=20);
        translate([37.5, -47.5, -10]) cylinder(d=2.7, h=20);
        translate([-30, -47.5, -10]) cylinder(d=2.7, h=20);
    
    //UVC cutout 
    translate([-55,-50,41.5]) cube([110,100,70]);
    //UVA cutouts
    translate([-55,0,20.9]) rotate([0,18,0]) cube([20,76,17.4], center=true);
    translate([55,0,20.9]) rotate([0,-16,0]) cube([20,76,17.4], center=true);
    
    //holes for tower holder
    translate([0, 60, 113-75-7.5]) rotate([90,0,0]) cylinder(h=130, r=2.1);
    translate([28, 60, 113-75-7.5]) rotate([90,0,0]) cylinder(h=130, r=2.1);
    translate([-28, 60, 113-75-7.5]) rotate([90,0,0]) cylinder(h=130, r=2.1);
    
    //holes to screw camera-facing
    translate([41, 60, 12]) rotate([90,0,0]) cylinder(h=130, r=1.4);
    translate([41, 60, 12+81]) rotate([90,0,0]) cylinder(h=130, r=1.4);
    
    string1 = str("back");
    translate ([-52.5, 0, 1]) rotate([180, 0, 90])
    linear_extrude(2.0) text(string1, size = 8, direction = "ltr", spacing = 1 );
    }
    
    //placing UV-LED housings
    difference()  {
        union() {
            rotate([180,0,90]) translate([-52,54,-23]) UVA_housing();
            rotate([180,0,270]) translate([-52,54,-23]) UVA_housing();
            rotate([0,270,90]) translate([41,54,-52]) UVC_housing();
            rotate([0,270,270]) translate([41,54,-52]) UVC_housing();
    
    //holes for UV filter_protect
        translate([48, 32, 26]) rotate([90, 0, 90]) cylinder(d=2.8, h=12);
        translate([-58, 32, 26]) rotate([90, 0, 90]) cylinder(d=2.8, h=12);
    
        translate([48, -32, 26]) rotate([90, 0, 90]) cylinder(d=2.8, h=12);
        translate([-58, -32, 26]) rotate([90, 0, 90]) cylinder(d=2.8, h=12);
    }
    translate([54, -54, 107.5]) cube([1, 108, 5.5]);
    translate([-55, -54, 107.5]) cube([1, 108, 5.5]);
    }
}
    
module cubus() {
difference() {
    linear_extrude(height = 110, scale = 1) rectangular();
    translate([0, 0, -5])
    linear_extrude(height = 130, scale = 1) rectangular_inside();
    } 
}

module cubus_2() {
    difference() {
        translate([0, 0, 55]) cube([108, 108, 110], center=true);
        translate([0, 0, 53]) cube([104, 104, 116], center=true);
}
}
 
module base_2()  {
    difference() {
        translate([0, 0, 2]) cube([108, 108, 4], center=true);
        translate([0, 0, 3]) cube([86, 86, 8], center=true);
    }
}
    
module rectangular() {
    a = 54; //52;
    b = 54; //52;
    polygon(points=[[-a,-b],[a,-b],[a,b],[-a,b]]); 
}
module rectangular_inside() {
    a1 = 54-2; //50;
    b1 = 54-2; //50;
    polygon(points=[[-a1,-b1],[a1,-b1],[a1,b1],[-a1,b1]]); 
}
module rectangular_base() {
    x = 54;
    y = 54;
    polygon(points=[[-x,-y],[x,-y],[x,y],[-x,y]]); 
}
module rectangular_base_inside() {
    x = 43;
    y = 43;
    polygon(points=[[-x,-y],[x,-y],[x,y],[-x,y]]); 
}
module base() {
    difference() {
    linear_extrude(height = 4, scale = 1) rectangular_base();
    translate([0, 0, -2]) linear_extrude(height = 8, scale = 1) rectangular_base_inside();
    }    
}

module UVC_filter_protect() {
    difference() {
        cube([76, 8, 2]);
        translate([6, 4.5, -1]) cylinder(d=3.2, h=4);
        translate([6+64, 4.5, -1]) cylinder(d=3.2, h=4);
    }
}

module UVA_filter_protect() {
    difference() {
        cube([76, 8, 2]);
        hull() {
        translate([6, 3.5, -1]) cylinder(d=3.2, h=4);
        translate([6, 5.5, -1]) cylinder(d=3.2, h=4);
        }
        hull() {
        translate([6+64, 3.5, -1]) cylinder(d=3.2, h=4);
        translate([6+64, 5.5, -1]) cylinder(d=3.2, h=4);
    }
}
}

//camera cabinet holder
module holder() {
$fn=80;
y1=102;
y2=148;
x=215;
z=110;
b=12;
t=108;  //width camera cabinet

difference() {
    union() {
        difference() {
        cube([x, z, 10]);
        translate([8, 8, -1]) cube([x-2*8, z-2*8, 12]);
        }
        translate([92.2-t/2-10, 0, 0]) cube([10, z, 10]);
        translate([92.2+t/2, 0, 0]) cube([10, z, 10]);
        translate([92.2-t/2-8, 75, 0,]) cube([8, 15, 115+12]);
        translate([92.2+t/2, 75, 0,]) cube([8,15, 115+12]);
        translate([92.2-t/2-10, 0, 0,]) cube([10, 8, 35+12]);
        translate([92.2+t/2, 0, 0,]) cube([10, 8, 35+12]);
        #translate([38, 0, 10]) cube([10, 4, 16.5]);
        #translate([92.2+t/2-10, 0, 10]) cube([10, 4, 16.5]);
        
    }
    //holes for screws into profiles
    translate([-1, 20, 5]) rotate([0, 90, 0]) cylinder(d=5.2, h=20);
    translate([9, 20, 5]) rotate([0, 100, 0]) cylinder(d=6, h=40);
    translate([200, 20, 5]) rotate([0, 90, 0]) cylinder(d=5.2, h=20);
    translate([-1, z-20, 5]) rotate([0, 90, 0]) cylinder(d=5.2, h=20);
    translate([9, z-20, 5]) rotate([0, 100, 0]) cylinder(d=6, h=40);
    translate([200, z-20, 5]) rotate([0, 90, 0]) cylinder(d=5.2, h=20);
    
    //holes for screws camera-tower
    //the next 2 lines for camera-tower WS
    translate([-1, 75+7.5, 37+5+12]) rotate([0, 90, 0]) cylinder(d=4.2, h=220);
     translate([-1, 75+7.5, 37+5+12+28]) rotate([0, 90, 0]) cylinder(d=4.2, h=220);
    translate([-1, 75+7.5, 37+56+5+12]) rotate([0, 90, 0]) cylinder(d=4.2, h=220);
    
    //the next 2 Lines for camera-tower Lucas
    //translate([-1, 75+7.5, 40]) rotate([0, 90, 0]) cylinder(d=4.2, h=220);
    //translate([-1, 75+7.5, 110]) rotate([0, 90, 0]) cylinder(d=4.2, h=220);
    
    //cutout for plug 365
    //translate([85, z-10, -2]) cube([17, 6, 12]); 
    
   //holes for back panel
   translate([6, 95-20, -1]) cylinder(d=2.9, h=12);
   translate([215-6, 95-20, -1]) cylinder(d=2.9, h=12); 
    //cutout for cables
    //translate([34, 94, 5]) cube([5, 8, 15]);
}
//stabilizers
difference() {
    union() {
        translate([92.2-t/2-8, 45, 10,]) cube([8,30, 30]);
        translate([92.2+t/2, 45, 10,]) cube([8,30, 30]);
    }
    translate([25, 45+30/2-11.7, 10+30/2+11.6]) rotate([0, 90, 0]) cylinder(d=53.5, h=20);
    translate([25+8+108, 45+30/2-11.7, 10+30/2+11.6]) rotate([0, 90, 0]) cylinder(d=53.5, h=20);
}
}

//camera_tower_facing
module facing() {
difference() {
    union() {
        cube([113, 2, 130]);
        cube([2, 33, 130]);
        translate([111, 0, 0]) cube([2, 33, 130]);
        //translate([111, 33, 91]) cube([2, 90, 79]);
    }
    translate([-2, 29, 20]) rotate([0, 90, 0]) cylinder(d=3.2, h=120);
    translate([-2, 29, 121-20]) rotate([0, 90, 0]) cylinder(d=3.2, h=120);
    //cutout camera holder
    translate([-2, 17, 74]) cube([120, 20, 17]);
    }
}
