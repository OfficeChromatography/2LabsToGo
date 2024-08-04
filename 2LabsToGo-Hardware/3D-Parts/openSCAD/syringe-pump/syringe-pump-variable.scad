//syringe pump

$fn=100;

//syringe data
include <syringe-data/2-mL_syringe.scad>; 
//Use the above syringe data for the syringe_body! With the small ACT HSL motor, otherwise the spindle is too short. Alternatively, use a motor with a longer spindle (see line 252 ff).

//Use the following syringe-data for the syringe adapters 5 and 10 mmL
//include <syringe-data/5-mL_syringe.scad>; 
//include <syringe-data/10-mL_syringe.scad>;

d_sensor=19.7+0.6;  //diameter of pressure sensor
r_sensor=d_sensor/2;
h_sensor=5.5;  //height of pressure sensor
y_pusher=24;
y_pusher_pos=24+5; //y position of pusher when syringe is completely filled
endstop_switch=2;  //mm of the tip migrated into the endstop to be triggered
z=plunger_overhang-5;
hs=19.5+10; //height of spindle hole

//calculations, do not change!!
y_position_endstop=23-4;
y_back=y_pusher+plunger_overhang+syringe_scale-5+14-plunger_head_h/2+5;
dist=20-z-h_head; //position for syringe head cutout on syringe_holder_adapter

//echo("y_back: ", y_back, " mm");
rod=y_back+7;
echo("Rod: ", rod, " mm");
echo("y_back: ", y_back, " mm");

//select part to render and to be printed
    //syringe_body();  //to be printed
    //pusher_base();  //to be printed
    //pusher_syringe_adapter();  //to be printed
    syringe_holder_adapter_long();  //to be printed
    //clip();  //to be printed
    //plug_steel_rods();
        
//select part to render, just for viewing
//full_view_syringe_empty();
//full_view_syringe_full();
//full_view_syringe_half_full();
//motor_holder();
//translate([0, -y_back, 0]) 
//motor_holder();
//translate([8, -16, 0]) motor_holder();
//mount_on_profile();
//translate([-8, -50, 0]) pusher_base();
//translate([-8, 21, 0]) pusher_syringe_adapter(); 
//syringe_holder_base();
//syringe_holder_adapter();
//syringe_holder_adapter_long();
//translate([2, -4.8, 0]) clip();
//bracing_front();
//bracing_back();
//end_stop_tip();
//syringe_full();
//syringe_half_full();
//dist=20-(plunger_overhang-5)-h_head;
//translate([19.5, dist, 29]) syringe_empty();
//translate([0, -y_back-20+7, 0]) syringe_holder();
//translate([19.5, -(syringe_length-plunger_overhang-6), 19+10]) syringe_empty();
//translate([17-8, 7, 9]) rotate([90, 0, 0]) cylinder(d=6.2, h=93);

module syringe_body() {
    translate([0, -7, 0]) motor_holder();
    translate([0, -y_back-20+7, 0]) syringe_holder_base();
    mount_on_profile();
    bracing_back();
    translate([44, 0, 21]) bracing_front();
  
   //Test rod
    //#translate([17-8, 7, 9]) rotate([90, 0, 0]) cylinder(d=6, h=y_back+7); 
    //#translate([38-8, 7, 9]) rotate([90, 0, 0]) cylinder(d=6, rod);
}

module full_view_syringe_full(){
    syringe_body();
    translate([0, -y_back-20+7, 0]) syringe_holder_adapter_long();
    translate([-8, -y_back+7+syringe_scale, 0]) pusher_base();
    translate([-8, -y_back+7+syringe_scale, 0]) pusher_syringe_adapter();
    translate([2, -y_back-20+7+dist, 0]) clip();
    translate([19.5, -y_back-20+7+dist, 19+10]) syringe_full();
}

module full_view_syringe_half_full(){    
    color("grey", 1.0) {
    syringe_body();
    translate([0, -y_back-20+7, 0]) syringe_holder_adapter_long();
    translate([-8, -y_back+7+syringe_scale/2, 0]) pusher_base(); 
    translate([-8, -y_back+7+syringe_scale/2, 0]) pusher_syringe_adapter();
    translate([2, -y_back-20+7+dist, 0]) clip(); }
    //color("white", 0.5) {
    //translate([19.5, -y_back-20+7+dist, 19+10]) syringe_half_full(); }
}

