//shaker+hood
$fn=80;

use <threads.scad>

x=60.0;   //war 60.05??
y=67;
y2=y-7;
h1=69; //height case
h2=62; //lowering cover

case(); //preview not possible due to thread, just render
//translate([0, 0, 5]) cover();
//cover();
//motor_adapter();
//platform_support();
//excenter();  //2 needed
//burling(); //3 needed
//board_holder();
//heated_hood();
//heated_hood_cover();
//heated_hood_cable_support();
//platform(); //30 mm in height for hood!!
//washer();

module washer() {
difference() {
    cylinder(d=7, h=3);
    translate([0, 0, -1]) cylinder(d=3.2, h=5);
}    
}

module board_holder() {
    //Steuerplatine
    difference() {
        //cutout board
        union() {
        translate([-17, 20, 15]) cube([18, 53, 22]); 
        translate([-8.5, 20, 15+22]) cube([9.5, 53, 24]);
        
        //frame for mounting
        translate([-1, 20-6, 15-6]) cube([2, 53+12, 51+6]);
        }
           
     translate([-15, 22-0.25, 15+2-0.25]) cube([18, 49.5, 19.25]);  
     translate([-6.5, 22-0.25, 15+2+19.25-1]) cube([9.5, 49.5, 21.25+1.5]);
        
        //extra cutout board
        //translate([-2, 22-0.45, 15+2-0.45]) cube([9.5, 49.5+0.4, 42.4]);
        
        //LCD cutout
        translate([-10, 22+13.5-1-0.8+1, 59-10-0.5-1.1-0.3]) cube([20, 24, 11]);
        
        //holes for buttons
        translate([-10, 22+13, 59-19]) rotate([0, 90, 0]) cylinder(d=4.5, h=10);
        translate([-10, 22+13+11, 59-19]) rotate([0, 90, 0]) cylinder(d=4.5, h=10);
       translate([-10, 22+13+11+11, 59-19]) rotate([0, 90, 0]) cylinder(d=4.5, h=10);
        
        //cutout bottom, cable connections
        translate([-8, 22+8, 13]) cube([10, 20, 10]);
        
        //holes for mounting, mounting from outside, M3x8?
        translate([-5, 20-2.5, 20]) rotate([0, 90, 0]) cylinder(d=2.7, h=10);
         translate([-5, 20-2.5, 20+30]) rotate([0, 90, 0]) cylinder(d=2.7, h=10);
        translate([-5, 79-3.5, 20]) rotate([0, 90, 0]) cylinder(d=2.7, h=10);
        translate([-5, 79-3.5, 20+30]) rotate([0, 90, 0]) cylinder(d=2.7, h=10);        
        
        //labels
        string1 = str("SET");
    translate ([-7, 71, 39]) rotate([90, 0, -90])
    linear_extrude(2.0) text(string1, size = 4, direction = "ltr", spacing = 1 );
        string2 = str("+");
    translate ([-7, 53, 39]) rotate([90, 0, -90])
    linear_extrude(2.0) text(string2, size = 5, direction = "ltr", spacing = 1 );
        string3 = str("-");
    translate ([-7, 41.5, 38.5]) rotate([90, 0, -90])
    linear_extrude(2.0) text(string3, size = 7, direction = "ltr", spacing = 1 );
    }
    //columns for board mounting
    difference()  {
    union() {
        translate([-17, 22-0.25, 15+2-0.25]) cube([18-1.5-3.5+2, 7, 8]); 
        translate([-17, 22+49-7+0.25, 15+2-0.25]) cube([18-1.5-3.5+2, 7, 8]); 
        translate([-8.5, 22-0.25, 59-8+0.25]) cube([6, 7, 8]); 
        translate([-8.5, 22+49-7+0.25, 59-8+0.25]) cube([6, 7, 8]); 
    }
    
    //holes for board mounting
        translate([-13, 22+3.9, 15+2+4]) rotate([0, 90, 0]) cylinder(d=2.7, h=20); 
        translate([-13, 22+3.9+41.1, 15+2+4.45]) rotate([0, 90, 0]) cylinder(d=2.7, h=20);  
        translate([-6.5, 22+3.9, 15+2+4+32.2+0.7]) rotate([0, 90, 0]) cylinder(d=2.7, h=20);  
        translate([-6.5, 22+3.9+41.1, 15+2+4+32.2+0.7]) rotate([0, 90, 0]) cylinder(d=2.7, h=20);  
}
//test board
//translate([-13, 22, 15+2]) board();
}

