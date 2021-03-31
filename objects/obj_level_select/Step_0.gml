levelInput();

#region Menu controls

if (right)
{
	if (selectedLevel == levels - 1)
	{
		if (selectedLevelSet == global.unlockedLevelSets)
		{ selectedLevelSet = -1; }
		
		selectedLevelSet = clamp(selectedLevelSet + 1, 0, global.unlockedLevelSets);
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
		{ selectedLevelSet = global.unlockedLevelSets + 1; }
		
		selectedLevelSet = clamp(selectedLevelSet - 1, 0, global.unlockedLevelSets);
		levels = array_length(levelArray[selectedLevelSet]);
		selectedLevel = levels;
	}
		
	selectedLevel = clamp(selectedLevel - 1, 0, levels - 1);
}

if (down)
{
	if (selectedLevelSet == global.unlockedLevelSets)
		{ selectedLevelSet = -1; }
		
	selectedLevelSet = clamp(selectedLevelSet + 1, 0, global.unlockedLevelSets);
	levels = array_length(levelArray[selectedLevelSet]);
	selectedLevel = min(selectedLevel, levels - 1);
}

if (up) 
{
	if (selectedLevelSet == 0)
		{ selectedLevelSet = global.unlockedLevelSets + 1; }
		
	selectedLevelSet = clamp(selectedLevelSet - 1, 0, global.unlockedLevelSets);
	levels = array_length(levelArray[selectedLevelSet]);
	selectedLevel = min(selectedLevel, levels - 1);
}

if (confirm)
{
	setMusic(music.gameplay);
	audio_play_sound(snd_ui_confirm, 0, false);
	startRoomTransition(30, transition.out, viewWidth/2, viewHeight/2, levelArray[selectedLevelSet][selectedLevel]);
}

if (back)
{
	audio_play_sound(snd_ui_back, 0, false);
	startRoomTransition(30, transition.out, viewWidth/2, viewHeight/2, rm_main_menu);
}

#endregion

if (left || right || up || down)
{
	//FX
	pushX += pushAmount*(right - left + down - up);
	pushY += pushAmount*(right - left + down - up);
	moveLevelCamera();
	
	audio_play_sound(snd_ui_updown, 0, false);
}

//FX Things
pushX = lerp(pushX, 0, 0.2*delta);
pushY = lerp(pushY, 0, 0.2*delta);