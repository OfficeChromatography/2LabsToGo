$fn=80;

//union for alu-profiles
union(){ 
difference(){
translate([9.77, 6, 12]) rotate([0, 0, 90]) cube([23.15 , 4, 13]);
//translate([8.67, 19.38, 19]) rotate([90, 0, 90]) cylinder(d=9.50, h=5);
translate([3.87, 19.38, 19]) rotate([90, 0, 90]) cylinder(d=5.1, h=7);
}
difference(){
translate([0, -32, 0]) cube([15.9, 6, 25]);
translate([9.77, -32+6+4, 6]) rotate([90, 0, 0]) cylinder(d=9.50, h=6);
translate([9.77, -27, 6]) rotate([90, 0, 0]) cylinder(d=5.1, h=7);
}
difference(){
translate([8, -5, 12]) rotate([0, 0, 53]) cube([9.77,10, 13]);
translate([9.775, -5, 11]) cube([5, 12, 15]);
}
difference(){
translate([0, -26, 12]) cube([9.77, 32, 13]);
translate([-4, 4, 11]) rotate([0, 0, -37]) cube([5, 9, 15]);
}
}
//test
//translate([7, -26-6, 22]) cube([5, 61.15, 5]);