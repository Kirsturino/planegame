//Menu navigation
menuInput();

if (up || down)
{
	if (selected == pageLength - 1 && down)	{ selected =  -1; }
	else if (selected == 0 && up)			{ selected =  pageLength; }
	
	var change = down - up;
	selected = clamp(selected + change, 0, pageLength - 1);
	
	//FX
	pushX = 0;
	audio_play_sound(snd_ui_updown, 0, false);
}

if (back && page != pages.main)
{
	//Pressing back will take you to the destination of the "back" button
	//This assumes the back button is always the last button of the menu
	var lastLine = menuPages[page][pageLength - 1];
	var arg = lastLine[2];

	//If we're in options menu, save settings
	if (page == pages.audio || page == pages.graphics)
		{ saveSettings(); }
	
	//This is changePage function without need to confirm
	page = arg[0];
	pageLength = array_length(menuPages[page]);
	selected = 0;
	
	//FX
	pushX = 0;
	audio_play_sound(snd_ui_back, 0, false);
}

//FX
if (left || right)
{
	settingPushX = (right - left) * maxPushX/4;
}

//Find the current line the player has selected
//and execute function specified for the line of the menu
var line = menuPages[page][selected];
var func = line[1];
var arg = line[2];	
func(arg);

//Graphics
pushX = lerp(pushX, maxPushX, 0.2*delta);
settingPushX = lerp(settingPushX, 0, 0.2*delta);