//Player bullets
function playerBulletBehaviour()
{
	x += hsp*delta;
	y += vsp*delta;

	if (global.updateParticles) part_particles_create(global.psTop, x, y, global.smokePartShort, 1);

	//Detect walls
	//This should be moved to the walls later if optimization is a problem
	var wallHor = collision_point(x+hsp, y, obj_danger_zone_solid, false, false);
	var wallVer = collision_point(x, y+vsp, obj_danger_zone_solid, false, false);

	if (wallHor != noone)
		{ hsp *= -1; }
	else if (wallVer != noone)
		{ vsp *= -1; }
}

function playerBulletDrawing()
{
	draw_circle_color(x, y, 4, col_black, col_black, false);
	draw_circle_color(x, y, 2, col_white, col_white, false);
}

//Boss bullets
function bossBulletBehaviour()
{
	x += hsp*delta;
	y += vsp*delta;

	if (global.updateParticles) part_particles_create(global.ps, x, y, global.smokePartShort, 1);
}

function bossBulletDrawing()
{
	draw_circle_color(x, y, 8, col_black, col_black, false);
	draw_circle_color(x, y, 6, col_red, col_red, false);
}