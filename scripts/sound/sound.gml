//A lot of stuff is also in the music controller object

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

function setMusic(music_type)
{
	with (obj_music_controller)
	{
		//If trying to set to same array, do nothing
		if (curMusicArray == music_type) { exit; }
		
		audio_stop_sound(curMusic);
		
		//Save the index for when we swap back to this music array
		curIndex = wrap(curIndex + 1, 0, array_length(masterArray[curMusicArray]) - 1);
		indexArray[curMusicArray] = curIndex;
		curMusicArray = music_type;
		
		curIndex = indexArray[music_type];
		curMusic = masterArray[curMusicArray][curIndex];
		audio_play_sound(curMusic, 0, false);
	}
}

/*

function enableMusic()
{
	with (obj_music_controller)
	{
		musicToggle = true;
	}
}

function disableMusic()
{
	with (obj_music_controller)
	{
		audio_stop_sound(curMusic);
		musicToggle = false;
	}
}