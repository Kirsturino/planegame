//Menu navigation
menuInput();

if (down)
{
	if (selected == pageLength - 1) { selected =  -1; }
	selected = clamp(selected + 1, 0, pageLength - 1);
}

if (up) 
{
	if (selected == 0) { selected =  pageLength; }
	selected = clamp(selected - 1, 0, pageLength - 1);
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
}

//Find the current line the player has selected
//and execute function specified for the line of the menu
var line = menuPages[page][selected];
var func = line[1];
var arg = line[2];	
func(arg);