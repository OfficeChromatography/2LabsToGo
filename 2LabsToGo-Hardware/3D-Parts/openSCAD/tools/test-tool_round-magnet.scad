//round magnet test
$fn=100;

difference() {
    union() {
cylinder(d=7.6, h=3);
translate([0, -3.8, 0]) cube([30, 7.6, 3]);   
    }
    translate([4, -5, 2.6]) cube([1, 10, 2]);
}