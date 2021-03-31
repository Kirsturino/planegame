global.particleTick = 0;
global.updateParticles = false;

global.thrustPart = -1;
global.smokePart = -1;
global.smokePartShort = -1;
global.explosiveSmokePart = -1;
global.turboPart = -1;
global.speedPart = -1;
global.shootPart = -1;
global.linePart = -1;
global.electricityPart = -1;

function initParticles()
{
	var d = defaultFramesPerSecond / global.speeds[global.framesPerSecond];
	
	//Thruster particle
	if (part_type_exists(global.thrustPart)) { part_type_destroy(global.thrustPart); }
	global.thrustPart = part_type_create();
	var p = global.thrustPart;
	part_type_life(p, 10/d, 16/d);
	part_type_shape(p, pt_shape_disk);
	part_type_size(p, 0.05, 0.1, -0.002*d, 0);
	part_type_color3(p, make_color_rgb(244, 192, 71),
						make_color_rgb(180, 35, 19), 
						make_color_rgb(21, 10, 31));
	
	if (part_type_exists(global.smokePart)) { part_type_destroy(global.smokePart); }
	global.smokePart = part_type_create();
	var p = global.smokePart;
	part_type_color1(p, make_color_rgb(255, 253, 240));
	part_type_life(p, 120/d, 240/d);
	part_type_shape(p, pt_shape_disk);
	part_type_size(p, 0.05, 0.1, -0.0004*d, 0);
	part_type_speed(p, 0.05*d, 0.1*d, 0, 0);
	part_type_direction(p, 0, 359, 0, 0);

	if (part_type_exists(global.smokePartShort)) { part_type_destroy(global.smokePartShort); }
	global.smokePartShort = part_type_create();
	var p = global.smokePartShort;
	part_type_color1(p, make_color_rgb(255, 253, 240));
	part_type_life(p, 20/d, 40/d);
	part_type_shape(p, pt_shape_disk);
	part_type_size(p, 0.05, 0.1, -0.002*d, 0);
	part_type_speed(p, 0.05*d, 0.1*d, 0, 0);
	part_type_direction(p, 0, 359, 0, 0);

	if (part_type_exists(global.explosiveSmokePart)) { part_type_destroy(global.explosiveSmokePart); }
	global.explosiveSmokePart = part_type_create();
	var p = global.explosiveSmokePart;
	part_type_color1(p, make_color_rgb(255, 253, 240));
	part_type_life(p, 120/d, 240/d);
	part_type_shape(p, pt_shape_disk);
	part_type_size(p, 0.1, 0.3, -0.002*d, 0);
	part_type_speed(p, 0.7*d, 1.7*d, -0.008*d, 0);
	part_type_direction(p, 0, 359, 0, 0);

	if (part_type_exists(global.turboPart)) { part_type_destroy(global.turboPart); }
	global.turboPart = part_type_create();
	var p = global.turboPart;
	part_type_life(p, 10/d, 30/d);
	part_type_shape(p, pt_shape_star);
	part_type_size(p, 0.1, 0.2, -0.001*d, 0);
	part_type_orientation(p, 0, 359, 4*d, 10, false);
	part_type_color3(p, make_color_rgb(37, 49, 94),
						make_color_rgb(151, 219, 210), 
						make_color_rgb(255, 253, 240));
				
	if (part_type_exists(global.speedPart)) { part_type_destroy(global.speedPart); }
	global.speedPart = part_type_create();
	var p = global.speedPart;
	part_type_shape(p,pt_shape_line);
	part_type_size(p,0.1,0.2,-0.01*d,0);
	part_type_scale(p,1,1);
	part_type_color1(p,make_color_rgb(255, 253, 240));
	part_type_alpha1(p,1);
	part_type_speed(p,4*d,4*d,-0.002*d,0);
	part_type_orientation(p,0,0,0,0,1);
	part_type_life(p,10/d,20/d);

	if (part_type_exists(global.shootPart)) { part_type_destroy(global.shootPart); }
	global.shootPart = part_type_create();
	var p = global.shootPart;
	part_type_color1(p, make_color_rgb(255, 253, 240));
	part_type_life(p, 6/d, 8/d);
	part_type_shape(p, pt_shape_line);
	part_type_size(p, 0.2, 0.3, -0.015*d, 0);
	part_type_speed(p, 8*d, 12*d, -0.01*d, 0);
	part_type_orientation(p,0,0,0,0,1);
	part_type_direction(p,0,0,0,0);

	if (part_type_exists(global.linePart)) { part_type_destroy(global.linePart); }
	global.linePart = part_type_create();
	var p = global.linePart;
	part_type_color1(p, make_color_rgb(21, 10, 31));
	part_type_life(p, 60/d, 60/d);
	part_type_shape(p, pt_shape_line);
	part_type_size(p, 0.4, 0.4, -0.01*d, 0);
	part_type_speed(p, 1.5*d, 1.5*d, -0.02*d, 0);
	part_type_orientation(p,0,0,0,0,1);
	
	if (part_type_exists(global.electricityPart)) { part_type_destroy(global.electricityPart); }
	global.electricityPart = part_type_create();
	var p = global.electricityPart;
	part_type_life(p, 5/d, 10/d);
	part_type_shape(p, pt_shape_line);
	part_type_size(p, 0.1, 0.12, -0.002*d, 0);
	part_type_orientation(p, 0, 359, 1*d, 0, 0);
	part_type_direction(p, 0, 359, 1*d, 0);
	part_type_speed(p, 0, 1, 0, 0);
	part_type_color1(p, make_color_rgb(255, 253, 240));
}