module thread() {
    metric_thread (diameter=16.5, pitch=1.5, length=26);
}

module platform() {
    difference() {
    hull() {
        translate([4, 4, 0]) cylinder(d=8, h=30);
        translate([120-4, 4, 0]) cylinder(d=8, h=30);
        translate([4, 100-4, 0]) cylinder(d=8, h=30);
        translate([120-4, 100-4, 0]) cylinder(d=8, h=30);
    }
    hull() {
        translate([4+3, 4+3, 4]) cylinder(d=8, h=30);
        translate([120-4-3, 4+3, 4]) cylinder(d=8, h=30);
        translate([4+3, 100-4-3, 4]) cylinder(d=8, h=30);
        translate([120-4-3, 100-4-3, 4]) cylinder(d=8, h=30);
    }
   
    //cutout screws
    translate([60, 25, -2]) cylinder(d=3.2, h=10);
    translate([60-18.75, 25+25.5, -2]) cylinder(d=3.2, h=10);
    translate([60+18.75, 25+25.5, -2]) cylinder(d=3.2, h=10);
    translate([60, 25, 1.5]) cylinder(d=6, h=4);
    translate([60-18.75, 25+25.5, 1.5]) cylinder(d=6, h=4);
    translate([60+18.75, 25+25.5, 1.5]) cylinder(d=6, h=4);
}
difference() {
    translate ([3, 3, 27]) cube([3, 95, 3]);
    //translate([4, 10, 45-19])  cylinder(d=4, h=6);
    translate([3.5, 20, 45-19])  cylinder(d=3, h=6);
    translate([3.5, 30, 45-19])  cylinder(d=3, h=6);
    translate([3.5, 40, 45-19])  cylinder(d=3, h=6);
    translate([3.5, 50, 45-19])  cylinder(d=3, h=6);
    translate([3.5, 60, 45-19])  cylinder(d=3, h=6);
    translate([3.5, 70, 45-19])  cylinder(d=3, h=6);
    translate([3.5, 80, 45-19])  cylinder(d=3, h=6);
    }
difference() {
    translate ([114, 3, 27]) cube([3, 95, 3]);
    translate([116.5, 20, 45-19])  cylinder(d=3, h=6);
    translate([116.5, 30, 45-19])  cylinder(d=3, h=6);
    translate([116.5, 40, 45-19])  cylinder(d=3, h=6);
    translate([116.5, 50, 45-19])  cylinder(d=3, h=6);
    translate([116.5, 60, 45-19])  cylinder(d=3, h=6);
    translate([116.5, 70, 45-19])  cylinder(d=3, h=6);
    translate([116.5, 80, 45-19])  cylinder(d=3, h=6);
    }
}

