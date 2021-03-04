//Spawn extra logic objects because room inheritance sucks
instance_create_layer(0, 0, layer, obj_background);

//Reset level objective
global.objectiveCount = 0;

//Level transition
function nextLevel()
{
	audio_group_stop_all(ag_sfx);
	room_goto_next();
}

function restartLevel()
{
	audio_group_stop_all(ag_sfx);
	room_restart();
}

transitionTimerMax = 30;
transitionTimer = 0;
transitioningOut = false;
transitioningIn = true;
transitionFunction = nextLevel;

//Music & SFX
musicTimerMax = 60;
musicTimer = musicTimerMax;

//Check on music every now and then, see how it's doing, y'know?
function checkMusic()
{
	musicTimer = approach(musicTimer, 0, 1);
	
	if (musicTimer == 0)
	{
		if (global.musicToggle)
		{
			if (audio_group_is_loaded(ag_music) && !audio_is_playing(global.curMusic))
			{
				global.curMusic = global.musicArray[global.musicIndex];
				audio_play_sound(global.curMusic, 0, false);
			
				var length = array_length(global.musicArray);
				if (global.musicIndex < length - 1) { global.musicIndex++; }
				else							{ global.musicIndex = 0; }
			}
		} else
		{
			audio_stop_sound(global.curMusic);
		}
		
		musicTimer = musicTimerMax;
	}
}

checkMusic();

//Reset level if player is out of bounds
function checkForPlayer()
{
	var plr = obj_player;
	if (isOutsideRoom(plr.x, plr.y, 32, 32) && !transitioningOut)
	{
		audio_group_stop_all(ag_sfx);
		
		shakeCamera(100, 0, 20);
		audio_play_sound(snd_shoot_default, 0, false);
		
		transitionFunction = restartLevel;
		startRoomTransition();
	}
}