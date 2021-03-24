//Spawn extra logic objects because room inheritance sucks
instance_create_layer(0, 0, layer, obj_background);

//Keep track of level we're in
global.lastLevel = room;

//Reset level objective
global.objectiveCount = 0;

transitionTimerMax = 30;
transitionTimer = 0;
transitioningOut = false;
transitioningIn = true;
transitionFunction = nextLevel;

//Reset level if player is out of bounds
function checkForPlayer()
{
	var plr = obj_player;
	if (isOutsideRoom(plr.x, plr.y, 32, 32) && !transitioningOut)
	{
		audio_group_stop_all(ag_sfx);
		
		shakeCamera(100, 0, 20);
		audio_play_sound(snd_shoot_default, 0, false);
		
		startRoomTransition(restartLevel);
	}
}