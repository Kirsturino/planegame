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
		
		version : VERSION
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
			file_delete(SETTINGS_FILE);
		} else
		{
			global.masterVolume		= settings.masterVolume;
			global.musicVolume		= settings.musicVolume;
			global.sfxVolume		= settings.sfxVolume;
										
			global.windowScale		= settings.windowScale;		
			global.fullscreen		= settings.fullscreen;
			global.framesPerSecond  = settings.framesPerSecond;
											
			global.cameraShakeScale	= settings.cameraShakeScale;
		
			//Do stuff after values have been loaded
			initCamera();
			applyFrameRate();
			applySoundVolume();
		}
	}
}