module full_view_syringe_empty(){
    syringe_body();
    translate([0, -y_back-20+7, 0]) syringe_holder_adapter_long();
    translate([-8, -y_back+7, 0]) pusher_base();  
    translate([-8, -y_back+7, 0]) pusher_syringe_adapter(); 
    translate([2, -y_back-20+7+dist, 0]) clip();
    translate([19.5, -y_back-20+7+dist, 19+10]) syringe_empty();
    //test plunger
    //#translate([12, -y_back, 35]) cube([5, plunger_overhang, 5]);
}

module motor_holder() {
    difference() {
    cube([39, 10+4, 39+10]);
    //holes for motor screws Mx10
    translate([4, -2, 4+10]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24);
    translate([4, -2, 4+10]) rotate([-90, 0, 0]) cylinder(d=5.7, h=9);
    translate([4+31, -2, 4+10]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24); 
    translate([4+31, -2, 4+10]) rotate([-90, 0, 0]) cylinder(d=5.7, h=9);
    translate([4, -2, 4+10+31]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24);
    translate([4, -2, 4+10+31]) rotate([-90, 0, 0]) cylinder(d=5.7, h=9);
    translate([4+31, -2, 4+10+31]) rotate([-90, 0, 0]) cylinder(r=1.6, h=24);
    translate([4+31, -2, 4+10+31]) rotate([-90, 0, 0]) cylinder(d=5.7, h=9);
    //hole for spindle
    translate([19.5, -2, hs]) rotate([-90, 0, 0]) cylinder(d=7, h=24);
    //hole for motor
    translate([19.5, 7.5+4, hs]) rotate([-90, 0, 0]) cylinder(d=22.5, h=5);
    //holes for alu rod 6 mm
    translate([17-8, 30, 9]) rotate([90, 0, 0]) cylinder(d=6.3, h=50);
    translate([38-8, 30, 9]) rotate([90, 0, 0]) cylinder(d=6.2, h=50);
   }
}

module mount_on_profile() {
    //mounting on top plate
    difference() {
        union() {
        translate([8, -y_back-13, -6]) cube([23, y_back+20, 5.7]);
        translate([0, -y_back-13, -6]) cube([48, 20, 6]);
        translate([0, -7, -6]) cube([39, 14, 6]); 
        }
    //holes for srews
    translate([19.5, -7-20, -8]) cylinder(d=4.2, h=10);
    translate([19.5, -7-20, -4]) cylinder(d=9, h=10);
    translate([19.5, -y_back-13+40, -8]) cylinder(d=4.2, h=10);
    translate([19.5, -y_back-13+40, -4]) cylinder(d=9, h=10);    
    }
}

module syringe_holder_base() {
    difference () {
        union() {
        translate([0, 0, 0]) cube([39, 20, 19+10]);
        translate([0, 0, 19+10]) cube([(39-d1)/2, 20, d1/2]);
        translate([0, -9, 19+8-r1]) cube([39, 10, 7.5]);
        //end stop housing
        translate([36, 6, 0]) cube([12, 14, 40]);
        }
    //end stop cutout
    translate([39, 8, 2]) cube([10, 14, 34]);
    translate([39, 4, 9]) cube([10, 14, 13]);
    translate([39, 4, 30]) cube([10, 14, 6]);
    translate([39+5, 4, 6]) rotate([-90, 0, 0]) cylinder(d=3.6, h=10);
    translate([39+5, 4, 25]) rotate([-90, 0, 0]) cylinder(d=3.6, h=10);
        
    //holes for steel rod 6 mm
    /*translate([17-8, 30, 9]) rotate([90, 0, 0]) cylinder(d=6.2, h=17);  //7 mm tief
    translate([38-8, 30, 9]) rotate([90, 0, 0]) cylinder(d=6.2, h=17); */
    //Loch durchgehend?
    translate([17-8, 30, 9]) rotate([90, 0, 0]) cylinder(d=6.2, h=35);  //7 mm tief
    translate([38-8, 30, 9]) rotate([90, 0, 0]) cylinder(d=6.2, h=35);
        
    //cutout for syringe holder adapter
    translate([-5, -10, 19+8-r1]) cube([36+5, 35, 25]);
    //cutout for connector
    translate([5, 4, 10]) cube([30, 6, 15]);
    //screw holes for syringe adapter mounting
    translate([5, 16, 0]) cylinder(r=1.4, h=30);
    translate([33.5, 16, 0]) cylinder(r=1.4, h=30);
    //cutout front
    translate([-5, -15, -5]) cube([50, 15, 40]);
    
    //screw hole for plug
    translate([17-8+10.5, -1, 9]) rotate([-90, 0, 0]) cylinder(d=2.7, h=10);
    }
    //test overhang
    //translate([19.5, 20-z, 19+10]) rotate([-90, 0, 0]) cylinder(d=plunger_d, h=plunger_overhang, $fn=80);
}

