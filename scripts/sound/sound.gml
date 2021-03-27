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

global.sfxVolumeArray = [];
global.musicVolumeArray = [];

function initAudio()
{
	//Load audio
	if (!audio_group_is_loaded(ag_music))
		{ audio_group_load(ag_music); }
	if (!audio_group_is_loaded(ag_sfx))
		{ audio_group_load(ag_sfx); }

	//Get initial audio volumes before loading user settings
	var assets = tag_get_asset_ids("SFX", asset_sound);
	var length = array_length(assets);
	for (var i = 0; i < length; ++i)
	{
	    var asset = assets[i];
		global.sfxVolumeArray[i][0] = asset;
		global.sfxVolumeArray[i][1] = audio_sound_get_gain(asset);
	}
	
	var assets = tag_get_asset_ids("Music", asset_sound);
	var length = array_length(assets);
	for (var i = 0; i < length; ++i)
	{
	    var asset = assets[i];
		global.musicVolumeArray[i][0] = asset;
		global.musicVolumeArray[i][1] = audio_sound_get_gain(asset);
	}
}

function applySoundVolume()
{
	var length = array_length(global.sfxVolumeArray);
	for (var i = 0; i < length; ++i)
	{
		var asset = global.sfxVolumeArray[i][0];
		var volume = global.sfxVolumeArray[i][1]*global.sfxVolume*global.masterVolume;
	    audio_sound_gain(asset, volume, 0);
	}
	
	var length = array_length(global.musicVolumeArray);
	for (var i = 0; i < length; ++i)
	{
		var asset = global.musicVolumeArray[i][0];
		var volume = global.musicVolumeArray[i][1]*global.musicVolume*global.masterVolume;
	    audio_sound_gain(asset, volume, 0);
	}
}