$fa = 1;
$fs = 0.4;
wheel_diameter = 29;
tread = 8.52;
treadThickness = 1;
rimAndTread = 9.82;
rimDiameter = 10.8;
rimDepth = 2;
axle_radius = 1.32;
rimSpokeDiameter = 1.75;
rimSpokeMultiplier = 1.5;
spokeCount = 5;

module rimSpoke(){
    translate([axle_radius * 2 + rimSpokeDiameter/2, 0, rimSpokeDiameter/2 * rimSpokeMultiplier])rotate([0,90,0])linear_extrude(height=wheel_diameter/4 - (0.1 * rimSpokeDiameter * rimSpokeDiameter) - ( axle_radius * 2))scale([rimSpokeMultiplier,1,1])circle(d=rimSpokeDiameter);
}

module baseWheel(){

    //RIM flat
    //rotate_extrude(convexity = 20)translate([axle_radius, rimDepth, 0])square([((wheel_diameter - 0.1) - axle_radius) / 2,1]);

    //tire+rim profile full
    //polygon(points=[[.75,2.3],[0.75,1],[6,1],[7,0.3],[8,0.1],[9,0],[10,0],[11,0.1],[12,0.3],[13,1],[13,2],[7,2],[6,2.3]]);

    //Tire and rim full
    rotate_extrude(convexity = 20)translate([axle_radius + 0.5, 0, 0])polygon(points=[[.75,2.3],[0.75,1],[6,1],[7,0.3],[8,0.1],[9,0],[10,0],[11,0.1],[12,0.3],[13,1],[13,2],[7,2],[6,2.3]]);

    //tire+rim profile
    //polygon(points=[[.75,2],[0.75,1],[6,1],[7,0.3],[8,0.1],[9,0],[10,0],[11,0.1],[12,0.3],[13,1],[13,2],[12,1.5],[11,1.1],[10,1],[9,1],[8,1.1],[7,1.5],[6,2]]);

    //Tire and rim
    //rotate_extrude(convexity = 20)translate([axle_radius + 0.7, 0, 0])polygon(points=[[.75,2],[0.75,1],[6,1],[7,0.3],[8,0.1],[9,0],[10,0],[11,0.1],[12,0.3],[13,1],[13,2],[12,1.5],[11,1.1],[10,1],[9,1],[8,1.1],[7,1.5],[6,2]]);

    //Axle spot
    rotate_extrude(convexity = 20)translate([axle_radius, rimDepth, 0])square([1,(10.4 - rimDepth)]);

    //Axle support for strengthining the bond between the axle and the rim
    rotate_extrude(convexity = 20)translate([axle_radius, rimDepth, 0])square([3,2]);

    //Tread
    rotate_extrude(convexity = 20)translate([(wheel_diameter/2) - (treadThickness/2) , 1, 0])square([treadThickness,tread]);
}

module rimFace(){
//inside of rim
rotate_extrude(convexity = 20) {
translate([axle_radius * 2 + rimSpokeDiameter/2, rimSpokeDiameter/2 * rimSpokeMultiplier, 0])scale([1,rimSpokeMultiplier,1])circle(d=rimSpokeDiameter); }

//spokes
for(i = [1:1:spokeCount])
{
    angle = 360/spokeCount * i;
    rotate([0,0,angle])rimSpoke();
}

//outside of rim
rotate_extrude(convexity = 20) {
translate([wheel_diameter/4 + .5 , rimSpokeDiameter/2 * rimSpokeMultiplier, 0])scale([1,rimSpokeMultiplier,1])circle(d=rimSpokeDiameter); }
}

baseWheel();
rimFace();
