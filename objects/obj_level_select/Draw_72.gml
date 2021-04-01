//Get bg color
var frame;
var camX = camera_get_view_x(view);
var camY = camera_get_view_y(view);

switch (selectedLevelSet)
{
	case 0:
	case 1:
	case 2:
	case 3:
	case 4:
		frame = 0;
	break;
	
	case 5:
	case 6:
	case 7:
		frame = 1;
	break;
	
	case 8:
	case 9:
		frame = 2;
	break;
	
	default:
		frame = 2;
	break;
}

//Offset background based on camera position for parallax
draw_sprite_tiled_ext(spr_bg, frame, camX/2, camY/2, 1, 1, c_white, 1);