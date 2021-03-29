enum music
{
	gameplay,
	menu
}

musicArray =
[	
	mus_gameplay_01,
	mus_gameplay_02,
	mus_gameplay_03,
	mus_gameplay_04,
	mus_gameplay_05,
	mus_gameplay_06,
	mus_gameplay_07,
	mus_gameplay_08,
	mus_gameplay_09
];
					
menuMusicArray = 
[
	mus_menu
];

masterArray = [musicArray, menuMusicArray];
curMusicArray = menuMusicArray;
musicIndex = 0;
curMusic = musicArray[musicIndex];
musicToggle = false;

//Music & SFX
musicTimerMax = 60;
musicTimer = musicTimerMax;

//Check on music every now and then, see how it's doing, y'know?
function checkMusic()
{
	musicTimer = approach(musicTimer, 0, 1);
	
	if (musicTimer == 0)
	{
		if (musicToggle)
		{
			if (audio_group_is_loaded(ag_music) && !audio_is_playing(curMusic))
			{
				curMusic = curMusicArray[musicIndex];
				audio_play_sound(curMusic, 0, false);
			
				var length = array_length(curMusicArray);
				if (musicIndex < length - 1)	{ musicIndex++; }
				else							{ musicIndex = 0; }
			}
		} else
		{
			audio_stop_sound(curMusic);
		}
		
		musicTimer = musicTimerMax;
	}
}