module case(){
    difference() {
    union() {
        base();
        translate([x, y-7, 0]) cylinder(d=44, h=63);
        translate([x, y-7, 0]) cylinder(d=60, h=10);
        translate([110, 50, 30]) rotate([0, 90, 0]) cylinder (d=20, h=10);
    }
        translate([x, y-7, -1]) cylinder(d=38, h=60);
    //holes for motor screws
    translate([x+7.75, y2+13.42339, 50]) cylinder(d=3.5, h=20);
    translate([x-7.75, y2+13.42339, 50]) cylinder(d=3.5, h=20);
    translate([x+7.75, y2-13.42339, 50]) cylinder(d=3.5, h=20);
    translate([x-7.75, y2-13.42339, 50]) cylinder(d=3.5, h=20);
    translate([x+15.5, y2, 50]) cylinder(d=3.5, h=20);
    translate([x-15.5, y2, 50]) cylinder(d=3.5, h=20);
    //cutout motor cable
    translate([34, 77, 3]) cube([50, 14, 25]);
    translate([60, 81, -1]) cylinder(d=12, h=10);
    
    //cutout motor axle
    translate([x, y, 50]) cylinder(d=13, h=20);
        
    //12 V plug
    translate([95, 110, 20]) rotate([90, 0, 0]) cylinder(d=8.3, h=30);
    translate([95, 100-2, 20]) rotate([90, 0, 0]) cylinder(d=12, h=10);
    
    //cutout switch
    translate([90, -10, 10]) cube([13, 20, 20.5]);
    string1 = str("Mini-Shaker");
    //name
    translate ([20, 1.5, 20]) rotate([90, 0, 0])
    linear_extrude(3.0) text(string1, size = 8, direction = "ltr", spacing = 1 );
    
    //cutout 5-pin receptacle
    translate([100, 50, 30]) rotate([0, 90, 0]) thread(); 
    //translate([100, 50, 30]) rotate([0, 90, 0]) cylinder (d=15.5, h=25);
    
    //cutout board
    translate([-1, 23.25, 14.5]) cube([6, 53.5, 46.50]); 
    
    //holes for board mounting, mounting from outside, screws in to the frame inside
        translate([-5, 20-2+3.25, 20]) rotate([0, 90, 0]) cylinder(d=3.2, h=14);
         translate([-5, 20-2+3.25, 20+30]) rotate([0, 90, 0]) cylinder(d=3.2, h=14);
        translate([-5, 79-3+3, 20]) rotate([0, 90, 0]) cylinder(d=3.2, h=14);
        translate([-5, 79-3+3, 20+30]) rotate([0, 90, 0]) cylinder(d=3.2, h=14);
}
//support for power distributor
difference() {
    union() {
    translate([30, 4, 3]) cube([8, 26.5, 15]);
    translate([30+48.2-8, 4+4, 3]) cube([8, 26.5-4, 15]);
    }
    translate([30+4-0.2, 4+13.35, 3]) cylinder(d=2.7, h=20);
    translate([30+4+48.2-8, 4+13.35, 3]) cylinder(d=2.7, h=20);
}
//test board
/*difference() {
    translate([95-13, 92-45.5, 14]) cube([26.5, 49.5, 1.5]);
    translate([95-13+14.5, 92+4-2.5, 3]) cylinder(d=2.7, h=15);
    translate([95-13+14.5, 92-45.5+6-3.5, 3]) cylinder(d=2.7, h=15);
} */
}

module base() {
    d1=27;
difference() {
    union() {
    hull() {
    translate([5, 5, 0]) cylinder(d=10, h=h1);
    translate([120-5, 5, 0]) cylinder(d=10, h=h1);
    translate([5, 100-5, 0]) cylinder(d=10, h=h1);
    translate([120-5, 100-5, 0]) cylinder(d=10, h=h1);
    }
    }
    a=4;
    hull() {
    translate([5+a, 5+a, 3]) cylinder(d=10, h=h1);
    translate([120-5-a, 5+a, 3]) cylinder(d=10, h=h1);
    translate([5+a, 100-5-a, 3]) cylinder(d=10, h=h1);
    translate([120-5-a, 100-5-a, 3]) cylinder(d=10, h=h1);
    }
    //lowering for cover
    b=a-2.5;
    hull() {
    translate([5+b, 5+b, h1-3]) cylinder(d=10, h=h1);
    translate([120-5-b, 5+b, h1-3]) cylinder(d=10, h=h1);
    translate([5+b, 100-5-b, h1-3]) cylinder(d=10, h=h1);
    translate([120-5-b, 100-5-b, h1-3]) cylinder(d=10, h=h1); 
    }  
}
//columns
a=4;
difference() {
    union() {
    translate([5+a, 5+a, 0]) cylinder(d=10, h=h2);
    translate([120-5-a, 5+a, 0]) cylinder(d=10, h=h2);
    translate([5+a, 100-5-a, 0]) cylinder(d=10, h=h2);
    translate([120-5-a, 100-5-a, 0]) cylinder(d=10, h=h2);
    }
    translate([5+a, 5+a, h2-10]) cylinder(d=2.8, h=15);
    translate([120-5-a, 5+a, h2-10]) cylinder(d=2.8, h=15);
    translate([5+a, 100-5-a, h2-10]) cylinder(d=2.8, h=15);
    translate([120-5-a, 100-5-a, h2-10]) cylinder(d=2.8, h=15);
    }
}

