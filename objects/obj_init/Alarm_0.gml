//Load user stuff
var ver = loadSettings();

if (ver != VERSION) { updateSaveToCurrentVersion(); }
else				{ loadSave(); }

//Center window, because gamemaker doesn't do this automatically for some reason when building???
window_center();
window_set_fullscreen(global.fullscreen);

//Room. Go. Next. Unga bunga
room_goto_next();