//Background variables
backgroundColor = col_skyblue;
//backgroundColor2 = make_color_rgb(70, 91, 231);
//backgroundColor3 = make_color_rgb(34, 45, 129);

//Set default particle system to be under everything this object draws
//For some reason we need to call this at the start of every room instead of setting it once, smh
part_system_depth(global.ps, 100);
draw_set_circle_precision(32);

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
masterWidth = viewWidth*2;
masterHeight = viewHeight*2;
masterCloudSurf = -1;