module motor() {
    difference() {
    union() {
    cylinder(d=34, h=29);
    translate([0, 0, 29]) cylinder(d=37, h=24.5);
    translate([7, 0, 29+24.5]) cylinder(d=12, h=6);
    translate([7, 0, 29+24.5+6]) cylinder(d=6, h=15);
    }
    translate([7.75, 13.42339, 29+24.5-5]) cylinder(d=3, h=6);
    translate([-7.75, 13.42339, 29+24.5-5]) cylinder(d=3, h=6);
    translate([7.75, -13.42339, 29+24.5-5]) cylinder(d=3, h=6);
    translate([-7.75, -13.42339, 29+24.5-5]) cylinder(d=3, h=6);
    translate([15.5, 0, 29+24.5-5]) cylinder(d=3, h=6);
    translate([-15.5, 0, 29+24.5-5]) cylinder(d=3, h=6);
    }
}
 
 module cover() {
    a=4;
    b=a-2.25;
    d1=27;
    difference() {
    union() {
    hull() {
    translate([5+b, 5+b, h2]) cylinder(d=10, h=3);
    translate([120-5-b, 5+b, h2]) cylinder(d=10, h=3);
    translate([5+b, 100-5-b, h2]) cylinder(d=10, h=3);
    translate([120-5-b, 100-5-b, h2]) cylinder(d=10, h=3); 
     }
    //cylinders for bearings
    translate([6.5+d1/2, 7+d1/2, h2+3]) cylinder(d=d1, h=7);
    translate([6.5+d1/2+80, 7+d1/2, h2+3]) cylinder(d=d1, h=7); 
 }
    //cutouts bearings
    translate([60, 67, h2-2]) cylinder(d=32, h=10);
    translate([6.5+d1/2, 7+d1/2, h2-2]) cylinder(d=19, h=15);
    translate([6.5+d1/2+80, 7+d1/2, h2-2]) cylinder(d=19, h=15); 
    translate([6.5+d1/2, 7+d1/2, h2+3]) cylinder(d=22.5, h=15);
    translate([6.5+d1/2+80, 7+d1/2, h2+3]) cylinder(d=22.5, h=15); 
    //cutout srews
    translate([5+a, 5+a, h2-10]) cylinder(d=3, h=15);
    translate([120-5-a, 5+a, h2-10]) cylinder(d=3, h=15);
    translate([5+a, 100-5-a, h2-10]) cylinder(d=3, h=15);
    translate([120-5-a, 100-5-a, h2-10]) cylinder(d=3, h=15);
    }
}

module motor_adapter() {
    difference() {
        union () {
        hull() {
            cylinder(d=14.5, h=2);
            translate([9.5, 0, 0]) cylinder(d=14.5, h=2);
            }
        translate([0, 0, 0]) cylinder(d=11, h=5);
       translate([9.5, 0, -12]) cylinder(d=14.5, h= 13); 
        }
    translate([0, 0, -1]) rotate([0, 0, 30]) cylinder(d=6.5, h=3, $fn=6);
    translate([0, 0, -2]) cylinder(d=3.5, h=20);
    translate([9.5, 0, -20]) cylinder(d=6.5, h=25);
    translate([10, 0, -7.5]) rotate([0, 90, 0]) cylinder(d=2.5, h=15);
    }
}

