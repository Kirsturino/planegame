//Center window, because gamemaker doesn't do this automatically for some reason when building???
window_center();
window_set_fullscreen(CONFIG == BUILD);

//Load user settings
loadSettings();

//Room. Go. Next. Unga bunga
room_goto_next();