//Music
global.masterVolume = 10;
global.musicVolume = 10;
global.sfxVolume = 10;

//FX
global.cameraShakeScale = 10;

//Graphics
global.windowScale = 3;
global.fullscreen = CONFIG == BUILD;

#macro SETTINGS_NAME "settings.plane"

function saveSettings()
{
	if (file_exists(SETTINGS_NAME)) file_delete(SETTINGS_NAME);
	
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
	
	saveJSON(SETTINGS_NAME, settings);
}

function loadSettings()
{
	var settings = loadJSON(SETTINGS_NAME);
	
	if (settings != -1 && settings.version != VERSION)
	{
		file_delete(SETTINGS_NAME);
		settings = -1;
	}
	
	if (settings != -1)
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
	}
}