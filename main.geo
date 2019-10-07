////Inputs
boxdim = 2;
gridsize=boxdim/10;
//
Limx = boxdim*0.6;

Limy = boxdim*0.4;



// Geometría de Célula //

radio = Limy*0.5;
offset = Limx*0.88;

Point(1) = {0+offset,0,0,gridsize}; //Centro de célula
Point(2) = {radio+offset,0,0,gridsize};
Point(3) = {0+offset,radio,0,gridsize}; 
Point(4) = {-radio+offset,0,0,gridsize};
//
//
// Estructura //
Point(5) = {-Limx,0,0,gridsize};
Point(6) = {-Limx,Limy,0,gridsize};
Point(7) = {Limx,Limy,0,gridsize};

radio_b = radio*0.1;
apertura = Limy*0.45;


Point(8) = {Limx,apertura+radio_b,0,gridsize};
Point(9) = {Limx+radio_b,apertura,0,gridsize};
Point(10)= {Limx+radio_b,apertura+radio_b,0,gridsize};

Point(11) = {boxdim, apertura,0,gridsize};
Point(111) = {boxdim-boxdim*0.1,apertura,0,gridsize};
Point(12) = {boxdim, 0,0,gridsize};

// Structured mesh //

ang1 = 45*Pi/180;
ang2 = 72*Pi/180;
ang3 = 63*Pi/180;

Point(13) = {offset+(radio)*Cos(ang2),radio*Sin(ang2),0,gridsize};
Point(14) = {offset-(radio)*Cos(ang1),radio*Sin(ang1),0,gridsize};       
Point(15) = {offset,Limy,0,gridsize};
Point(16) = {offset+(radio)*Cos(ang3),radio*Sin(ang3),0,gridsize};
Point(17) = {Limx,apertura+radio_b*3,0,gridsize};

//Point(16) = {Limx+radio_b,0,0,gridsize};

Circle(1) = {2,1,16};
Circle(101) = {16,1,13};
Circle(2) = {13,1,3};
Circle(3) = {3,1,14};
Circle(4) = {14,1,4};
Line(5) = {4,5};
Line(6) = {5,6};
Line(7) = {6,14};
Line(8) = {6,15};
Line(9) = {15,3};

Line(10) = {15, 7};
Line(11) = {7, 17};
Line(110) = {17,8};
Line(111) = {17,3};
//Line(12) = {7, 13};
Circle(13) = {8, 10, 9};
Line(14) = {9, 111};
Line(141) ={111,11};
Line(15) = {11, 12};
//Line(16) = {8, 2};
//Line(17) = {2, 16};
//Line(18) = {16, 9};
Line(19) = {12, 2};
Line(142) = {111, 2};

Line(102) = {8, 13};
Line(103) = {9, 16};


// Define mesh //


Line Loop(1) = {4, 5, 6, 7};
Line Loop(2) = {3, -7, 8, 9};
Line Loop(3) = {111, -9, 10, 11};
Line Loop(4) = {2, -111, 110, 102};
Line Loop(5) = {101, -102, 13, 103};
Line Loop(6) = {1, -103, 14, 142};
Line Loop(7) = {142, -19, -15, -141};


Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};
Plane Surface(6) = {6};
Plane Surface(7) = {7};

div = 40;

Transfinite Curve {4, 5, 6, 7} = div Using Progression 1;
Transfinite Curve {3, 7, 8, 9} = div Using Progression 1;
Transfinite Curve {111, 9, 10, 11} = div Using Progression 1;
Transfinite Curve {2, 111, 110, 102} = div Using Progression 1;
Transfinite Curve {101, 102, 13, 103} = div Using Progression 1;
Transfinite Curve {1, 103, 14, 142} = div Using Progression 1;
Transfinite Curve {19, 142, 141, 15} = div Using Progression 1;


Transfinite Surface {1} = {4, 5, 6, 14};
Transfinite Surface {2} = {14, 6, 15, 3};
Transfinite Surface {3} = {3, 15, 7, 17};
Transfinite Surface {4} = {3, 17, 8, 13};
Transfinite Surface {5} = {13, 8, 9, 16};
Transfinite Surface {6} = {2, 16, 9, 111};
Transfinite Surface {7} = {2, 111, 11, 12};

Recombine Surface {1,2,3,4,5,6,7};

//Now make 3D by extrusion.
newEntities[] = 
Extrude { 0,0,0.05 }
{
	Surface{1,2,3,4,5,6,7};
	Layers{1};
	Recombine;
};

//Physical Surface("input") = {159};
//Physical Surface("output")= {291};
//Physical Surface("bottom")= {287,155};
//Physical Surface("front") = {186,296,274,208,230,252,164};
//Physical Surface("back")  = {6,7,1,2,3,4,5};
//Physical Surface("top")   = {181,203};
//Physical Surface("cell")  = {261,151,173,263,239,217};
//Physical Surface("contac")= {295,269,207,225,247};
//

Physical Surface("fixedWalls")={291,287,155,181,203,261,151,173,263,239,217,295,269,207,225,247};
Physical Surface("frontAndBack")={186,296,274,208,230,252,164,6,7,1,2,3,4,5};
Physical Surface("movingWall") = {159};

Physical Volume(100) = {1,2,3,4,5,6,7};

