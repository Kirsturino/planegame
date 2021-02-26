completed = false;
radius = 8;

curProgressSpeed = 0;
progressSpeed = 3;
progressAxl = 0.12;
progressFrc = 0.05;

progressLerp = 0;
progressPoint = 0;

//Graphics
rot = irandom(45);
destroyFade = 1;
destroyLerp = 1;
destroy = false;

//SFX
sfxTimer = 0;
sfxTimerMax = 10;
progressSound = snd_tick;
completionSound = snd_line_completion;
disappearSound = snd_pop;

//This is horrible gamemaker jank
alarm[0] = 1;