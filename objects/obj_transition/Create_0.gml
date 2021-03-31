enum transition
{
	level_next,
	level_restart,
	in,
	out
}

transitionTimer = 0;
transitionTimerMax = 0;
transitionType = transition.out;
transitionFunction = function() {};
drawFunction = function() {};
destination = 0;
transSurf = -1;

targX = 0;
targY = 0;

global.transitioning = true;

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
		destination = rm_level_select;
	}
	else if (level[1] != levelSetLength)
	{
		var levelSet = level[0];
		var lvl = level[1] + 1;
		destination = levelArray[levelSet][lvl];
	}
	else if (level[0] < array_length(levelArray) - 1)
	{
		var levelSet = level[0] + 1;
		var lvl = 0;
		destination = levelArray[levelSet][lvl];
	}
	else
	{
		destination = rm_level_select;
	}
	
	room_goto(destination);
}

function restartLevel()
{
	audio_group_stop_all(ag_sfx);
	room_restart();
}

alarm[0] = 1;