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
	delta = defaultFramesPerSecond / global.speeds[global.framesPerSecond];
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

function draw_cube_width(_draw_x,_draw_y,_size,_point_h,_point_v,_colour,_width)
{
	
	var nodes = [[-1, -1, -1], [-1, -1, 1], [-1, 1, -1], [-1, 1, 1],
    [1, -1, -1], [1, -1, 1], [1, 1, -1], [1, 1, 1]];
 
	var edges = [[0, 1], [1, 3], [3, 2], [2, 0], [4, 5], [5, 7], [7, 6],
	[6, 4], [0, 4], [1, 5], [2, 6], [3, 7]];

	_point_h *= pi
	_point_v *= pi

	var sinX = sin(_point_h);
	var cosX = cos(_point_h);
 
	var sinY = sin(_point_v);
	var cosY = cos(_point_v);
	
	var number_of_nodes = array_length(nodes)
	for (var i = 0; i < number_of_nodes; ++i) {
	
		var node = nodes[i]

	    var _x = node[0];
	    var _y = node[1];
	    var _z = node[2];
 
	    node[0] = _x * cosX - _z * sinX;
	    node[2] = _z * cosX + _x * sinX;
 
	    _z = node[2];
 
	    node[1] = _y * cosY - _z * sinY;
	    node[2] = _z * cosY + _y * sinY;
	
		nodes[i] = node
	};

	draw_set_colour(_colour)

	var number_of_edges = array_length(edges)
	for (var i = 0; i < number_of_edges; ++i) {
	
		var edge = edges[i]
	
	    var p1 = nodes[edge[0]];
	    var p2 = nodes[edge[1]];
		draw_line_width(_draw_x+(p1[0]*_size),_draw_y+(p1[1]*_size),_draw_x+(p2[0]*_size),_draw_y+(p2[1]*_size),_width)

		draw_circle(_draw_x+(p1[0]*_size),_draw_y+(p1[1]*_size),_width/2,false)
	};
	
}