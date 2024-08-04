//electronic box

x=215;
y=148;
h1=60;
$fn=80;
p=8; //Zuschlag board höher

box();
//spindle_cover();
//box_cover(); //sphere d=4.4??
//LED_label();
//LED_label_2();
//cover_hdmi();
//frame_for_label();

//box_cover_2(); //sphere d=4??
//cover_hdmi();

//rpi_cover_usb();
//screw_guide();

    //just for testing
//translate([x-2-56-2, y-2-2, 10]) rpi_cover_usb();

//color("blue", 0.6) {translate([4, 4, 10]) board();}
//translate([x-3-56, y-2-85-1-2, 10+p+10]) raspberry();
//raspberry();

    ///for RPi test
/*difference() {
    box();
    translate([-1, -1, -1]) cube([155, y+3, h1+2]);  
    translate([149, -1, 34]) cube([80, y+3, 30]); 
    translate([149, -1, -1]) cube([80, 60, h1+3]); 
    }
*/

module box() {
    p=8+10;
    difference() {
        cube([x, y, h1]);
        
        //cutout syringe pump motor cable
        translate([x-4, y-118, h1-9]) rotate([0, 90, 0]) cylinder(d=4, h=8);
        translate([x-4, y-118-0.75, h1-9]) cube([10, 1.5, 10]);
        
        //cutout inside
        translate([2, 2, 12+p]) cube([x-4, y-4, h1]);
        translate([4-0.25, 4-0.25, 2]) cube([150+0.5, 140+0.5, h1]);
        
        //cutout raspberry    
        translate([156, 2, 2]) cube([57, y-4, h1]);
        
        //cutout bottom
        translate([11, 11, -1]) cube([150-10, y-22, 15]);
        
        //cutout screw bracket e-axis
        translate([x-8, 46, -1]) cube([10, 10, 2]);

        //holes for board screws
        translate([21+4, 3+4, 2]) cylinder(d=3.8, h=10);
        translate([146.1+4, 3.5+4, 2]) cylinder(d=3.8, h=10);
        translate([3.8+4, 127.7+4, 2]) cylinder(d=3.8, h=10);
        translate([127+4, 135.8+4, 2]) cylinder(d=3.8, h=10);
        
        //holes for mounting screws
        n1=68;  
        //n2=101.5;
        pd=6.3;
        x=215;
        y2=148;
        w=x+2*pd;
        h=y2+2*pd;
        
    //holes for box mounting
        translate([6, 30, -4]) cylinder(d=2.7, h=15);
        translate([6, y2-40, -4]) cylinder(d=2.7, h=15);
        translate([x-6, y2-70, -4]) cylinder(d=2.7, h=15);
        translate([x-6, y2-20, -4]) cylinder(d=2.7, h=15);
                
        //cutout RPi USB
        translate([x-54-3, y-4, 11+p]) cube([53, 10,  17]); //muss so breit sein, USB wird benötigt!!
        
        //cutout RPi HDMI
        translate([x-4, y-73-11, 11+p-3]) cube([14, 52, 8+3]);
        
        //cutout pressure sensor cable
        translate([x-80, -2, h1-9]) cube([1, 10, 10]);
        translate([x-80+0.5, -2, h1-9]) rotate([-90, 0, 0]) cylinder(d=3, h=10);
        
        //cutout endstop cable
        translate([40, -2, h1-12]) cube([2, 10, 14]);
        translate([40+1, -2, h1-11]) rotate([-90, 0, 0]) cylinder(d=4, h=10);
        
        //cutout LED board
        translate([30+31.5, 1.6, 15-5+7.5]) cube([46, 5, 45]);
        translate([34+31.5, -1, 21-5+7.5]) cube([39, 5, 5]);
        translate([34+31.5, -1, 21+10-5+7.5]) cube([39, 5, 5]);
        
        translate([34+31.5, -1, 15+38-12-5+7.5]) cube([39, 5, 6]);
        
        //translate([34+31.5, 0.4, 15+38-12-5]) cube([39, 5, 6]);
        
        //holes to mount the LED board
        translate([30+3.5+32, -1, 15-5+36.5+7.5]) rotate([-90, 0, 0]) cylinder(d=3.4, h=8);
        translate([30+3.5+32+38.5, -1, 15-5+36.5+7.5]) rotate([-90, 0, 0]) cylinder(d=3.4, h=8);
        
        //hole for spindle
        translate([x-39.4, 51.38, -2]) cylinder(d=8, h=10); //y-value corrected WS, was 48
                
       //cutout balls
        translate([(x+4)/3, -2, h1-4]) rotate([-90, 0, 0]) cylinder(d=4.1, h=10);
        translate([2*((x+4)/3), -2, h1-4]) rotate([-90, 0, 0]) cylinder(d=4.1, h=10);
        translate([(x+4)/3, y-5, h1-4]) rotate([-90, 0, 0]) cylinder(d=4.1, h=10);
        translate([2*((x+4)/3), y-5, h1-4]) rotate([-90, 0, 0]) cylinder(d=4.1, h=10);
        translate([4, y/2, h1-4]) rotate([0, -90, 0]) cylinder(d=4.1, h=10);
        translate([x+4, y/2, h1-4]) rotate([0, -90, 0]) cylinder(d=4.1, h=10);
        
        //cutout incubator plug
        translate([83, y-3, 30-5]) cube([24.5, 8, 8+5]);
        
       //cutout power plug
        translate([144, y-4, 28+9.5]) rotate([-90, 0, 0]) cylinder(d=13.7, h=8);
        
        //cutout 12V plug
        translate([114.25, y-4, 30]) cube([11, 9, 9.5]);
        
      //cutout external plug, not needed for the newest board design, plug is at the bottom of the board
        translate([38+3.75+0.5, y-4, 30]) cube([22.5, 8, 11]);
        
        //cutout USB plug 5V
        translate([64.75, y-4, 30]) cube([14, 8, 7]);
        
        //cutout nebulizer cable
        translate([-2, y-60, 35+10]) rotate([0, 90, 0]) cylinder(d=3, h=6);
        translate([-2, y-60-0.5, 35+10]) cube([6, 1, 25]);
    }

//support for spindle cover 
difference() {
  translate([x-39.4, 51.38, 0]) cylinder(d=10, h=8);
  translate([x-39.4, 51.38, -2]) cylinder(d=8, h=12);    
}
//columns for board mounting
difference() {
    union() {
        translate([21+4, 3+4, 0]) cylinder(d=8, h=10+p);
        translate([146.1+4, 3.5+4, 0]) cylinder(d=8, h=10+p);
        translate([3.8+4, 127.7+4, 0]) cylinder(d=8, h=10+p);
        translate([127+4, 135.8+4, 0]) cylinder(d=8, h=10+p);
        
        translate([21, 0, 0]) cube([8, 7, 10+p]);
        translate([146.1, 0, 0]) cube([8, 7, 10+p]);
        translate([0, 127.7, 0]) cube([8, 8, 10+p]);
        translate([127, 135.8+4, 0]) cube([8, 7, 10+p]);
    }
       
    //holes for screws
    translate([21+4, 3+4, 2]) cylinder(d=3.8, h=10+p);
    translate([146.1+4, 3.5+4, 2]) cylinder(d=3.8, h=10+p);
    translate([3.8+4, 127.7+4, 2]) cylinder(d=3.8, h=10+p);
    translate([127+4, 135.8+4, 2]) cylinder(d=3.8, h=10+p);
    }
    //columns for box mounting
        n1=68;  
        n2=101.5;
        pd=6.3;
        x=215;
        y2=148;
        w=x+2*pd;
        h=y2+2*pd;
    
