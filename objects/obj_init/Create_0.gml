draw_set_font(fnt_default);

//Color shorthand
globalvar col_white;
col_white = make_color_rgb(255, 253, 240);
globalvar col_black;
col_black = make_color_rgb(21, 10, 31);
globalvar col_red;
col_red = make_color_rgb(180, 35, 19);
globalvar col_skyblue;
col_skyblue = make_color_rgb(125, 242, 207);

globalvar outlineThiccness;
outlineThiccness = 3;
globalvar lineThickness;
lineThickness = 3;

//Load audio
audio_group_load(ag_music);
audio_group_load(ag_sfx);

//Init controller
getController();

//Init particle systems
global.ps = part_system_create_layer(layer_get_id("Instances"), true);
part_system_depth(global.ps, 100);
part_system_automatic_draw(global.ps, false);
global.psTop = part_system_create_layer(layer_get_id("Top"), true);
part_system_automatic_draw(global.psTop, false);

//Init camera
initCamera();

alarm[0] = 1;