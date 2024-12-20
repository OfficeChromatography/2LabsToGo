$fn=80;

//union for alu-profiles
union(){ 
difference(){
translate([9.77, 6, 12]) rotate([0, 0, 90]) cube([23.15 , 4, 13]);
//#translate([8.67, 21.38, 19]) rotate([90, 0, 90]) cylinder(d=9.50, h=5);
translate([3.87, 21.38, 19]) rotate([90, 0, 90]) cylinder(d=5.1, h=7);
}
translate([0,-13,31]) rotate([270,0,0]) difference(){
cube([19.9, 6, 25]);
translate([9.77, 9, 6]) rotate([90, 0, 0]) cylinder(d=9.50, h=5);
translate([9.77, 5, 6]) rotate([90, 0, 0]) cylinder(d=5.1, h=6);
}
translate([9.77, 6, 12]) cube([10.1, 6, 13]);
}