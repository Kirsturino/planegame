setMusic(music.menu);

if (CONFIG != BUILD) { alarm[0] = 1; }
else { startRoomTransition(transition.in, viewWidth/2, viewHeight/2, room); }
with (obj_transition) { transitionTimer = 120; transitionTimerMax = 120; }

menuSurf = -1;

timer = 240;