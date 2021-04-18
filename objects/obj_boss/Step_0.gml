playerBulletChecking();

//If player touch this, he dead
if (place_meeting(x, y, obj_player))
{
	obj_player.energy = 0;
	//startRoomTransition(transition.level_restart, obj_player.x, obj_player.y, room);
}

state();

//FX
if (global.updateParticles)
{
	part_particles_create(global.ps, x, y, global.smokePartBlack, 1);
}