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
function toLevelSelect()
{
	if (confirm) { room_goto(rm_level_select); }
}

function showCredits()
{
	if (confirm)
	{
		changePage([pages.credits]);
		instance_create_layer(0, 0, layer, obj_credits);
	}
}

function changePage(arg)
{
	if (confirm)
	{
		page = arg[0];
		pageLength = array_length(menuPages[page]);
		selected = 0;
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
	
		var change = (upperLimit - lowerLimit)/stepAmount;
		
		value = clamp(	value + (right - left)*change,
						lowerLimit,
						upperLimit);
		
		variable_global_set(name, value);
	}
}

function changeDisplayMode(arg)
{
	changeValue(arg);
	
	if (left || right) { window_set_fullscreen(!global.fullscreen); }
}

function changeResolution(arg)
{
	changeValue(arg);
	
	if (left || right) { initCamera(); }
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
	{
		applySoundVolume();
		audio_play_sound(snd_pop, 0, false); //Placeholder
	}
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
	["Play", toLevelSelect, [-1]],
	["Settings", changePage, [pages.settings]],
	["Credits", showCredits, [-1]],
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
	["Display", changeDisplayMode, ["fullscreen", 0, 1, 1, display.shift_string, ["Fullscreen", "Window"]]],
	["Resolution", changeResolution, ["windowScale", 1, 4, 3, display.shift_string, ["480x270", "960x540", "1440x720", "1920x1080"]]],
	["FPS", changeFrameRate, ["framesPerSecond", 0, 3, 3, display.shift_string, ["30", "60", "144", "240"]]],
	["Camera FX", changeValue, ["cameraShakeScale", 0, 1, 10, display.shift]],
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