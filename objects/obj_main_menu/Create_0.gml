setMusic(music.menu);
startRoomTransition(30, transition.in, viewWidth/2, viewHeight/2);

//Basic menu functionality
function createMenu()
{
	var menu;
	
	for (var i = 0; i < argument_count; i++)
	{
		menu[i] = argument[i];
	}
	
	return menu;
}

//Menu functions
function playGame()
{
	if (confirm)
	{
		if (array_length(global.completedLevels) == 0)
		{
			startRoomTransition(30, transition.out, viewWidth/2, viewHeight/2, rm_level_babby_controls_01);
		} else
		{
			startRoomTransition(30, transition.out, viewWidth/2, viewHeight/2, rm_level_select);
		}
		
		audio_play_sound(snd_ui_confirm, 0, false);
	}
}

function showCredits(arg)
{
	changePage(arg);
	
	if (confirm)
		{ instance_create_layer(0, 0, layer, obj_credits); }
}

function changePage(arg)
{
	if (confirm)
	{
		page = arg[0];
		pageLength = array_length(menuPages[page]);
		selected = 0;
		
		//FX
		pushX = 0;
		audio_play_sound(snd_ui_confirm, 0, false);
	}
}

function quitGame()
{
	if (confirm) { game_end(); }
}

function changeValue(arg)
{
	if (left || right)
	{
		var name = arg[0];
		var value = variable_global_get(name);
		var lowerLimit = arg[1];
		var upperLimit = arg[2];
		var stepAmount = arg[3];
	
		var change = (right - left)*(upperLimit - lowerLimit)/stepAmount;
		
		if (value + change < lowerLimit || value + change > upperLimit)
			{ audio_play_sound(snd_ui_rightleft_wrong, 0, false); }
		else
			{ audio_play_sound(snd_ui_rightleft, 0, false); }
		
		value = clamp(	value + change,
						lowerLimit,
						upperLimit);
		
		variable_global_set(name, value);
	}
}

function centerWindow()
{
	alarm[0] = 1;
}

function changeDisplayMode(arg)
{
	changeValue(arg);
	
	if (left || right)
	{
		window_set_fullscreen(global.fullscreen);
		
		if (!global.fullscreen)
		{
			initCamera();
			centerWindow();
		}
	}
}

function changeResolution(arg)
{
	changeValue(arg);
	
	if (left || right)
	{
		initCamera();
		centerWindow();
	}
}

function changeFrameRate(arg)
{
	changeValue(arg);
	
	if (left || right) { applyFrameRate(); }
}

function changeVolume(arg)
{
	changeValue(arg);
	
	if (left || right)
		{ applySoundVolume(); }
}

function exitSettings(arg)
{
	changePage(arg);
	
	if (confirm) { saveSettings(); }
}

//PAGES MUST BE IN THE SAME ORDER AS THE MENUPAGES ARRAY
enum pages
{
	main,
	settings,
	credits,
	audio,
	graphics
}

enum display
{
	shift,
	shift_string,
	toggle
}

//Menu variables
menuMain = createMenu
(
	["Play", playGame, [pages.main]],
	["Settings", changePage, [pages.settings]],
	["Credits", showCredits, [pages.credits]],
	["Quit", quitGame, [-1]]
);

menuSettings = createMenu
(
	["Audio", changePage, [pages.audio]],
	["Graphics", changePage, [pages.graphics]],
	["Back", changePage, [pages.main]]
);

menuCredits = createMenu
(
	["Back", changePage, [pages.main]]
);

menuAudio = createMenu
(
	["Master", changeVolume, ["masterVolume", 0, 1, 10, display.shift]],
	["Music", changeVolume,	["musicVolume", 0, 1, 10, display.shift]],
	["SFX", changeVolume,	["sfxVolume", 0, 1, 10, display.shift]],
	["Back", exitSettings, [pages.settings]]
);

menuGraphics = createMenu
(
	["Display", changeDisplayMode, ["fullscreen", 0, 1, 1, display.shift_string, ["Window", "Fullscreen"]]],
	["Resolution", changeResolution, ["windowScale", 1, 4, 3, display.shift_string, ["480x270", "960x540", "1440x720", "1920x1080"]]],
	["FPS", changeFrameRate, ["framesPerSecond", 0, 3, 3, display.shift_string, ["30", "60", "144", "240"]]],
	["Camera FX", changeValue, ["cameraShakeScale", 0, 2, 20, display.shift]],
	["Back", exitSettings, [pages.settings]]
);


page = 0;
//PAGES MUST BE IN THE SAME ORDER AS THE ENUMERATOR
menuPages = [menuMain, menuSettings, menuCredits, menuAudio, menuGraphics];
pageLength = array_length(menuPages[page]);
selected = 0;

//Input
function menuInput()
{
	right =	gamepad_button_check_pressed(global.controller, gp_padr);
	left =	gamepad_button_check_pressed(global.controller, gp_padl);
	down =	gamepad_button_check_pressed(global.controller, gp_padd);
	up =	gamepad_button_check_pressed(global.controller, gp_padu);		
	confirm = gamepad_button_check_pressed(global.controller, gp_face1);
	back = gamepad_button_check_pressed(global.controller, gp_face2);
}

//Graphics
menuSurf = -1;
pushX = 0;
maxPushX = 8;
settingPushX = 0;