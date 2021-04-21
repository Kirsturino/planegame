playerBulletChecking();

//If player touch this, he dead
if (place_meeting(x, y, obj_player))
{
	obj_player.energy = 0;
	//startRoomTransition(transition.level_restart, obj_player.x, obj_player.y, room);
}

//Also, if boolet touch boss, boolet dead
//But only player boolet, you see, boss is smart like that
//Be like boss
var list = ds_list_create();
instance_place_list(x, y, obj_bullet, list, false);
var size = ds_list_size(list);
for (var i = 0; i < size; ++i)
{
	var blt = list[| i];
	if (blt != noone && blt.target != obj_player)
	{
		instance_destroy(blt);
		audio_play_sound(snd_boss_nom, 0, false);
	}
}
ds_list_destroy(list);

state();

//FX
if (global.updateParticles && destructionTimer > 60)
{
	part_particles_create(global.ps, x, y, global.smokePartBlack, 1);
}