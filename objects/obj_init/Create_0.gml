draw_set_font(fnt_default);

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

//Frame rate and particles are tied due to delta time
applyFrameRate();

//Init camera
initCamera();

alarm[0] = 1;