//Basic menu functionality
function createMenu(menu1)
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
	room_goto(rm_level_select);
}

function showCredits()
{
	changePage([pages.credits]);
	instance_create_layer(0, 0, layer, obj_credits);
}

function changePage(arg)
{
	page = arg[0];
	pageLength = array_length(menuPages[page]);
	selected = 0;
}

function quitGame()
{
	game_end();
}


enum pages
{
	main,
	settings,
	credits
}

//Menu variables
menuMain = createMenu
(
	["Play", toLevelSelect, []],
	["Settings", changePage, [pages.settings]],
	["Credits", showCredits, []],
	["Quit", quitGame, []]
);

menuSettings = createMenu
(
	["Back", changePage, [pages.main]]
)

menuCredits = createMenu
(
	["Back", changePage, [pages.main]]
)

page = 0;
//PAGES MUST BE IN THE SAME ORDER AS THE ENUMERATOR
menuPages = [menuMain, menuSettings, menuCredits];
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