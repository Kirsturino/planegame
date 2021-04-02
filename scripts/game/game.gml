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
	[rm_level_static_01, rm_level_static_02, rm_level_static_03, rm_level_static_04, rm_level_static_05, rm_level_static_06],
	[rm_level_moving_01, rm_level_moving_02, rm_level_moving_03, rm_level_moving_04, rm_level_moving_05, rm_level_moving_06]
];

//Progression stuff
//This is a bit messy to have everything as global stuff, but should not affect performance too much
global.levelProgressionArray = []; //This is mainly used by the level select object to see how to draw things, as such it is formatted in the same way
//Level progressionArray could be completely removed and moved over to the level select menu as an instance variable, however is not needed right now
global.completedLevels = []; //This is used for versioning help
global.unlockRequirementArray = []; //Used to see which levels player can access
global.unlockedLevelSets = 0; //Current amount of level sets player can access, used in level select menu

function saveProgression()
{
	var struct =
	{
		unlockedLevelSets : global.unlockedLevelSets,
		completedLevelsArray : global.completedLevels,
		warning : "Please don't manually edit this save file, thanks!"
	};
	
	saveJSON(SAVE_FILE, struct);
}
	
function initSaveFile()
{
	//Copy level array and set all entries to 0 aka false
	//This flags all levels as not cleared
	var levelSetSize = array_length(levelArray);
	for (var i = 0; i < levelSetSize; i++)
	{
		var length = array_length(levelArray[i]);
		for (var j = 0; j < length; j++)
		{
			global.levelProgressionArray[i][j] = false;
		}
	}
	
	saveProgression();
}

function loadSave()
{
	if (!file_exists(SAVE_FILE))
	{
		initSaveFile();
	} else
	{
		//Load save file and copy it over to a global variable for later use
		var save = loadJSON(SAVE_FILE);
		global.unlockedLevelSets = save.unlockedLevelSets;
		global.completedLevels = save.completedLevelsArray;
	}
}


var iteration = 0;
var levelSetSize = array_length(levelArray);
for (var i = 0; i < levelSetSize; i++)
{
	//Procedurally generate unlock requirements. Becomes more strict as levels progress
	//TODO: Manually design this so it's more linear at start and opens up later so people can skip hard levels
	global.unlockRequirementArray[i] = max(0, iteration - (levelSetSize - i));
	var length = array_length(levelArray[i]);
	for (var j = 0; j < length; j++)
		{ iteration++; }
}


global.lastLevel = rm_level_babby_controls_01;
global.objectiveCount = 0;

global.transitioning = false;
function startRoomTransition(type, x, y, room)
{
	if (!global.transitioning)
	{
		with (instance_create_layer(0, 0, "Top", obj_transition))
		{
			transitionType = type;
			targX = x;
			targY = y;
			destination = room;
		}
	}
	
	global.transitioning = true;
}


//Progression things
function markLevelAsCleared(room)
{
	if (!arrayContains(global.completedLevels, room_get_name(room)))
	{
		array_push(global.completedLevels, room_get_name(room));
	}
	
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

//Misc. things
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