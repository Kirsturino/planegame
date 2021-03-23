global.musicArray =	[	mus_gameplay_01,
						mus_gameplay_02,
						mus_gameplay_03,
						mus_gameplay_04,
						mus_gameplay_05,
						mus_gameplay_06,
						mus_gameplay_07,
						mus_gameplay_08,
						mus_gameplay_09	];

global.musicIndex = 0;
global.curMusic = global.musicArray[global.musicIndex];

global.musicToggle = CONFIG == BUILD;

//Music & SFX
global.musicTimerMax = 60;
global.musicTimer = global.musicTimerMax;

//Check on music every now and then, see how it's doing, y'know?
function checkMusic()
{
	global.musicTimer = approach(global.musicTimer, 0, 1);
	
	if (global.musicTimer == 0)
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
		
		global.musicTimer = global.musicTimerMax;
	}
}