//Music
global.masterVolume = 1;
global.musicVolume = 1;
global.sfxVolume = 1;

//FX
global.cameraShakeScale = 1;

//Graphics
global.windowScale = 3;
global.fullscreen = true;

#macro SETTINGS_FILE "settings.plane"

function saveSettings()
{
	if (file_exists(SETTINGS_FILE)) file_delete(SETTINGS_FILE);
	
	var settings =
	{
		masterVolume :		global.masterVolume,
		musicVolume :		global.musicVolume,
		sfxVolume :			global.sfxVolume,
							
		windowScale :		global.windowScale,
		fullscreen :		global.fullscreen,
		framesPerSecond:	global.framesPerSecond,
		
		cameraShakeScale :	global.cameraShakeScale,
		color : col_plane,
		
		version : VERSION,
		warning : "Please don't manually edit this options file, thanks!"
	};
	
	saveJSON(SETTINGS_FILE, settings);
}

function loadSettings()
{
	var settings = loadJSON(SETTINGS_FILE);
	
	if (settings != -1)
	{
		if (settings.version != VERSION)
		{
			//If there are new settings that get saved, just reset to default
			file_delete(SETTINGS_FILE);
			saveSettings();
		} else
		{
			global.masterVolume		= settings.masterVolume;
			global.musicVolume		= settings.musicVolume;
			global.sfxVolume		= settings.sfxVolume;
										
			global.windowScale		= settings.windowScale;		
			global.fullscreen		= settings.fullscreen;
			global.framesPerSecond  = settings.framesPerSecond;
											
			global.cameraShakeScale	= settings.cameraShakeScale;
			
			col_plane = settings.color;
		
			//Do stuff after values have been loaded
			initCamera();
			applyFrameRate();
			applySoundVolume();
		}
		
		//Return SAVE version, not settings
		return settings.version;
	} else
	{
		saveSettings();
	}
}