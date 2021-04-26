enum music
{
	gameplay,
	menu,
	boss,
	credits
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
	mus_gameplay_09,
	mus_gameplay_10,
	mus_gameplay_11,
	mus_gameplay_12
];
					
menuMusicArray = 
[
	mus_menu_01,
	mus_menu_02,
	mus_menu_03,
	mus_menu_04,
	mus_menu_05
];

bossMusicArray =
[
	mus_boss,
	mus_boss
]

creditsMusicArray =
[
	mus_menu_03,
	mus_menu_03
]

musicIndex = 0;
menuMusicIndex = 0;
bossMusicIndex = 0;
creditsMusicIndex = 0;
curMusic = musicArray[musicIndex];

masterArray = [musicArray, menuMusicArray, bossMusicArray, creditsMusicArray];
indexArray = [musicIndex, menuMusicIndex, bossMusicIndex, creditsMusicIndex];
curMusicArray = music.menu;
curIndex = menuMusicIndex;

//Music & SFX
musicTimerMax = 60;
musicTimer = musicTimerMax;

//Check on music every now and then, see how it's doing, y'know?
function checkMusic()
{
	musicTimer = approach(musicTimer, 0, 1);
	
	if (musicTimer == 0)
	{
		if (audio_group_is_loaded(ag_music) && !audio_is_playing(curMusic))
		{
			curMusic = masterArray[curMusicArray][curIndex];
			audio_play_sound(curMusic, 0, false);
			
			var length = array_length(masterArray[curMusicArray]);
			if (curIndex < length - 1)	{ curIndex++; }
			else						{ curIndex = 0; }
		}
		
		musicTimer = musicTimerMax;
	}
}