    difference() {
        //columns
        union() {
            translate([6, 30, 2]) rotate([0, 0, 45]) cylinder(d=10, h=10, $fn=4);
            translate([6, y2-40, 2]) rotate([0, 0, 45]) cylinder(d=10, h=10, $fn=4);
            translate([w-2*pd-5.5, y2-70, 2]) rotate([0, 0, 45]) cylinder(d=10, h=10, $fn=4);
            translate([w-2*pd-5.5, y2-20, 2]) rotate([0, 0, 45]) cylinder(d=10, h=10, $fn=4);
    }
    
    //holes for box mounting
    translate([6, y2-40, 2]) cylinder(d=2.7, h=15);
    translate([6, 30, 2]) cylinder(d=2.7, h=15);
    translate([x-6, y2-70, -2]) cylinder(d=2.7, h=15);  //x-6??
    translate([x-6, y2-20, -2]) cylinder(d=2.7, h=15);  //x-6??
    }
        
    //colums for raspberry pi mounting
    difference() {
    xr=x-3-56;
    yr=y-2-85;
        union() {
        translate([xr+3.5, yr+3.5-1-2, 0]) cylinder(d=6, h=10+p);
        translate([xr+3.5-4, yr+3.5-1-2-3, 0]) cube([4, 6, p+10]);
            
        translate([xr+3.5+49, yr+3.5-1-2, 0]) cylinder(d=6, h=10+p);
        translate([xr+3.5+49, yr+3.5-2-3.5+2.5-1-2, 0]) cube([5, 6, 10+p]);
        translate([xr+3.5, yr+3.5+58-1-2, 0]) cylinder(d=6, h=10+p);
        translate([xr+3.5-4, yr+3.5+58-1-2-3, 0]) cube([4, 6, p+10]);     
            
        translate([xr+3.5+49, yr+3.5+58-1-2, 0]) cylinder(d=6, h=10+p);
        translate([xr+3.5+49, yr+3.5+58-2-3.5+2.5-1-2, 0]) cube([5, 6, 10+p,]);            
        translate([xr-2, 0, 0]) cube([5, y, 7]);
        }
        //holes for screws
        translate([xr+3.5, yr+3.5-1-2, 2]) cylinder(d=2.3, h=10+p);
        translate([xr+3.5+49, yr+3.5-1-2, 2]) cylinder(d=2.3, h=10+p);
        translate([xr+3.5, yr+3.5+58-1-2, 2]) cylinder(d=2.3, h=10+p);
        translate([xr+3.5+49, yr+3.5+58-1-2, 2]) cylinder(d=2.3, h=10+p);
    }
        
