//Menu navigation
menuInput();

if (down)
{
	selected = clamp(selected + 1, 0, pageLength - 1);
}

if (up) 
{
	selected = clamp(selected - 1, 0, pageLength - 1);
}

if (confirm)
{
	var line = menuPages[page][selected];
	var func = line[1];
	var arg = line[2];
	
	//Execute function specified for the line of the menu
	func(arg);
}

if (back)
{
	//Determine which page pressing back should throw you to
	var destination;
	switch(page)
	{
		case pages.settings:
		case pages.credits:
			destination = pages.main;
		break;
	}
	
	changePage([pages.main]);
}