module platform_support() {
    difference() {
        union() {
    //cylinders for bearings
        translate([25.5, -34, 0]) cylinder(d=27, h=9);
        translate([-21, 6, 0]) cylinder(d=27, h=9);
        translate([25.5, 46, 0]) cylinder(d=27, h=9);
        //platform support
        translate([20.5, -24, 5]) cube([10, 60, 4]);
        translate([15, -32, 5]) rotate([0, 0, 50]) cube([10, 60, 4]);
        translate([-28, 8, 5]) rotate([0, 0, -50]) cube([10, 60, 4]);
            
        translate([0, -34+11.25+10, 9]) cylinder(d=10, h=5);        
    translate([0, 46-11.25-10, 9]) cylinder(d=10, h=5);
        translate([25.5, 6, 9]) cylinder(d=10, h=5);
            
        }
    //cutout bearings
    translate([25.5, -34, 2]) cylinder(d=22.5, h=15);
    translate([-21, 6, 2]) cylinder(d=22.5, h=15);  //22.5
    translate([25.5, 46, 2]) cylinder(d=22.5, h=15);
        
    translate([25.5, -34, -3]) cylinder(d=19, h=15);
    translate([-21, 6, -3]) cylinder(d=19, h=15);
    translate([25.5, 46, -3]) cylinder(d=19, h=15);
    //cutout screws
    translate([0, -34+11.25+10, 0]) cylinder(d=3.1, h=20);        
    translate([0, 46-11.25-10, 0]) cylinder(d=3.1, h=20);
    translate([25.5, 6, 0]) cylinder(d=3.1, h=20);
    //cutout nuts
    translate([0, -34+11.25+10, 5]) cylinder(d=6.5, h=2.5, $fn=6);      
    translate([0, 46-11.25-10, 5]) cylinder(d=6.5, h=2.5, $fn=6);
    translate([25.5, 6, 5]) cylinder(d=6.5, h=2.5, $fn=6);
    }    
}

module excenter() {
    difference() {
        union () {
        hull() {
            cylinder(d=14.5, h=2);
            translate([9.5, 0, 0]) cylinder(d=14.5, h=2);
        }
        translate([0, 0, 0]) cylinder(d=11, h=5);
        translate([9.5, 0, -8]) cylinder(d=8.0, h=9);
        translate([9.5, 0, -2]) cylinder(d=11, h=2);  
    }
    translate([0, 0, 0]) rotate([0, 0, 30]) cylinder(d=6.5, h=2, $fn=6);
    translate([0, 0, -2]) cylinder(d=3.5, h=12);
    //translate([9.5, 0, -10]) cylinder(d=3.5, h=14);
    //translate([9.5, 0, 1]) cylinder(d=6, h=5);
    }
}

module burling() {
    difference() {
        union() {
        cylinder(d=11, h=3);
        cylinder(d=8.0, h=10);
        }
        translate([0, 0, -2]) cylinder(d=3.5, h=14);
        translate([0, 0, -2]) cylinder(d=6, h=7);
    }
}

module heated_hood() {
    difference() {
    hull() {
        translate([1, 1, 0]) cylinder(d=8, h=100);
        translate([120-1, 1, 0]) cylinder(d=8, h=100);
        translate([1, 100-1, 0]) cylinder(d=8, h=100);
        translate([120-1, 100-1, 0]) cylinder(d=8, h=100);
    }
    hull() {
        translate([4-0.25, 4-0.25, -1]) cylinder(d=8, h=110);
        translate([120-4+0.25, 4-0.25, -1]) cylinder(d=8, h=110);
        translate([4-0.25, 100-4+0.25, -1]) cylinder(d=8, h=110);
        translate([120-4+0.25, 100-4+0.25, -1]) cylinder(d=8, h=110);
    }
    //glass window, glass plate 88x88
    translate([20, -4, 8-2]) cube([80, 8, 80]);
    //translate([16, -1.50, 8-5]) cube([88, 8, 88]);
    //cutout cable
    translate([-5, 50, 70]) rotate([0, 90, 0]) cylinder(d=6.5, h=10);
    }

