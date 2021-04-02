//Load user stuff
loadSettings();
updateSaveToCurrentVersion();

if (CONFIG != BUILD)
{
	global.unlockedLevelSets = array_length(global.levelArray) - 1;
}

//Center window, because gamemaker doesn't do this automatically for some reason when building???
window_center();
window_set_fullscreen(global.fullscreen);

//Room. Go. Next. Unga bunga
room_goto_next();