//vialrack holder

$fn=80;

cx=0.5;  //increase cutout (mm) in x direction: 0.2
cy=0; //increase cutout (mm) in y direction: 1.0

//rack_holder();
//cutout_vialrack();

difference() {  
    rack_holder();
//color("blue", 0.5) { translate([0, 0, 2]) cutout_vialrack(); }
    translate([0, 0, 2]) cutout_vialrack();
    //cut test
    //translate([-64, -30, -5]) cube([60, 50, 10]);
} 
//test rack
//color("yellow", 0.4) { translate([-58, -10, 2]) import("vial_rack_new_rinbot_Z-0.stl"); }
//color("yellow", 0.4) { translate([-58, -10, 2]) import("vial_rack_new_rinbot_Z-0_lower.stl"); }

module rack_holder() { 
difference() {    
    union() {
        //translate([0, 0, 3]) cube([116, 20, 6], center=true);
        translate([-1.5, 0, 3]) cube([116+3, 20+6, 6], center=true);
        
        translate([(116)/2+41/2-2, 0, 3]) cube([35+6, 32+6, 6], center=true);
        //clip
        translate([116/2+41-6+cx/2, -5, 0]) rotate([0, -0.5, 0]) cube([6, 10, 29]);          
        translate([116/2+34+5+cx/2+2, 5, 27]) rotate([90, 0, 0]) cylinder(d=4, h=10);
        
            }
    //cutout clip
    translate([116/2+34+cx/2, -10, 20+1.9]) cube([3.2, 20, 2.2]);
            
    //holes for M2.5 screws to stabilize the clip
    translate([(116)/2+34+3.5+cx/2+1.5, 0, -5]) rotate([0, -0.5, 0]) cylinder(d=2.5, h=36);
    //translate([(116)/2+34+3.5+cx/2+1.5, -3, -5]) rotate([0, -0.5, 0]) cylinder(d=2.5, h=36);
         
    //Screw holes/slits
    translate([50, -6, -3]) cylinder(d=3.5, h=8);
    //translate([52.6, -6, -3]) cylinder(d=3, h=8);
    //translate([47.5, -6-3/2, -3]) cube([5.1, 3, 8]);
    
    hull() {
    translate([-22, -6, -3]) cylinder(d=3.5, h=8);
    translate([-25, -6, -3]) cylinder(d=3.5, h=8);        
    }
    //translate([52.6-70, -6, -3]) cylinder(d=3, h=8);
    //translate([47.5-70, -6-3/2, -3]) cube([5.1, 3, 8]);
    
    translate([40, 6, -3]) cylinder(d=3.5, h=8);
    //translate([38.6, 6, -3]) cylinder(d=3, h=8);
    //translate([33.5, 6-3/2, -3]) cube([5.1, 3, 8]);
    hull() {
    translate([-34, 6, -3]) cylinder(d=3.5, h=8);
    translate([-31, 6, -3]) cylinder(d=3.5, h=8);
    }
    //translate([38.6-70, 6, -3]) cylinder(d=3, h=8);
    //translate([33.5-70, 6-3/2, -3]) cube([5.1, 3, 8]);
    }
    //test cutout clip
    //#translate([116/2+34+cx/2+1, -10, 21.9]) cube([2.2, 20, 2.2]);
}

module cutout_vialrack() {
    /*translate([0, 0, 2]) cube([116, 20+cy, 4], center=true);
    translate([116/2+41/2-3, 0, 2]) cube([35+cx, 32+cy, 4], center=true);
    translate([-116/2-5, -5.5, 0]) cube([8, 11, 2.2]);
    */
    translate([-119/2+2-0.5, -26/2+3-0.5, 0]) cube([116, 21, 5]);
    translate([119/2-2+0.65-0.5, -33/2, 0]) cube([35.5, 33, 5]);
    translate([-116/2-5, -6, 0]) cube([8, 12, 2.3]);
}
