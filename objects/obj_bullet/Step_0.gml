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

destroyTimer = approach(destroyTimer, 0, 1);
if (destroyTimer == 0) { instance_destroy(); }