    //frame for label
    translate([58.5-4-0.25, -3.4, 0+7.5]) cube([3.8, 3.4, 44]);
    translate([58.5+4+45+4.2+0.25, -3.4, 0+7.5]) cube([3.8, 3.4, 44]);
    
    translate([58.5-4-0.25, -4.4, 0+5]) cube([58+0.5+3, 3.4+1.0, 3.5]);
    //translate([58.5-4-0.25, -3.2, 0+7.5]) cube([58+0.5, 3, 1]);
    
    translate([58.5-4-0.25, -4.2-0.2, 0+7.5]) cube([6, 1, 44]);
    translate([58.5+4+45-2.5+4.5+0.25, -4.2-0.2, 0+7.5]) cube([6, 1, 44]);
    
    translate([58.5-4, -4.2-0.2, 0+7.5]) cube([58, 1, 2]);
    
    translate([x, 60, 23]) cover_hdmi();
}

module frame_for_label() {
//frame for label
    translate([58.5-4-0.25, -3.4, 0+7.5]) cube([3.8, 3.4, 44]);
    translate([58.5+4+45+4.2+0.25, -3.4, 0+7.5]) cube([3.8, 3.4, 44]);
    
    translate([58.5-4-0.25, -4.4, 0+5]) cube([58+0.5+3, 3.4+1.0, 3.5]);
    
    translate([58.5-4-0.25, -4.2-0.2, 0+7.5]) cube([6, 1, 44]);
    translate([58.5+4+45-2.5+4.5+0.25, -4.2-0.2, 0+7.5]) cube([6, 1, 44]);
    
    translate([58.5-4, -4.2-0.2, 0+7.5]) cube([58, 1, 2]);
}

module board() {
    difference() {
        cube([150, 140, 1]);
        translate([21, 3, -1]) cylinder(d=4, h=6);
        translate([3.8, 127.7, -1]) cylinder(d=4, h=6);
        translate([127, 135.8, -1]) cylinder(d=4, h=6);
        translate([146.1, 3.5, -1]) cylinder(d=4, h=6);
    }
}

module raspberry() {
    difference() {
        union() {
            translate([3, 3, 0]) cube([56-6, 85-6, 1.5]);
            hull() {
                translate([3, 3, 0]) cylinder(d=6, h=1.5);
                translate([56-3, 3, 0]) cylinder(d=6, h=1.5);
            }
            hull() {
                translate([3, 3, 0]) cylinder(d=6, h=1.5);
                translate([3, 85-3, 0]) cylinder(d=6, h=1.5);
            }
            hull() {
                translate([3, 85-3, 0]) cylinder(d=6, h=1.5);
                translate([56-3, 85-3, 0]) cylinder(d=6, h=1.5);
            }
            hull() {
                translate([56-3, 3, 0]) cylinder(d=6, h=1.5);
                translate([56-3, 85-3, 0]) cylinder(d=6, h=1.5);
            }
        }
        translate([3.5, 3.5, -2]) cylinder(d=2.75, h=18);
        translate([3.5+49, 3.5, -2]) cylinder(d=2.75, h=18);
        translate([3.5, 3.5+58, -1]) cylinder(d=2.75, h=18);
        translate([3.5+49, 3.5+58, -1]) cylinder(d=2.75, h=18);
    }
    color("yellow", 1.0) {
    translate([56-9-13/2, 85-14.5, 1.5]) cube([13, 17.5, 16]);
    translate([56-27-13/2, 85-14.5, 1.5]) cube([13, 17.5, 16]);
    translate([56-45.75-15.5/2, 85-19, 1.5]) cube([15.5, 22, 13.5]);
    translate([50.5, 3.5+7.7-8.5/2, 1.5]) cube([7, 8.5, 3.2]);
    translate([49.5, 3.5+7.7+14.8-8.5/2, 1.5]) cube([8, 6, 3.2]);
    translate([49.5, 3.5+7.7+14.8+13.5-8.5/2, 1.5]) cube([8, 6, 3.2]);
    translate([44, 3.5+7.7+14.8+13.5+14.5-6/2, 1.5]) cube([15, 6, 6]);
    }
}

