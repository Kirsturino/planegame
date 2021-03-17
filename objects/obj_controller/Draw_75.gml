//Placeholder screen wipe transition
if (transitionTimer != 0 && (transitioningIn || transitioningOut))
{
	var trans = 1 - transitionTimer/transitionTimerMax;
	
	if (transitioningOut)
	{
		var trans = 1 - transitionTimer/transitionTimerMax;
		var drawX = -viewWidth + viewWidth*trans;
	}
	else if (transitioningIn)
	{
		var trans = transitionTimer/transitionTimerMax;
		var drawX = viewWidth*trans;
	}
	
	draw_sprite_ext(spr_pixel, 0, drawX, 0, viewWidth+32, viewHeight, 0, col_white, 1);
}