//distance check x_end top

$fn=60;

difference(){
cube([20, 5, 13]);
//translate([10, -1, 13/2]) rotate([90, 0, 0]) cylinder(d=9.50, h=5);
translate([10, -1, 13/2]) rotate([-90, 0, 0]) cylinder(d=5.2, h=7);
}