levelInput();

if (right)
{
	arrayX = clamp(arrayX + 1, 0, lengthX-1);
	lengthY = array_length(targArray[arrayX]);
	arrayY = min(arrayY, lengthY-1);
	moveLevelCamera();
}
if (left)
{
	arrayX = clamp(arrayX - 1, 0, lengthX-1);
	lengthY = array_length(targArray[arrayX]);
	arrayY = min(arrayY, lengthY-1);
	moveLevelCamera();
}

if (down) { arrayY++; }
if (up) { arrayY--; }
arrayY = clamp(arrayY, 0, lengthY-1);

if (confirm)
{
	room_goto(targArray[arrayX][arrayY]);
}