    //cutout cable
    difference() {
        translate([0, 50, 70]) rotate([0, 90, 0]) cylinder(d=10, h=7);
        translate([-4, 50, 70]) rotate([0, 90, 0]) cylinder(d=6.5, h=15);
    }

//columns for fan
difference() {
    union() {
        translate([-1, 30+7/2, 45]) rotate([0, 90, 0]) cylinder(d=8, h=11);
    translate([-1, 30+7/2+32, 45]) rotate([0, 90, 0]) cylinder(d=8, h=11);
    translate([-1, 30+7/2, 45-32]) rotate([0, 90, 0]) cylinder(d=8, h=11);
    translate([-1, 30+7/2+33, 45-32]) rotate([0, 90, 0]) cylinder(d=8, h=11);
    }
    //holes for fan screws
    translate([0, 30+7/2, 45]) rotate([0, 90, 0]) cylinder(d=2.8, h=15);
    translate([0, 30+7/2+32, 45]) rotate([0, 90, 0]) cylinder(d=2.8, h=15);
    translate([0, 30+7/2, 45-32]) rotate([0, 90, 0]) cylinder(d=2.8, h=15);
    translate([0, 30+7/2+33, 45-32]) rotate([0, 90, 0]) cylinder(d=2.8, h=15);
}

//columns for cover mounting
a=-2;
difference() {
    union() {
    translate([5+a, 5+a, 3.0]) cylinder(d=10, h=15);
    translate([120-5-a, 100-5-a, 3.0]) cylinder(d=10, h=15);
    }
    translate([5+a, 5+a, 1]) cylinder(d=2.8, h=20);
    translate([120-5-a, 100-5-a, 1]) cylinder(d=2.8, h=20);
    }

//sensor holder
difference() {
    d=5.2;
    union()  {
        translate([60-4, 100-8, 40]) cube([8, 10, 25]);
    }
    translate([60-5, 100-10, 44]) cube([10, 11, 16]);
    translate([60, 100-4, 38]) cylinder(d=d, h=25);
}
//cable guide heating mat
difference() {
    translate([0, 100-8, 3]) cube([8, 10, 65]);
    translate([4, 100-10, 3]) cube([6, 6, 6]);
    translate([4, 100-4, 3]) cylinder(d=6, h=75);
    translate([3, 100-4, 25+4]) rotate([0, 90, 0]) cylinder(d=6, h=55);
}
//cable guide sensor holder
difference() {
    translate([8, 100-8, 25]) cube([45, 10, 8]); 
    translate([3, 100-4, 25+4]) rotate([0, 90, 0]) cylinder(d=6, h=55);
}

//frame for glass plate
difference() {
translate([13, -0.25, 2.5]) cube([94, 4, 100-10+3-2.5]);
translate([13+2.5, -0.25, -1]) cube([89, 1.6, 89+1+2.5]); 
//glass window, glass plate 88x88
translate([20, -4, 8-2]) cube([80, 12, 80]);
}

translate([-1, 10, ,100-10]) cube([4, 80, 3]);
translate([120-3, 10, ,100-10]) cube([4, 80, 3]);
//test heating mat OD 90 mm, 18 W
//translate([62, 50, 3]) cylinder(d=90, h=3);
}
//test glass plate
//color("white", 0.5) {translate([13+3, 0.2, 2.5]) cube([88, 1.2, 88]); }


module heated_hood_cover() {
    difference() {
        union() {
        hull() {
        translate([1, 1, 0]) cylinder(d=8, h=3);
        translate([120-1, 1, 0]) cylinder(d=8, h=3);
        translate([1, 100-1, 0]) cylinder(d=8, h=3);
        translate([120-1, 100-1, 0]) cylinder(d=8, h=3);
        }
        hull() {
        translate([4.2, 4.2, 0]) cylinder(d=8, h=6);
        translate([120-4.2, 4.2, 0]) cylinder(d=8, h=6);
        translate([4.2, 100-4.2, 0]) cylinder(d=8, h=6);
        translate([120-4.2, 100-4.2, 0]) cylinder(d=8, h=6);
        }
    }
    translate([3, 3, -1]) cylinder(d=3.2, h=10);
    translate([117, 97, -1]) cylinder(d=3.2, h=10);
    
    string1 = str("cable");
    //name
    translate ([5, 90, 4]) linear_extrude(3.0) text(string1, size = 8, direction = "ltr", spacing = 1 );
}
}

module heated_hood_cable_support() {
    translate([-10.5, 0, 0]) cube([80+10.5, 40.5, 1.5]);
    translate([-10.5, 0, -7]) cube([1.5, 40.5, 7]);
    translate([80-1, 0, 0]) cube([1.5, 40.5, 15]);
    translate([0, 40-1, 0]) cube([80, 1.5, 15]);
    translate([80-7, 0, 15-1]) cube([7.5, 40.5, 1.5]);
}
