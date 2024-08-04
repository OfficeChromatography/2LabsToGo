//cable guide top left
$fn=60;
difference() {
    union() {
        cube([20, 10, 19]);
        translate([-15, 0, 0]) cube([15, 20, 6]); 
    }
    //translate([-2, 2, 2]) cube([20, 16, 16]); 
    translate([0, -1, 0]) rotate([0, 45, 0]) cube([30, 30, 30]);
    translate([10, -2, 11]) rotate([-90, 0, 0]) cylinder(d=10, h=24);
    translate([-7.5, 10, -2]) cylinder(d=5.2, h=20);
    translate([-7.5, 10, 6-2]) cylinder(d=9.5, h=3.5);
    //cut
    translate([18, -1, 0]) cube([5, 22, 22]);
    /*string1 = str("cable");
        translate ([10, 0, 19]) rotate([0, 0, 90])
        linear_extrude(2.0) text(string1, size = 6, direction = "ltr", spacing = 1 ); */  
}
