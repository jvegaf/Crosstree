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

//cyl_1
C1Height = 2;
C1Radio1 = 1;
C1Radio2 = 3;
C1Position = C1Height/2;
//cyl_2
C2Height = 6;
C2Radio = C1Radio2;
C2Position = C1Position + C1Height/2 + C2Height/2;
//cyl_3
C3Height = 4;
C3Radio = C1Radio1;
C3Position = C1Position-C1Height;
//crosstree
Lenght = 80;
//coin
coinLenght = 100;
coinRadio = coinLenght / 2;
coinHeight = 1.5;
//coin2
coin2Radio = coinRadio; //120
coin2Interior = coinLenght - (coinLenght * 0.1); //100 aprox
coin2InnerRadio = coin2Interior / 2;

conjunto1Pos = [Lenght/2, 0, 0];
conjunto2Pos = [-(Lenght/2), 0, 0];
conjunto3Pos = [0, Lenght/2, 0];
conjunto4Pos = [0,-(Lenght/2), 0]; 


module cyl_1() {
	cylinder(h=C1Height,r1=C1Radio1, r2=C1Radio2 ,$fn = 120, center = true);
}
module cyl_2() {
	translate(C2Position)
	cylinder(h=C2Height,r=C2Radio , center = true, $fn = 120);
}
module cyl_3() {
	cylinder(h=C3Height,r=C3Radio, $fn = 120 , center = true);
}

module conjunto() {
	union() {
		translate([0, 0, C1Position])
		cyl_1();
		translate([0, 0, C2Position])
		cyl_2();
		translate([0, 0, C3Position])
		cyl_3();
	}

}

module crosstree() {
	union() {
		hull() {
			translate([0, 0, C1Position])
			translate(conjunto1Pos)
			cyl_1();
			translate([0, 0, C1Position])
			translate(conjunto2Pos)
			cyl_1();
		}
		hull() {
			translate([0,0 ,C2Position])
			translate(conjunto1Pos)
			cyl_2();
			translate([0, 0, C2Position])
			translate(conjunto2Pos)
			cyl_2();
		}
		hull() {
			translate([0,0 ,C3Position])
			translate(conjunto1Pos)
			cyl_3();
			translate([0, 0, C3Position])
			translate(conjunto2Pos)
			cyl_3();
		}

		hull() {
			translate([0, 0, C1Position])
			translate(conjunto3Pos)
			cyl_1();
			translate([0, 0, C1Position])
			translate(conjunto4Pos)
			cyl_1();
		}
		hull() {
			translate([0,0 ,C2Position])
			translate(conjunto3Pos)
			cyl_2();
			translate([0, 0, C2Position])
			translate(conjunto4Pos)
			cyl_2();
		}
		hull() {
			translate([0,0 ,C3Position])
			translate(conjunto3Pos)
			cyl_3();
			translate([0, 0, C3Position])
			translate(conjunto4Pos)
			cyl_3();
		}
	}



}

module coin() {
	translate([0, 0, 0.4])
	cylinder(h=coinHeight,r=coinLenght/2 , center = true, $fn=240);
}

module coin2() {
	translate([0, 0, 1.5])
	difference() {
		cylinder(h=3,r=coin2Radio, center=true, $fn=240);
		cylinder(h=4,r=coin2InnerRadio, center=true, $fn=240);
	}
}

module final() {
	union() {
		difference() {
			coin();
			crosstree();
		}
		coin2();
	}


}

final();
//crosstree();