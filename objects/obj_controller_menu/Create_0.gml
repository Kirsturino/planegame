targArray = [	
				[rm_level_00, rm_level_babby_01, rm_level_babby_02, rm_level_babby_03], 
				[rm_level_01, rm_level_02, rm_level_03, rm_level_04, rm_level_05],
				[rm_level_21, rm_level_22, rm_level_23, rm_level_24, rm_level_25],
				[rm_level_06, rm_level_07, rm_level_08, rm_level_09, rm_level_10],
				[rm_rot_ins_01, rm_rot_ins_02, rm_rot_ins_03, rm_rot_ins_04, rm_level_small_01],
				[rm_level_10, rm_level_11, rm_level_12, rm_level_13, rm_level_14, rm_level_14_5, rm_level_15],
				[rm_level_16, rm_level_17, rm_level_18, rm_level_19, rm_level_20, rm_level_small_02],
				[rm_level_wall_tutorial, rm_level_26, rm_level_27, rm_level_28, rm_level_29, rm_level_30],
				[rm_pockets_01, rm_pockets_02, rm_pockets_03, rm_pockets_04, rm_pockets_05],
				[rm_level_static_01, rm_level_static_02, rm_level_static_03, rm_level_static_04, rm_level_static_05, rm_level_static_06]
			];

arrayX = 0;
arrayY = 0;
lengthX = array_length(targArray);
lengthY = array_length(targArray[arrayX]);

//Drawing
originX = 32;
originY = 32;
spaceX = 64;
spaceY = 42;
size = 16;
levelSurf = -1;

//Change room size to reflect UI, this is for camera placing purposes
room_width = lengthX*spaceX;

function levelInput()
{
	right =	gamepad_button_check_pressed(global.controller, gp_padr);
	left =	gamepad_button_check_pressed(global.controller, gp_padl);
	down =	gamepad_button_check_pressed(global.controller, gp_padd);
	up =	gamepad_button_check_pressed(global.controller, gp_padu);		
	confirm = gamepad_button_check_pressed(global.controller, gp_face1);
}

function moveLevelCamera()
{
	obj_camera_menu.targX = originX + arrayX*spaceX;
}