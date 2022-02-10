$fa = 1;
$fs = 0.1;
Wheel_Diameter = 29;//overall diameter
Tread = 8.52;//the depth of the Tread
Tread_Thickness = 1;//the thickness of the Tread
Rim_Depth = 2;//this is the depth of the drop that allows the nail head to hold the wheel properly
Axle_Radius = 1.32;//radius for the axle
Rim_Spoke_Diameter = 1.75;//diameter of the spoke
Rim_Spoke_Multiplier = 1.5;//thickness
Spoke_Count = 5;//the number of spokes to be distributed evenly arount the rim
Wheel_Shape = "third";// [first:Flat Profile, second:Thin Wheel and Rim Profile, third:Thick Wheel Profile]

module rimSpoke(){
    //module the rim's spokes
    translate([Axle_Radius * 2 + Rim_Spoke_Diameter/2, 0, Rim_Spoke_Diameter/2 * Rim_Spoke_Multiplier])rotate([0,90,0])linear_extrude(height=Wheel_Diameter/4 - (0.1 * Rim_Spoke_Diameter * Rim_Spoke_Diameter) - ( Axle_Radius * 2))scale([Rim_Spoke_Multiplier,1,1])circle(d=Rim_Spoke_Diameter);
}

module tireAndRimProfileFull(){
    //tire and rim with a nice profile and full thickness
    polygon(points=[[.75,2.3],[0.75,1],[6,1],[7,0.3],[8,0.1],[9,0],[10,0],[11,0.1],[12,0.3],[13,1],[13,2],[7,2],[6,2.3]]);
}
module tireAndRimProfileThin(){
    //tire and rim with a nice profile but thin
    polygon(points=[[.75,2],[0.75,1],[6,1],[7,0.3],[8,0.1],[9,0],[10,0],[11,0.1],[12,0.3],[13,1],[13,2],[12,1.5],[11,1.1],[10,1],[9,1],[8,1.1],[7,1.5],[6,2]]);
}

module flatWheel (){
    //RIM flat
    rotate_extrude(convexity = 20)translate([Axle_Radius, Rim_Depth, 0])square([((Wheel_Diameter - 0.1) - Axle_Radius)/ 2,1]);
}

module thinWallProfile (){
    //Tire and rim slim
    rotate_extrude(convexity = 20)translate([Axle_Radius + 0.7, 0, 0])tireAndRimProfileThin();
}

module thickWallProfile (){
    //Tire and rim full
    rotate_extrude(convexity = 20)translate([Axle_Radius + 0.5, 0, 0])tireAndRimProfileFull();
}

module baseWheel(){
    //The three objects below are the wheel as different profiles from the different profiles above.

    //Makes the wheel selected from the switch
	if (Wheel_Shape == "first") {
		 flatWheel();
	} else if (Wheel_Shape == "second") {
		thinWallProfile();
	} else {
		thickWallProfile();
	}

    //Axle spot, for the axle to enter
    rotate_extrude(convexity = 20)translate([Axle_Radius, Rim_Depth, 0])square([1,(10.4 - Rim_Depth)]);

    //Axle support for strengthining the bond between the axle and the rim
    rotate_extrude(convexity = 20)translate([Axle_Radius, Rim_Depth, 0])square([3,2]);

    //Tread
    rotate_extrude(convexity = 20)translate([(Wheel_Diameter/2) - (Tread_Thickness/2) , 1, 0])square([Tread_Thickness,Tread]);
}

module rimFace(){
    //This is the fancy rim that goes on the wheel

    //inside of rim
    rotate_extrude(convexity = 20) {
    translate([Axle_Radius * 2 + Rim_Spoke_Diameter/2, Rim_Spoke_Diameter/2 * Rim_Spoke_Multiplier, 0])scale([1,Rim_Spoke_Multiplier,1])circle(d=Rim_Spoke_Diameter); }

    //spokes
    for(i = [1:1:Spoke_Count])
    {
        angle = 360/Spoke_Count * i;
        rotate([0,0,angle])rimSpoke();
    }

    //outside of rim
    rotate_extrude(convexity = 20) {
    translate([Wheel_Diameter/4 + .5 , Rim_Spoke_Diameter/2 * Rim_Spoke_Multiplier, 0])scale([1,Rim_Spoke_Multiplier,1])circle(d=Rim_Spoke_Diameter); }
}

//Actual code to build the wheel from the modules
baseWheel();
rimFace();
