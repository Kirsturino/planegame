levelInput();

#region Menu controls

if (right)
{
	if (selectedLevel == levels - 1)
	{
		if (selectedLevelSet == levelSets - 1)
		{ selectedLevelSet = -1; }
		
		selectedLevelSet = clamp(selectedLevelSet + 1, 0, levelSets - 1);
		levels = array_length(levelArray[selectedLevelSet]);
		selectedLevel = -1;
	}
		
	selectedLevel = clamp(selectedLevel + 1, 0, levels - 1);
}

if (left)
{
	if (selectedLevel == 0)
	{
		if (selectedLevelSet == 0)
		{ selectedLevelSet = levelSets; }
		
		selectedLevelSet = clamp(selectedLevelSet - 1, 0, levelSets - 1);
		levels = array_length(levelArray[selectedLevelSet]);
		selectedLevel = levels;
	}
		
	selectedLevel = clamp(selectedLevel - 1, 0, levels - 1);
}

if (down)
{
	if (selectedLevelSet == levelSets - 1)
		{ selectedLevelSet = -1; }
		
	selectedLevelSet = clamp(selectedLevelSet + 1, 0, levelSets - 1);
	levels = array_length(levelArray[selectedLevelSet]);
	selectedLevel = min(selectedLevel, levels - 1);
}

if (up) 
{
	if (selectedLevelSet == 0)
		{ selectedLevelSet = levelSets; }
		
	selectedLevelSet = clamp(selectedLevelSet - 1, 0, levelSets - 1);
	levels = array_length(levelArray[selectedLevelSet]);
	selectedLevel = min(selectedLevel, levels - 1);
}

if (confirm)
{
	room_goto(levelArray[selectedLevelSet][selectedLevel]);
}

if (back)
{
	room_goto(rm_main_menu);
}

#endregion

if (left || right || up || down)
{
	//FX
	pushX += pushAmount*(right - left + down - up);
	pushY += pushAmount*(right - left + down - up);
	moveLevelCamera();
}

//FX Things
pushX = lerp(pushX, 0, 0.2*delta);
pushY = lerp(pushY, 0, 0.2*delta);