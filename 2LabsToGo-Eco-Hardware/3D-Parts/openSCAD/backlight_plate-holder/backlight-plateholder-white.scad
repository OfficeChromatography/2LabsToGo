//backlight plate holder, 2 LED strips

$fn=80;

plate_holder(); 
//cable_plug();
//translate([-52, 60, -3]) cable_plug();

x=128;
y=124;
h=12;
platte_x=101;
platte_y=101;
hled=1.3; //height LED
bled=8;  //width LED strips
tpx=-3.1; //deviation x PLEXIGLAS from 100 mm
tpy=-3.1; //deviation y PLEXIGLAS from 100 mm


module plate_holder() {
    difference() {
    union() {
        main_body();            
        //pressure springs
        translate([-20, -54, 4.8]) cylinder(r=2.5, h=1.8, $fn=60);
        translate([20, -54, 4.8]) cylinder(r=2.5, h=1.8, $fn=60);
        translate([-platte_x/2, -56.5, 4.8]) cube([30.5, 2, 1.8]);
        translate([platte_x/2-30.5, -56.5, 4.8]) cube([30.5, 2, 1.8]);
    }
    
    //cut to retain front or back part: select
        //keep the front part, uncomment next line
    translate([-65, -63, -7]) cube([130, 15.5, 15]);
        //keep the back part, uncomment next line
    //translate([-65, -47.5, -7]) cube([130, 110, 15]);
    }
    
//HPTLC plate for testing
    //translate([-platte_x/2, -platte_y/2-2, 4]) cube([platte_x, platte_y, 1.2]);
//LED Plexi edge illumination for testing
    //translate([-platte_x/2-tpx/2, -platte_y/2-2, -3]) cube([platte_x+tpx, platte_y, 4]); 
//LED Plexi diffusor 3 mm for testing
    //translate([-platte_x/2-tpx/2, -platte_y/2-2, 1]) cube([platte_x+tpx, platte_y, 3]); 
//LED strips for testing
    //translate([-platte_x/2-hled, -platte_y/2+3, -5.5])rotate([0, 0, 90]) led_strip();
    //translate([platte_x/2+hled, platte_y/2+2, -5.5])rotate([0, 0, -90]) led_strip();
}

module main_body() {
    difference() {
        //main body
        cube([x, y, h], center=true);
        //cutout plexi
        translate([-platte_x/2-tpx/2, -platte_y/2-2-tpy/2, -3]) cube([platte_x+tpx, platte_y+tpy, 7.2]);
        
        //cutout plate
        translate([-platte_x/2, -platte_y/2-2, 4]) cube([platte_x, platte_y, 5]); 
        //pressure springs cutout
       translate([-platte_x/2, -(platte_y/2+8), 4.5]) cube([platte_x, 10, 10]);
        
        //chambers for round magnets
        translate([60, y/2-89, -h/2+3]) cube([10, 8, 3.1], center=true);
        translate([60, y/2-31, -h/2+3]) cube([10, 8, 3.1], center=true);
        translate([-60, y/2-89, -h/2+3]) cube([10, 8, 3.1], center=true);
        translate([-60, y/2-31, -h/2+3]) cube([10, 8, 3.1], center=true);
        //holes under round magnets
        translate([55, -y/2+89+4, -h/2-1]) cylinder(r=2, h=3);
        translate([55, -y/2+31+4, -h/2-1]) cylinder(r=2, h=3);
        translate([-55, -y/2+89+4, -h/2-1]) cylinder(r=2, h=3);
        translate([-55, -y/2+31+4, -h/2-1]) cylinder(r=2, h=3);
        //positon holes: M4 screw
        distance=111;
        rand=(x-distance)/2;
        translate([x/2-rand, -y/2+77, -h/2-1]) cylinder(r=3.75, h=6);
        mirror([1,0,0]) translate([x/2-rand, -y/2+77, -h/2-1]) cylinder(r=3.75, h=6);
    //magnet cubes back part
        translate([-60, -y/2+12, -h/2+4]) cube([5.2, 5.3, 5.4], center=true);
        translate([60, -y/2+12, -h/2+4]) cube([5.2, 5.3, 5.4], center=true);
        //magnet cubes front part
        translate([-60, -y/2+17, -h/2+4]) cube([5.2, 5.3, 5.4], center=true);
        translate([60, -y/2+17, -h/2+4]) cube([5.2, 5.3, 5.4], center=true);
        //holes under magnet cubes
        translate([-60, -y/2+10, -h/2-1]) cylinder(r=2, h=3, $fn=60);
        translate([60, -y/2+10, -h/2-1]) cylinder(r=2, h=3, $fn=60);
        translate([-60, -y/2+20, -h/2-1]) cylinder(r=2, h=3, $fn=60);
        translate([60, -y/2+20, -h/2-1]) cylinder(r=2, h=3, $fn=60);
        //cutout LED strip
        translate([-platte_x/2-tpx/2-hled, -platte_y/2-2, -5.5]) cube([hled, platte_x+25, 9.7]); 
        translate([-platte_x/2-tpx/2-hled-0.5, -platte_y/2-2, -5.5]) cube([hled+0.5, 5, 9.7]); 
        translate([platte_x/2+tpx/2, -platte_y/2-2, -5.5]) cube([hled, platte_x+25, 9.7]); 
        translate([platte_x/2+tpx/2, -platte_y/2-2, -5.5]) cube([hled+0.5, 5, 9.7]); 
        //cable guide enlargement
        translate([-platte_x/2-tpx/2-hled, y/2-17, -5.5]) cube([3, 12, 9.7]); 
        translate([platte_x/2+tpx/2-(3-hled), y/2-17, -5.5]) cube([3, 12, 9.7]);
        
        //cable guide
        translate([-x/2+12, y/2-5, -3]) cube([x-21, 6, 6]);
        
        //cable support
    translate([x/2-6, y/2-22, 0]) rotate([-90, 0, 0]) cylinder(d=6.5, h=25);  
    translate([x/2-10, y/2-22, -3]) cube([5, 30, 6]);
    translate([x/2-7, y/2-22, -8]) cube([2, 25, 8]);
    }    
}

module led_strip() {
    cube([100, 0.4, bled]);
    color( "Yellow", 1.0 ) {
    for (i=[1:10])
        translate([i*9, -0.4, 2.45]) cube([3.4, hled, 3.4]);  }
}

module cable_plug() {
    cube([x-21, 2.5, 6]);
}
