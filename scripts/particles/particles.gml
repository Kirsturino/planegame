//Thruster particle
global.ps = part_system_create();

global.thrustPart = part_type_create();
var p = global.thrustPart;
part_type_life(p, 10, 16);
part_type_shape(p, pt_shape_disk);
part_type_size(p, 0.05, 0.1, -0.002, 0);
part_type_color3(p, make_color_rgb(244, 192, 71),
					make_color_rgb(180, 35, 19), 
					make_color_rgb(21, 10, 31));
					
global.smokePart = part_type_create();
var p = global.smokePart;
part_type_color1(p, make_color_rgb(255, 253, 240));
part_type_life(p, 120, 240);
part_type_shape(p, pt_shape_disk);
part_type_size(p, 0.05, 0.1, -0.0004, 0);
part_type_speed(p, 0.05, 0.1, 0, 0);
part_type_direction(p, 0, 359, 0, 0);

global.smokePartShort = part_type_create();
var p = global.smokePartShort;
part_type_color1(p, make_color_rgb(255, 253, 240));
part_type_life(p, 30, 60);
part_type_shape(p, pt_shape_disk);
part_type_size(p, 0.05, 0.1, -0.001, 0);
part_type_speed(p, 0.05, 0.1, 0, 0);
part_type_direction(p, 0, 359, 0, 0);

global.explosiveSmokePart = part_type_create();
var p = global.explosiveSmokePart;
part_type_color1(p, make_color_rgb(255, 253, 240));
part_type_life(p, 120, 240);
part_type_shape(p, pt_shape_disk);
part_type_size(p, 0.1, 0.2, -0.001, 0);
part_type_speed(p, 1, 1.5, -0.01, 0);
part_type_direction(p, 0, 359, 0, 0);

global.turboPart = part_type_create();
var p = global.turboPart;
part_type_life(p, 10, 30);
part_type_shape(p, pt_shape_star);
part_type_size(p, 0.1, 0.2, -0.001, 0);
part_type_orientation(p, 0, 359, 4, 10, false);
part_type_color3(p, make_color_rgb(37, 49, 94),
					make_color_rgb(151, 219, 210), 
					make_color_rgb(255, 253, 240));
					
global.speedPart = part_type_create();
var p = global.speedPart;
part_type_shape(p,pt_shape_line);
part_type_size(p,0.1,0.2,-0.01,0);
part_type_scale(p,1,1);
part_type_color1(p,make_color_rgb(255, 253, 240));
part_type_alpha1(p,1);
part_type_speed(p,4,4,-0.002,0);
part_type_orientation(p,0,0,0,0,1);
part_type_life(p,10, 20);

global.shootPart = part_type_create();
var p = global.shootPart;
part_type_color1(p, make_color_rgb(255, 253, 240));
part_type_life(p, 6, 8);
part_type_shape(p, pt_shape_line);
part_type_size(p, 0.2, 0.3, -0.015, 0);
part_type_speed(p, 8, 12, -0.01, 0);
part_type_orientation(p,0,0,0,0,1);
part_type_direction(p,0,0,0,0);

global.linePart = part_type_create();
var p = global.linePart;
part_type_color1(p, make_color_rgb(21, 10, 31));
part_type_life(p, 60, 60);
part_type_shape(p, pt_shape_line);
part_type_size(p, 0.4, 0.4, -0.01, 0);
part_type_speed(p, 1.5, 1.5, -0.02, 0);
part_type_orientation(p,0,0,0,0,1);
