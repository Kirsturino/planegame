alpha = 0;

//Variables for danger indication
rectThickness = 16;
border = 0;
dangerSurf = -1;

//Wave shader stuff
uTime = shader_get_uniform(shd_wave,"time");
uFrequency = shader_get_uniform(shd_wave,"frequency");
uIntensity = shader_get_uniform(shd_wave,"intensity");
frequency = 50;
intensity = 500; //Lower value = more intense
spd = 40;