module spindle_cover() {
    difference() {
    union() {
        cylinder(d=12, h=56);
        //cylinder(d=15, h=2);
    }
    translate([0, 0, -1]) cylinder(d=10.2, h=56);
    }
}

module board_mounting() {
difference() {
    union() {
    translate([2, 2, 2]) cube([150+4, 140+4, 8]);
    }
    //cutout bottom
    translate([11, 11, -1]) cube([x-11-5-56, y-22, 15]);
    //holes for screws
    translate([21+4, 3+4, 2]) cylinder(d=3.8, h=10);
    translate([146.1+4, 3.5+4, 2]) cylinder(d=3.8, h=10);
    translate([3.8+4, 127.7+4, 2]) cylinder(d=3.8, h=10);
    translate([127+4, 135.8+4, 2]) cylinder(d=3.8, h=10);
    }
}

module box_cover() {
    difference() {
    union() {
    linear_extrude(height=8)
    difference() {
        translate([-2, -2, 0]) square([x+4, y+4]);
        translate([-0.5, -0.5, 0]) square([x+1, y+1]);
    }
        
    for (i=[0:13])
        linear_extrude(height=2)
        translate([(x+4)/2-2, 10+i*10, 0]) square([x+2, 2], center=true);
    for (i=[0:20])
        linear_extrude(height=2)
        translate([10+i*10, (y+4)/2-2, 0]) square([2, y+2], center=true);
    translate([(x+4)/3, -0.5, 6]) sphere(d=3.5);
    translate([2*((x+4)/3), -0.5, 6]) sphere(d=3.5);
    translate([(x+4)/3, y+0.5, 6]) sphere(d=3.5);
    translate([2*((x+4)/3), y+0.5, 6]) sphere(d=3.5);
    translate([-0.5, y/2, 6]) sphere(d=3.5);
    translate([x+0.5, y/2, 6]) sphere(d=3.5);
}
    //holes to mount the LED board
        rotate([90, 0, 0]) translate([65.50, 8, -154]) linear_extrude(height=8) circle(d=6);
        
        rotate([90, 0, 0]) translate([104.0, 8, -154]) linear_extrude(height=8) circle(d=6);
}
    }

module box_cover_2() {
    translate([-2, -2, 0]) cube([x+4, y+4, 2]);
    linear_extrude(height=8)
    difference() {
       translate([-2, -2, 0]) square([x+4, y+4]);
        translate([-0.1, -0.1, 0]) square([x+0.2, y+0.2]);
    }
    translate([(x+4)/3, 0, 6]) sphere(d=3);
    translate([2*((x+4)/3), 0, 6]) sphere(d=3);
    translate([(x+4)/3, y, 6]) sphere(d=3);
    translate([2*((x+4)/3), y, 6]) sphere(d=3);
    translate([0, (y+4)/2, 6]) sphere(d=3);
    translate([x, (y+4)/2, 6]) sphere(d=3);
}

module cover_hdmi() {
    //goobay
    difference() {
        cube([6, 60, 16]);
        //monitor cable goobay
        translate([0, 20.52-2+5, 8]) cube([15, 14, 10], center=true); 
    }
}

module rpi_cover_usb() {
    difference() {
        union() {
           cube([56, 2, 26]);
           translate([56-37, -18, 16]) cube([37, 18, 2]);
        }
        translate([56-9-13/2, -1, -1]) cube([13, 4, 16+1]);
        translate([56-27-13/2, -1, -1]) cube([13, 4, 16+1]);
        translate([56-45.75-15.5/2, -1, -1]) cube([16, 4, 15]);
        //holes for screws
        translate([56-9+1.5-3, -1, 21.5-1.5-0.5]) rotate([-90, 0, 0]) cylinder(d=2.3, h=4); 
        translate([56-45.75+1.5-3, -1, 21.5-1.5-0.5]) rotate([-90, 0, 0]) cylinder(d=2.3, h=4); 
    }
}

