$fn=80;

//back_plate();
//front_plate();
//leg();  //2 needed
//foot(); //3 needed
//cover_nema();
//cover_nema_CO();
//cover_AS_mounting();
//cover_AS_motor_holder();
//union_plates();
waste_bottle_holder_PA_printed();
//waste_bottle_holder_52x24();

//color("black", 1.0) { translate([215-137-5, 135-35, -12]) nema_14(); }  //for testing
//rotate([180, 0, 0]) translate([71.5, -137, 0]) cover_nema(); //for testing
//color("black", 0.2) {translate([168.4-5, 147, -3]) rotate([0, 180, 180])  cover_AS_motor_holder(); }
//translate([-10, -100, 0]) cube([10, 200, 5]);

module back_plate() {
difference() {
    union() {
        translate([-17, 0, 0]) square([249, 151]);

        }
    //cut-out Nema 14
    translate([71.35-0.5, 98.35, 0]) square([40, 39]);
    holes();
    //cutout z-motor holder
    translate([168.4, 75, 0]) square([28.2, 80]);
    //cuts for testing
    //translate([-20, -5, -1]) cube([260, 100, 6]);
    //translate([215-32.5-13.1-5-1+5, -5, -1]) cube([100, 220, 5]);
    }
}

module front_plate() {
    difference() {
        union() {
        translate([-17, -152, 0]) square([249, 152]);
        }
        holes();
        //cutout waste bottle
        translate([20, -37, 0]) circle(d=32.5);
        
        //cutout mounting-profile autosampler
        translate([168.4, -153, 0]) square([28.2, 83.5]);
    }
}

module holes() {
    for (i=[1:3])
        translate([-10, -160+i*40, 0]) slit_y();  //y
    for (i=[5:6])
        translate([-10, -170+i*40, 0]) slit_y();  //y
    for (i=[1:3])
        translate([215+10, -160+i*40, 0]) slit_y();  //y
    for (i=[5:6])
        translate([215+10, -170+i*40, 0]) slit_y();  //y
    for (i=[1:6])
        translate([i*35-30, 135+10, 0]) slit_x();  //x
    translate([5*40+5, 135+10, 0]) slit_x();  //x
    for (i=[1:3])
        translate([i*35-30, -135-10, 0]) slit_x();  //x
        translate([4*40-25, -135-10, 0]) slit_x();  //x
    translate([5*40+5, -135-10, 0]) slit_x();  //x
    //holes for legs
    translate([4*30-14, -135-10, 0]) circle(d=5.2); //front
    translate([-10.5, 110+8, 0]) circle(d=5.2);   //back
    translate([215+10, -130+8*30+8, 0]) circle(d=5.2); //back    
}

module union_plates() {
    difference() {
        union() {
        translate([0, -1, -1]) cube([215, 1, 5]);
        translate([-14, -11, -1]) cube([243, 21, 1]);
        translate([0, -11, 3]) cube([215, 21, 1]);
    }
    translate([22, -12, 0]) cube([21, 23, 8]);
}
}

module slit_x() {
    hull()  {
        circle(d=3.2);
        translate([8, 0, 0]) circle(d=3.2);
    }
}

module slit_y() {
    hull()  {
        circle(d=3.2);
        translate([0, 8, 0]) circle(d=3.2);
    }
}

module nema_14() {
    a=2.6;
    b=30.5;
    linear_extrude(height = 14)
    polygon(points=[[0,a],[0,a+b],[a,a+b+a],[a+b,a+b+a],[a+b+a,a+b],[a+b+a,a],[a+b,0],[a,0]]);
    //motor cables
    //#translate([-2.7, 35/2-4, 0]) cube([3, 9, 5]);
}

module profile() {  //for testing
    difference() {
        cube([20, 160, 5]);
        translate([7.5, 7.5, -1]) cube([5, 140, 8]);
    }
}

module leg() {
    difference() {
        union() {
        hull() {
            translate([7, 7, 0,]) cylinder(d=14, h=5);
            translate([19, 7, 0,]) cylinder(d=14, h=5);
        }
        translate([7,7,0]) cylinder(d=14, h=23);
    }
    translate([7,7,-1]) cylinder(d=10, h=20);
    translate([7,7,1]) cylinder(d=5.2, h=26);
    translate([19, 7, -1,]) cylinder(d=9, h=3.5, $fn=6);
    translate([19, 7, -1,]) cylinder(d=5.2, h=7);
}
}

module foot() {
    difference() {
        cylinder(d=14, h=6);
        translate([0, 0, 2]) cylinder(d=3.8, h=5);
    }
}

module cover_nema() {
    difference() {
        union() {
            cube([38, 38, 10]);
            translate([-5, -5, 0]) cube([38+10, 38+10, 3]);
        translate([-3, 35/2-5, 0]) cube([6, 11, 6]);
        }
    translate([1.15, 1.15, -2]) nema_14();
        //motor cables
    translate([-2, 35/2-4, -1]) cube([4, 9, 4]);
    }
    translate([0, 0, 10]) cube([38, 38, 2]);
}

module cover_nema_CO() {
    difference() {
        union() {
            cube([38, 38, 15]);
            translate([-5, -5, 0]) cube([38+10, 38+10, 3]);
        translate([-3, 35/2-5, 0]) cube([6, 11, 16]);
        }
    translate([1.15, 1.15, -2]) nema_14();
        //motor cables
    translate([-2, 35/2-4, -1]) cube([4, 9, 14]);
    }
    translate([0, 0, 15]) cube([38, 38, 2]);
}


module cover_AS_mounting() {
    difference() {
        cube([26.2+10, 79+5, 4]);
        translate([4.9, -1, -1]) cube([26.4, 80, 3.3]);
        translate([18.35, 66.5, 2]) cylinder(d=8.5, h=5);
        translate([18.35, 26.5, 2]) cylinder(d=8.5, h=5);
        translate([-1, -1, -1]) cube([38, 12, 6]);
    }
}

module cover_AS_motor_holder() {
    difference() {
        cube([26.2+10, 79, 4]);
        translate([4.9, -1, -1]) cube([26.4, 75, 3.3]);
        translate([18.35, 59, 2]) cylinder(d=8.5, h=5);
        translate([18.35, 24, 2]) cylinder(d=8.5, h=5);
    }
}

module waste_bottle_holder_PA_printed() {
    difference() {
        union() {
        cylinder(d=32, h=22);
        translate([0, 0, 22]) cylinder(d=36, h=3);
        }
        translate([0, 0, 2]) cylinder(d=31, h=26);
    }
}

module waste_bottle_holder_52x24() {
    difference() {
        union() {
        cylinder(d=32, h=22);
        translate([0, 0, 22]) cylinder(d=36, h=3);
        }
        translate([0, 0, 2]) cylinder(d=24.5, h=26);
    }
}