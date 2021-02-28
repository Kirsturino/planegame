draw_set_font(fnt_default);

globalvar col_white;
col_white = make_color_rgb(255, 253, 240);
globalvar col_black;
col_black = make_color_rgb(21, 10, 31);
globalvar col_red;
col_red = make_color_rgb(180, 35, 19);

globalvar outlineThiccness;
outlineThiccness = 3;
globalvar lineThickness;
lineThickness = 3;
globalvar tempSurf;
tempSurf = -1;

//Load audio
audio_group_load(ag_music);
audio_group_load(ag_sfx);

//Room. Go. Next. Unga bunga
room_goto_next();