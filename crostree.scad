//-----------------------------------------------------------------------
//-- Crosstree
//-----------------------------------------------------------------------
//-- (c) Jose Vega . Jun-2014
//-------------------------------------------------------------------------
//-- This is composed of 2 parts
//--   - the circular base
//--   - the crosstree negative for create a dump on the center of the circular base
//--
//--   The crosstree negative is created from 3 cylinders basics
//-------------------------------------------------------------------------
//-- Released under the GPL license
//-------------------------------------------------------------------------

//Cylinder1
C1Height = 1;
C1Radio1 = 1/2;
C1Radio2 = 3/2;
C1Position = C1Height/2;
//Cylinder2
C2Height = 3;
C2Radio = C1Radio2;
C2Position = C1Position + C1Height/2 + C2Height/2;
//Cylinder3
C3Height = 2;
C3Radio = C1Radio1;
C3Position = C1Position-C1Height;
//Crosstree
Length = 40;
//base
BaseLength = 60;
BaseHeight = 1;


set1Pos = [Length/2, 0, 0];
set2Pos = [-(Length/2), 0, 0];
set3Pos = [0, Length/2, 0];
set4Pos = [0,-(Length/2), 0]; 


module cylinder1() {
	cylinder(h=C1Height,r1=C1Radio1, r2=C1Radio2 ,$fn = 120, center = true);
}
module cylinder2() {
	translate(C2Position)
	cylinder(h=C2Height,r=C2Radio , center = true, $fn = 120);
}
module cylinder3() {
	cylinder(h=C3Height,r=C3Radio, $fn = 120 , center = true);
}

module set() {
	union() {
		translate([0, 0, C1Position])
		cylinder1();
		translate([0, 0, C2Position])
		cylinder2();
		translate([0, 0, C3Position])
		cylinder3();
	}

}

module crosstree_negative() {
	union() {
		hull() {
			translate([0, 0, C1Position])
			translate(set1Pos)
			cylinder1();
			translate([0, 0, C1Position])
			translate(set2Pos)
			cylinder1();
		}
		hull() {
			translate([0,0 ,C2Position])
			translate(set1Pos)
			cylinder2();
			translate([0, 0, C2Position])
			translate(set2Pos)
			cylinder2();
		}
		hull() {
			translate([0,0 ,C3Position])
			translate(set1Pos)
			cylinder3();
			translate([0, 0, C3Position])
			translate(set2Pos)
			cylinder3();
		}

		hull() {
			translate([0, 0, C1Position])
			translate(set3Pos)
			cylinder1();
			translate([0, 0, C1Position])
			translate(set4Pos)
			cylinder1();
		}
		hull() {
			translate([0,0 ,C2Position])
			translate(set3Pos)
			cylinder2();
			translate([0, 0, C2Position])
			translate(set4Pos)
			cylinder2();
		}
		hull() {
			translate([0,0 ,C3Position])
			translate(set3Pos)
			cylinder3();
			translate([0, 0, C3Position])
			translate(set4Pos)
			cylinder3();
		}
	}



}

module Base() {
	translate([0, 0, 0.4])
	cylinder(h=BaseHeight,r=BaseLength/2 , center = true, $fn=240);
}

module Base2() {
	translate([0, 0, 1.5])
	difference() {
		cylinder(h=3,r=60/2, center=true, $fn=240);
		cylinder(h=4,r=50/2, center=true, $fn=240);
	}
}

module Crosstree() {
	union() {
		difference() {
			Base();
			crosstree_negative();
		}
		Base2();
	}


}

Crosstree();
