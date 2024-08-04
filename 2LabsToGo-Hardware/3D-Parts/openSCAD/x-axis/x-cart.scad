//x-cart

$fn=80;

difference() {
    union() {
        translate([0, 1, 0]) cube([64.5, 26, 4.5]);
        translate([20, 1, 4.5]) cube([12, 26, 12]);
        //translate([64.5-5, 28-1, 0]) cube([5, 18, 14]);
        
    }
    
    translate([64.5-20, 2, 0]) cube([20, 24, 6]);
    translate([64.5-20-44.5, 2, 0]) cube([20, 24, 6]);
    translate([30-3-1.7, 28.5, 4.5+4]) rotate([0, 0, 270]) timing_belt();
    translate([20, 14, 4.5+8]) rotate([0, 90, 0]) cylinder(d=2.7, h=14);
    //translate([20, 14, 4.5+8]) rotate([0, 90, 0]) cylinder(d=2.8, h=10);
    translate([28, 14, 4.5+8]) rotate([0, 90, 0]) cylinder(d=3.2, h=10);
    //hols for screws
    translate([64.5-22, 5.1, -1]) cylinder(d=2.7, h=10);
    translate([64.5-22, 27-4.1, -1]) cylinder(d=2.7, h=10);
    translate([64.5-22-20, 5.1, -1]) cylinder(d=2.7, h=10);
    translate([64.5-22-20, 27-4.1, -1]) cylinder(d=2.7, h=10);
    //cutout
    translate([26, 0, 8.5]) cube([8, 3, 10]);
}
translate([64.5-20, 1, 0]) bearing();
translate([64.5-20-44.5, 1, 0]) bearing();
pusher();


module bearing() {
difference() {
    cube([20, 26, 14]);
    translate([10, -1, 10]) rotate([-90, 0, 0]) cylinder(d=15, h=28);
    }
}

module timing_belt() {
difference() {
    cube([44, 1.7, 11,]);
    D=2;
    R=0.75;
    for (i=[0:16])
        translate([i*D+2.5, 1.7, -1]) cylinder(r=R, h=12);
}
}

module pusher() {
    difference() {
    translate([64.5-5, 28-1, 0]) cube([5, 18, 14]);
      translate([54.5, 26, 10]) rotate([-90, 0, 0]) cylinder(d=15, h=28);  
    }
}