module syringe_holder_adapter() {
    difference() {
        union() {
            translate([0, -10, 20]) cube([36, 10, 9.5]);
            translate([0, 0, 20]) cube([36, 20, 9.5]);
            translate([0, 0, 20+9.5]) cube([(19.5-r1), 20, r1]);
            //connector
    translate([5.2, 4.2, 10]) cube([29.6, 5.6, 15]);
        }
        //syringe cutout
    translate([19.5, -30, hs]) rotate([-90, 0, 0]) cylinder(d=d1, h=60);
        //syringe head cutout
    translate([19.5, 20-(plunger_overhang-5)-h_head, hs]) rotate([-90, 0, 0]) cylinder(r=r_head, h=h_head);
    //syringe flange cutout
    translate([19.5, 20-(plunger_overhang-5)-h_head-h_flange, hs]) rotate([-90, 0, 0]) cylinder(r=r_flange, h=h_flange);
    //cutout srew for clip
    translate([6.75, 20-(plunger_overhang-5)-h_head-5.2, 19+8]) cylinder(d=2.9, h=15);
    //screw holes for mounting
    translate([5, 16, 10]) cylinder(r=1.6, h=30);
    translate([33.5, 16, 10]) cylinder(r=1.6, h=30);
    //Absenkung
    translate([5, 16, 37.5-8]) cylinder(r=3, h=10);
    }
}

module syringe_holder_adapter_long() {
    difference() {
        union() {
            translate([0, -25, 20]) cube([36, 25, 9.5]);
            translate([0, 0, 20]) cube([36, 20, 9.5]);
            translate([0, 0, 20+9.5]) cube([(19.5-r1), 20, r1]);
            //connector
    translate([5.2, 4.2, 15]) cube([29.6, 5.6, 9]);
        }
        //syringe cutout
    translate([19.5, -30, hs]) rotate([-90, 0, 0]) cylinder(d=d1, h=60);
        //syringe head cutout
    translate([19.5, 20-(plunger_overhang-5)-h_head, hs]) rotate([-90, 0, 0]) cylinder(r=r_head, h=h_head);
    translate([19.5-15.5, 20-(plunger_overhang-5)-h_head, hs]) cube([r_head, h_head, 20]);
    //syringe flange cutout
    translate([19.5, 20-(plunger_overhang-5)-h_head-h_flange, hs]) rotate([-90, 0, 0]) cylinder(r=r_flange, h=h_flange);
    translate([19.5-r_flange, 20-(plunger_overhang-5)-h_head-h_flange, hs]) cube([d_flange, h_flange, 20]);
    //cutout screw for clip
    translate([6.75, 20-(plunger_overhang-5)-h_head-5.2, 19+8]) cylinder(d=2.8, h=15);
    //screw holes for mounting
    translate([5, 16, 10]) cylinder(r=1.6, h=30);
    translate([33.5, 16, 10]) cylinder(r=1.6, h=30);
    translate([5, 16, 37.5-8]) cylinder(r=3, h=10);
    }
}

module clip() { //clip to fix the syringe
    difference() {
        union() {
    translate([0, -15, 19+10+r1]) cube([38-13.5, 15, 5]);
    translate([38-13.5, -7.5, 19+10+r1]) cylinder(d=15, h=5, $fn=80);
        }
    translate([4.75, -5, 19+10]) cylinder(r=1.6, h=15);
    }
}

