timer = approach(timer, 0, 1);
if (timer == 0)
{
	if (CONFIG == BUILD) { enableMusic(); }
	room_goto(rm_main_menu);
}