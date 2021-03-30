#macro SAVE_FILE "save.nyoom"

globalvar levelArray;
levelArray = 
[	
	[rm_level_babby_controls_01, rm_level_babby_controls_02, rm_level_babby_controls_03, rm_level_babby_01, rm_level_babby_02, rm_level_babby_03], 
	[rm_level_01, rm_level_02, rm_level_03, rm_level_04, rm_level_05],
	[rm_level_21, rm_level_22, rm_level_23, rm_level_24, rm_level_25],
	[rm_level_06, rm_level_07, rm_level_08, rm_level_09, rm_level_10],
	[rm_rot_ins_01, rm_rot_ins_02, rm_rot_ins_03, rm_rot_ins_04, rm_level_small_01],
	[rm_level_11, rm_level_11_5, rm_level_12, rm_level_13, rm_level_14, rm_level_14_5, rm_level_15],
	[rm_level_16, rm_level_17, rm_level_18, rm_level_19, rm_level_20, rm_level_small_02],
	[rm_level_wall_tutorial, rm_level_26, rm_level_27, rm_level_28, rm_level_29, rm_level_30],
	[rm_pockets_01, rm_pockets_02, rm_pockets_03, rm_pockets_04, rm_pockets_05],
	[rm_level_static_01, rm_level_static_02, rm_level_static_03, rm_level_static_04, rm_level_static_05, rm_level_static_06]
];

//Progression stuff
global.levelProgressionArray = [];
global.unlockRequirementArray = [];
global.unlockedLevelSets = 0;

function saveProgression()
{
	var struct =
	{
		completedArray : global.levelProgressionArray,
		unlockedLevelSets : global.unlockedLevelSets
	};
	
	saveJSON(SAVE_FILE, struct);
}

function loadSave()
{
	if (!file_exists(SAVE_FILE))
	{
		//Copy level array and set all entries to 0 aka false
		//This flags all levels as not cleared
		var iteration = 0;
		var levelSetSize = array_length(levelArray);
		for (var i = 0; i < levelSetSize; i++)
		{
			var length = array_length(levelArray[i]);
			for (var j = 0; j < length; j++)
			{
				global.levelProgressionArray[i][j] = false;
				iteration++;
			}
		}
	
		saveProgression();
	} else
	{
		//Load save file and copy it over to a global variable for later use
		var save = loadJSON(SAVE_FILE);
		global.levelProgressionArray = save.completedArray;
		global.unlockedLevelSets = save.unlockedLevelSets;
	}
}

var iteration = 0;
var levelSetSize = array_length(levelArray);
for (var i = 0; i < levelSetSize; i++)
{
	//Procedurally generate unlock requirements. Becomes more strict as levels progress
	global.unlockRequirementArray[i] = max(0, iteration - (levelSetSize - i));
	var length = array_length(levelArray[i]);
	for (var j = 0; j < length; j++)
		{ iteration++; }
}

global.lastLevel = rm_level_babby_controls_01;
global.objectiveCount = 0;

function startRoomTransition(func)
{
	obj_controller.transitioningOut = true;
	obj_controller.transitionFunction = func;
}

//Level transition
function nextLevel()
{
	audio_group_stop_all(ag_sfx);
	
	//See if next level has actually been unlocked
	//If not, take player to level select screen
	var level = findLevelFromArray(room);
	var levelSetLength = array_length(levelArray[level[0]]) - 1;
	if (level[1] == levelSetLength && level[0] + 1 > global.unlockedLevelSets)
	{
		room_goto(rm_level_select);
	}
	else if (level[1] != levelSetLength)
	{
		var levelSet = level[0];
		var lvl = level[1] + 1;
		room_goto(levelArray[levelSet][lvl]);
	}
	else if (level[0] < array_length(levelArray) - 1)
	{
		var levelSet = level[0] + 1;
		var lvl = 0;
		room_goto(levelArray[levelSet][lvl]);
	}
	else
	{
		room_goto(rm_level_select);
	}
}

function restartLevel()
{
	audio_group_stop_all(ag_sfx);
	room_restart();
}

//Misc. things
//Progression things
function markLevelAsCleared(room)
{
	var levelSetSize = array_length(levelArray);
	for (var i = 0; i < levelSetSize; i++)
	{
		var length = array_length(levelArray[i]);
		for (var j = 0; j < length; j++)
		{
			if (room == levelArray[i][j])
			{
				global.levelProgressionArray[i][j] = true;
				break;
			}
		}
	}
	
	saveProgression();
}

function findLevelFromArray(room)
{
	var levelSetSize = array_length(levelArray);
	for (var i = 0; i < levelSetSize; i++)
	{
		var length = array_length(levelArray[i]);
		for (var j = 0; j < length; j++)
		{
			if (room == levelArray[i][j])
				{ return [i, j]; }
		}
	}
	
	return -1;
}