module pusher_base() {
    difference() {
        union() {
            translate([8, 0, 0]) cube([39, y_pusher, 38]);
            translate([19.5+8, 22-h_spindle_head+(h_spindle_head/2), 38])  cylinder(d=8, h=5);
            //end stop tip
            translate([48, y_position_endstop, 13.5]) end_stop_tip();
        }
        //pressure sensor cutout
        translate([19.5+8, 5+plunger_head_h-1, hs]) rotate([-90, 0, 0]) cylinder(r=r_sensor, h=h_sensor+1);
        translate([19.5+8-r_sensor, 5+plunger_head_h-1, hs]) cube([2*r_sensor, h_sensor+1, 25]);
        
    //select the motor
        //spindle head cutout motor ACT 16HSL3404
        r_spindle_head=2+0.1;
        h_spindle_head=6.2;
        d_spindle=5+0.2;
        r_spindle=d_spindle/2;
   
/*        //spindle head cutout motor STEPPERONLINE 17N19S1684AF-200RS
        r_spindle_head=(6.35+0.2)/2;
        h_spindle_head=6.2;
        d_spindle=6.35+0.2;
        r_spindle=d_spindle/2;
*/
        //spindle head cutout motor nanotec LA421S07-B-TJCA
/*        d_spindle_head=6.0+0.2;
        r_spindle_head=d_spindle_head/2
        h_spindle_head=6.0;
        d_spindle=6+0.2;
        r_spindle=d_spindle/2;
*/
     //spindle cutout
    translate([19.5+8, 22-h_spindle_head-1, hs]) rotate([-90, 0, 0]) cylinder(r=r_spindle_head,  h=h_spindle_head);
    translate([19.5+8, 22-2, hs]) rotate([-90, 0, 0]) cylinder(r=r_spindle, h=5);

    //cutout for screw to fix the spindle
    translate([19.5+8, 22-h_spindle_head+(h_spindle_head/2), hs])  cylinder(d=3.6, h=15);
    //cutout for syringe adapter
    translate([0, -1, 19.15]) cube([50, 5+plunger_head_h+1, 30]);
    //cutout for syringe head adapter
    translate([15-0.2, 2.5-0.2, 15]) cube([25+0.4, 3+0.2, 10]);
    translate([11, 17, 20]) cylinder(r=1.4, h=20);
    translate([44, 17, 20]) cylinder(r=1.4, h=20);
    //cutouts 6-mm bearings (Igus MFM-0608-08 or DOLD)
    translate([17, 30, 9]) rotate([90, 0, 0]) cylinder(d=8.1, h=50);
    translate([38, 30, 9]) rotate([90, 0, 0]) cylinder(d=8.1, h=50);
    
    translate([17, 1.2, 9]) rotate([90, 0, 0]) cylinder(d=12, h=5);
    translate([38, 1.2, 9]) rotate([90, 0, 0]) cylinder(d=12, h=5);

    translate([17, y_pusher+5, 9]) rotate([90, 0, 0]) cylinder(d=12, h=5+1.2);
    translate([38, y_pusher+5, 9]) rotate([90, 0, 0]) cylinder(d=12, h=5+1.2);
    //central cutout for screws
    translate([8+39/2-4, -2, -2]) cube([8, 40, 7]);
    
    //cutout bottom 0.2 mm
    translate([0, -2, -1]) cube([50, 35, 1.2]);
    //cut left 0.2 mm
    translate([7, -2, -1]) cube([1.2, 35, 40]);
    //cut right 0.2 mm
    translate([8+39-0.2, -1, 19.15]) cube([3, 35, 40]);
    }
    //Test tip
    //translate([40, -2, 0]) cube([8, 2, 20]);
}

module pusher_syringe_adapter() {
    difference() {
        union() {
            translate([15.15, 2.65, 15]) cube([24.7, 2.7, 6]);
            translate([8, 0, 19.15]) cube([39, 5+plunger_head_h, 18.85]);
            translate([8, 0, 38]) cube([7, 22, 3]);
            translate([40, 0, 38]) cube([7, 22, 3]);
            }
     //syringe plunger cutout
        translate([19.5+8, -10, hs]) rotate([-90, 0, 0]) cylinder(r=plunger_r, h=20, $fn=80);
        translate([19.5+8-plunger_r, 0, hs]) cube([plunger_r*2, 5, 20]);
        //plunger head cutout
        translate([19.5+8, 5, hs]) rotate([-90, 0, 0]) cylinder(r=plunger_head_r, h=plunger_head_h+1, $fn=80);
        translate([19.5+8-plunger_head_r, 5, hs]) cube([plunger_head_r*2, plunger_head_h, 20]); 
    translate([11.5, 17, 30]) cylinder(r=1.5, h=12);
    translate([43.5, 17, 30]) cylinder(r=1.5, h=12);
    }
}

