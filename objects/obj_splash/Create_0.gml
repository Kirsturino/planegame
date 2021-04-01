setMusic(music.menu);

if (CONFIG != BUILD) { room_goto(rm_main_menu); }
else { startRoomTransition(transition.in, viewWidth/2, viewHeight/2, room); }
menuSurf = -1;

timer = 180;