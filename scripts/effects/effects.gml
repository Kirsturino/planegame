function drawTriangle(x, y, size, rotation, color, outline)
{
	var _x = x + lengthdir_x(size, rotation);
	var _y = y + lengthdir_y(size, rotation);
	
	var _x2 = x + lengthdir_x(size, rotation + 120);
	var _y2 = y + lengthdir_y(size, rotation + 120);
	
	var _x3 = x + lengthdir_x(size, rotation + 240);
	var _y3 = y + lengthdir_y(size, rotation + 240);
	
	draw_triangle_color(_x, _y, _x2, _y2, _x3, _y3, color, color, color, outline);
}

function radialParticle(part, seg, rad, x, y)
{
	//FX
	var i = 0;
	repeat (seg)
	{
		var dir = 360/seg*i;
		var spawnX = x + lengthdir_x(rad, dir);
		var spawnY = y + lengthdir_y(rad, dir);
				
		part_type_direction(part, dir, dir, -2*delta, 0);
		part_particles_create(global.ps, spawnX, spawnY, part, 1);
				
		i++;
	}
}

function freeze(amount)
{
	var time = current_time + amount;
	while (current_time < time) {}
	delta = defaultFramesPerSecond / framesPerSecond;
}

function flash(amount)
{
	obj_fx.alpha = amount;
}

function setControllerVibration(left, right)
{
	obj_player.vibL = max(left, obj_player.vibL);
	obj_player.vibR = max(right, obj_player.vibR);
	shouldVib = true;
}

function resetControllerVibration()
{
	obj_player.vibL = 0;
	obj_player.vibR = 0;
	shouldVib = false;
}