module screw_guide() {
    difference() {
        cylinder(d=7, h=40);
        translate([0, 0, -2]) cylinder(d=5.6, h=45);
    }
    difference() {
        translate([0, -4.2, 0]) cube([20, 1.4, 15]);
        string1 = str("screw-");
        translate ([3, -3, 10]) rotate([90, 0, 0])
        linear_extrude(2.0) text(string1, size = 3, direction = "ltr", spacing = 1 );
        string2 = str("guide");
        translate ([3, -3, 5]) rotate([90, 0, 0])
        linear_extrude(2.0) text(string2, size = 3, direction = "ltr", spacing = 1 );
    }
}

module LED_label() {
    //frame for label
    translate([58.5, -1, 0]) cube([4, 1, 43]);
    translate([58.5+4+45, -1, 0]) cube([4, 1, 43]);
    translate([58.5, -1, 0]) cube([50, 1, 16-3-11]);
    translate([58.5, -2, 0]) cube([6.5, 1, 43]);
    translate([58.5+4+45-2.5, -2, 0]) cube([6.5, 1, 43]);
    translate([58.5, 0, 0]) cube([53, 0.8, 16]);
    translate([58.5, -2, 0]) cube([53, 1, 4.5]);
    translate([58.5, 0, 30]) cube([53, 0.8, 13]);
    translate([58.5, 0, 0]) cube([6.5, 0.8, 43]);
    translate([58.5+4+45-2.5, 0, 0]) cube([6.5, 0.8, 43]);
}

module LED_label_2() {
    //frame for label
    difference()  {
        cube([53, 43, 2.8]);
        translate([6.5, 16, 0.2]) cube([40, 14, 4]);
        
    }
    string1 = str("top");
        translate ([45, 38, 2.5]) rotate([0, 0, 0])
        linear_extrude(1.0) text(string1, size = 3, direction = "ltr", spacing = 1 );
    
        translate ([8, 31, 2.5]) rotate([0, 0, -90])
        linear_extrude(1.0) text("SP", font = "Arial", size = 3, direction = "ltr", halign = "right", spacing = 1 );
    
    translate ([15, 31, 2.5]) rotate([0, 0, -90])
        linear_extrude(1.0) text("3wV", font = "Arial", size = 3, direction = "ltr", halign = "right", spacing = 1 );
    
    translate ([15+4, 31, 2.5]) rotate([0, 0, -90])
        linear_extrude(1.0) text("DV", font = "Arial", size = 3, direction = "ltr", halign = "right", spacing = 1 );
    
    translate ([15+4+4, 31, 2.5]) rotate([0, 0, -90])
        linear_extrude(1.0) text("Pump", font = "Arial", size = 3, direction = "ltr", halign = "right", spacing = 1 );
    
    translate ([15+4+4+10, 31, 2.5]) rotate([0, 0, -90])
        linear_extrude(1.0) text("265", font = "Arial", size = 3, direction = "ltr", halign = "right", spacing = 1 );
    
    translate ([15+4+4+10+4, 31, 2.5]) rotate([0, 0, -90])
        linear_extrude(1.0) text("365", font = "Arial", size = 3, direction = "ltr", halign = "right", spacing = 1 );
        
    translate ([15+4+4+10+4+4, 31, 2.5]) rotate([0, 0, -90])
        linear_extrude(1.0) text("backL", font = "Arial", size = 3, direction = "ltr", halign = "right", spacing = 1 );
        
        translate ([8, 15, 2.5]) rotate([0, 0, -90])
        linear_extrude(1.0) text("Nebu", font = "Arial", size = 3, direction = "ltr", halign = "leftr", spacing = 1 );
        
        translate ([8+18, 15, 2.5]) rotate([0, 0, -90])
        linear_extrude(1.0) text("Fan", font = "Arial", size = 3, direction = "ltr", halign = "leftr", spacing = 1 );
        
    translate ([8+18+8.5, 15, 2.5]) rotate([0, 0, -90])
    linear_extrude(1.0) text("Incub", font = "Arial", size = 3, direction = "ltr", halign = "leftr", spacing = 1 );
    
    translate ([8+18+8.5+8, 15, 2.5]) rotate([0, 0, -90])
    linear_extrude(1.0) text("Plate", font = "Arial", size = 3, direction = "ltr", halign = "leftr", spacing = 1 );
    
}