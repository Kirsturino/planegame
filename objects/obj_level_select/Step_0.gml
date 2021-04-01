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

if (confirm && !global.transitioning)
{
	setMusic(music.gameplay);
	audio_play_sound(snd_ui_confirm, 0, false);
	
	var _x = originX + selectedLevel*spaceX;
	var _y = originY + selectedLevelSet*spaceY;
	startRoomTransition(transition.out, _x, _y, levelArray[selectedLevelSet][selectedLevel]);
}

if (back && !global.transitioning)
{
	audio_play_sound(snd_ui_back, 0, false);
	var _x = viewWidth/2 + camera_get_view_x(view);
	var _y = viewHeight/2 + camera_get_view_y(view);
	startRoomTransition(transition.out, _x, _y, rm_main_menu);
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