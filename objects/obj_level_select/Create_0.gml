setMusic(music.menu);
startRoomTransition(30, transition.in, viewWidth/2, viewHeight/2);
levelSetNames =
[	
	"A Humble Beginning",
	"Learning To Fly",
	"Boosting Through",
	"Ro- Ro-, Rotate Your Plane",
	"Putting Things Together",
	"Shooting Gallery",
	"Line It Up",
	"Solid Obstacles",
	"Pockets",
	"Claustrophobia",
	"Testland"
];

selectedLevelSet = 0;
selectedLevel = 0;
levelSets = array_length(levelArray);
levels = 0;

//Calculate which levels will be available

//Get number of beaten levels
var beatenLevels = 0;
var levelSetSize = array_length(levelArray);
for (var i = 0; i < levelSetSize; i++)
{
	var length = array_length(levelArray[i]);
	for (var j = 0; j < length; j++)
	{
		if (global.levelProgressionArray[i][j])
			{ beatenLevels++; }
	}
}

//Check against unlock requirements and see if we have unlocked something new
var length = array_length(global.unlockRequirementArray);
for (var i = 0; i < length; i++)
{
	if (beatenLevels >= global.unlockRequirementArray[i])
	{
		if (i > global.unlockedLevelSets)
		{
			global.unlockedLevelSets = i;
			saveProgression();
			
			//More unlock pizazz to come
			
		}
	}
}

//Drawing
originX = 32;
originY = 64;
spaceX = 42;
spaceY = 86;
size = 16;
levelSurf = -1;

pushX = 0;
pushY = 0;
pushAmount = 4;

//Change room size to reflect UI, this is for camera placing purposes
room_height = levelSets*spaceY + size;

function levelInput()
{
	right =	gamepad_button_check_pressed(global.controller, gp_padr);
	left =	gamepad_button_check_pressed(global.controller, gp_padl);
	down =	gamepad_button_check_pressed(global.controller, gp_padd);
	up =	gamepad_button_check_pressed(global.controller, gp_padu);		
	confirm = gamepad_button_check_pressed(global.controller, gp_face1);
	back = gamepad_button_check_pressed(global.controller, gp_face2);
}

function moveLevelCamera()
{
	obj_camera_menu.targY = originY + selectedLevelSet*spaceY;
}

//Get last level player was in when entering room, defaults to first level
for (var i = 0; i < levelSets; i++)
{
	var length = array_length(levelArray[i]);
	for (var j = 0; j < length; j++)
	{
		if (global.lastLevel == levelArray[i][j])
		{
			selectedLevelSet = i;
			selectedLevel = j;
			levels = length;
			moveLevelCamera();
				
			break;
		}
	}
}