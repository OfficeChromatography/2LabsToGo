//Alu-panels

$fn=80;

//side_back();
//side_front();
//top_front();
front();
//back();
//back_on_profile();  //old
//side_back();  //2 needed
//side_front(); //2 needed
//linear_extrude(height=3) top_front(); //1 needed
//linear_extrude(height=3) front(); 1 needed
//linear_extrude(height=3) back(); 1 needed
//front_holder();

//translate([206, 93, 6]) rotate([0, 0, -90]) import("syringe-pump-variable-body.stl");

module side_back() {
    w=148;
    h=210;
    n1=h/2-6;
    n2=w/2-6;
   difference() {
       square([w, h]);
       for (i=[0:2])
        translate([6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([w-6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([6+i*n2, 6, 0]) circle(d=3.2); 
       for (i=[0:2])
        translate([6+i*n2, h-6, 0]) circle(d=3.2); 
   } 
}

module side_front() {
    w=102;
    h=210;
    n1=h/2-6;
    n2=w/2-6;
    difference() {
       square([w, h]);
       for (i=[0:2])
        translate([6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([w-6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([6+i*n2, 6, 0]) circle(d=3.2); 
       for (i=[0:2])
        translate([6+i*n2, h-6, 0]) circle(d=3.2); 
   }
}

module top_front() {
    w=215;
    h=102;
    n1=h/2-6;
    n2=w/2-6;
    difference() {
       square([w, h]);
       for (i=[0:2])
        translate([6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([w-6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([6+i*n2, 6, 0]) circle(d=3.2); 
       for (i=[0:2])
        translate([6+i*n2, h-6, 0]) circle(d=3.2);
      //holes for syringe-pump
      translate([w-36, h-28.5, 0]) circle(d=4.2);
      translate([w-36-32.15, h-28.5, 0]) circle(d=4.2);
      translate([25, h-28.5, 0]) circle(d=4);
       
       //holes for DC-plug
    /*   translate([2.75+13, 2.75+13, 0]) circle(d=3.2);
       translate([2.25+13, 40+13, 0]) circle(d=3.2);
       translate([22+13, 2.75+13, 0]) circle(d=3.2);
       translate([25-2.25+13, 40+13, 0]) circle(d=3.2); */
   }
}

module top_front_99() {
    w=215;
    h=99;
    n1=h/2-6;
    n2=w/2-6;
    difference() {
       square([w, h]);
       for (i=[0:2])
        translate([6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([w-6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([6+i*n2, 6, 0]) circle(d=3.2); 
       for (i=[0:2])
        translate([6+i*n2, h-6, 0]) circle(d=3.2);
      //holes for syringe-pump
      translate([w-36, h-20, 0]) circle(d=4.2);
      translate([w-36-32.15, h-20, 0]) circle(d=4.2);
      translate([25, h-20, 0]) circle(d=4);
   }
}
   
module front() {
    w=214;  //passt so, oder besser 214!!
    h=189;  //passt so, oder besser 189!!
    n1=h/2-6;
    n2=w/2-6;
    difference() {
       square([w, h]);
       //holes for holder
       #translate([71.5, w/3*2, 0]) circle(d=3.2); 
        
       translate([w-71.5, w/3*2, 0]) circle(d=3.2);
       
   }
}

module back() {
    w=215;
    h=190;
    n1=h/2-6;
    n2=w/2-6;
    difference() {
       square([w, h]);
       for (i=[0:2])
        #translate([6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([w-6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([6+i*n2, 6, 0]) circle(d=3.2); 
       for (i=[0:2])
        translate([6+i*n2, h-6, 0]) circle(d=3.2);
       //translate([71, w/3*2, 0]) circle(d=3.2); 
       //translate([71+72, w/3*2, 0]) circle(d=3.2); 
       
       //cutout spindle
       translate([32.5, 5.1, 0]) circle(d=8.2);
       translate([32.5-8.2/2, -1, 0]) square([8.2, 6.1]);
       
       //cutout motor cable
       translate([35+32, 3, 0]) circle(d=4);
       translate([35+32-4/2, -1, 0]) square([4, 4]);        
       //cutout screws for power adapter
       //translate([3.5, 125, 0]) circle(d=4.2);
       //translate([215-3.5, 125-46, 0]) circle(d=4.2);
   }
   //translate([51+32.5-28, 0, 0]) rotate([-90, 180, 0]) import("AS-motor-cover.stl");
}

module back_on_profile() {
    w=215+2*15;
    h=190+2*15;
    n1=h/2-6;
    n2=w/2-6;
    difference() {
       square([w, h]);
       for (i=[0:2])
        translate([6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([w-6, 6+i*n1, 0]) circle(d=3.2);
       for (i=[0:2])
        translate([6+i*n2, 6, 0]) circle(d=3.2); 
       for (i=[0:2])
        translate([6+i*n2, h-6, 0]) circle(d=3.2);
       //translate([71, w/3*2, 0]) circle(d=3.2); 
       //translate([71+72, w/3*2, 0]) circle(d=3.2); 
       //cutout spindle
       translate([w-35-15, 5.1, 0]) circle(d=8.2);
       translate([w-35-15-8.2/2, -1, 0]) square([8.2, 6.1]);
       //cutout motor cable
       translate([w-35-15-32, 3, 0]) circle(d=4);
       translate([w-35-15-32-4/2, -1, 0]) square([4, 4]);        
       //cutout screws for power adapter
       //translate([3.5+15, 125, 0]) circle(d=4.2);
       //translate([215-3.5+15, 125-46, 0]) circle(d=4.2);
   }
}

module front_holder() {
    difference() {
    union() {
    string = str("2LabsToGo");
    translate([6, 0, 0]) linear_extrude(2) text(string, size = 10, direction = "ltr", spacing = 1 );
    translate([0, -1, -3]) cube([80, 15, 3]);
    translate([4, 7.5, -12]) cylinder(d=8, h=10);
    translate([80-4, 7.5, -12]) cylinder(d=8, h=10);
    }
    translate([4, 7.5, -13]) cylinder(d=2.8, h=11);
    translate([80-4, 7.5, -13]) cylinder(d=2.8, h=11);
}
}