module syringe_full() {
    translate([0, -syringe_length, 0]) rotate([-90, 0, 0]) cylinder(r=r1, h=syringe_length);
    translate([0, -syringe_length-8, 0]) rotate([-90, 0, 0]) cylinder(r=r1-1, h=syringe_length);
    translate([0, 0, 0]) rotate([-90, 0, 0]) cylinder(r=r_head, h=h_head);
    translate([0, h_head, 0]) rotate([-90, 0, 0]) cylinder(r=plunger_r, h=syringe_scale+plunger_overhang);
    translate([0, syringe_scale+plunger_overhang+h_head, 0]) rotate([-90, 0, 0]) cylinder(r=plunger_head_r, h=plunger_head_h);
    //test plunger
    //translate([0, h_head, 7]) cube([5, syringe_scale+plunger_overhang, 5]);
}

module syringe_half_full() {
    translate([0, -syringe_length, 0]) rotate([-90, 0, 0]) cylinder(r=r1, h=syringe_length);
    translate([0, -syringe_length-8, 0]) rotate([-90, 0, 0]) cylinder(r=r1-1, h=syringe_length);
    translate([0, 0, 0]) rotate([-90, 0, 0]) cylinder(r=r_head, h=h_head);
    translate([0, h_head, 0]) rotate([-90, 0, 0]) cylinder(r=plunger_r, h=syringe_scale/2+plunger_overhang);
    translate([0, syringe_scale/2+plunger_overhang+h_head, 0]) rotate([-90, 0, 0]) cylinder(r=plunger_head_r, h=plunger_head_h);
    //test plunger
    //translate([0, h_head, 7]) cube([5, syringe_scale/2+plunger_overhang, 5]);
}

module syringe_empty() {
    translate([0, -syringe_length, 0]) rotate([-90, 0, 0]) cylinder(r=r1, h=syringe_length);
    translate([0, -syringe_length-8, 0]) rotate([-90, 0, 0]) cylinder(r=r1-1, h=syringe_length);
    translate([0, 0, 0]) rotate([-90, 0, 0]) cylinder(r=r_head, h=h_head);
    translate([0, h_head, 0]) rotate([-90, 0, 0]) cylinder(r=plunger_r, h=plunger_overhang+plunger_head_h);
    translate([0, plunger_overhang+h_head, 0]) rotate([-90, 0, 0]) cylinder(r=plunger_head_r, h=plunger_head_h);
    //test plunger
    //translate([0, h_head, 7]) cube([5, plunger_overhang, 5]);
}

module end_stop_tip() {
    difference() {
        union() {
        translate([-6, 5, 0]) rotate([0, 0, -90]) cube ([18, 14.5, 4.0]);
        translate([0, -2, 0]) rotate([0, 0, -90])
    cube([20.0, 7.5, 4.0]);
        }
    translate([-1, -12, 4]) rotate([0, 8, -90])
cube ([11, 10, 2.0]);
    translate([-1, -12, -2]) rotate([0, -8, -90])
cube ([11.0, 10, 2.0]);
    }
}

module bracing_back() {
    difference() {
    translate([-6, -y_back-13, 15]) cube([6, y_back+7+13, 10]);
    //translate([-0.2, -y_back+7, 14]) cube([1.2, y_back-14, 16]);
    }
//Test
//translate([-8, -121.5, 0]) cube([4, 130, 10]);
}

module bracing_front() {
    translate([-5, -y_back-14+7, 18]) cube([9, y_back+14, 10]);
    translate([-8, -y_back-14+7, 18]) cube([12, 14, 10]);
    
//Test
//translate([-8, -121.5, 0]) cube([4, 130, 10]);
}

module plug_steel_rods() {
    difference() {
            union() {
    translate([0, 0, -6]) cube([39, 3, 21+6]);
    translate([17-8, 0, 9]) rotate([90, 0, 0]) cylinder(d=6.3, h=12);  //7 mm tief
    translate([38-8, 0, 9]) rotate([90, 0, 0]) cylinder(d=6.3, h=12);
            }
            translate([17-8+10.5, -1, 9]) rotate([-90, 0, 0]) cylinder(d=3.2, h=10);
        }
}