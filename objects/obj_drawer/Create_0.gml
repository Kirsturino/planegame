//Set default particle system to be under everything this object draws
//For some reason we need to call this at the start of every room instead of setting it once, smh
part_system_depth(global.ps, 100);
draw_set_circle_precision(32);

playerSurf = surface_create(64, 64);
//guiSurf = surface_create(viewWidth, viewHeight);
masterWidth = viewWidth*2;
masterHeight = viewHeight*2;
masterCloudSurf = surface_create(masterWidth, masterHeight);

//Outline shader stuff
upixelH = shader_get_uniform(shd_outline, "pixelH");
upixelW = shader_get_uniform(shd_outline, "pixelW");

playerTexelW = outlineThiccness * texture_get_texel_width(surface_get_texture(playerSurf));
playerTexelH = outlineThiccness * texture_get_texel_height(surface_get_texture(playerSurf));

//guiTexelW = outlineThiccness * texture_get_texel_width(surface_get_texture(guiSurf));
//guiTexelH = outlineThiccness * texture_get_texel_height(surface_get_texture(guiSurf));

dangerBlend = 0;

//Wave shader stuff
uTime = shader_get_uniform(shd_wave,"time");
uFrequency = shader_get_uniform(shd_wave,"frequency");
uIntensity = shader_get_uniform(shd_wave,"intensity");
frequency = 50.0;
intensity = 300.0; //Lower value = more intense
spd = 0.5;

uTimeOL = shader_get_uniform(shd_wave_outline,"time");
uFrequencyOL = shader_get_uniform(shd_wave_outline,"frequency");
uIntensityOL = shader_get_uniform(shd_wave_outline,"intensity");
frequencyOL = 50.0;
intensityOL = 400.0; //Lower value = more intense
spdOL = 1;
uWavePixelH = shader_get_uniform(shd_wave_outline, "pixelH");
uWavePixelW = shader_get_uniform(shd_wave_outline, "pixelW");

//Need to add offset due to master cloud surface moving with camera, causing the texture coordinates to shift with the camera
uXOffsetOL = shader_get_uniform(shd_wave_outline,"xOffset");
uYOffsetOL = shader_get_uniform(shd_wave_outline,"yOffset");

//Cloud surf stuff
cloudTexelW = outlineThiccness * texture_get_texel_width(surface_get_texture(masterCloudSurf));
cloudTexelH = outlineThiccness * texture_get_texel_height(surface_get_texture(masterCloudSurf));