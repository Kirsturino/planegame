///@desc Generate path that can be found in the room

var length = 0;

with (obj_objective_line_point)
{
	if (owner == other.number)
	{
		length++;
	}
}

pointArray = array_create(length, 0);
pointArrayLength = length;

with (obj_objective_line_point)
{
	if (owner == other.number)
	{
		other.pointArray[index-1] = [x, y];
	}
}

//Find path boundaries
var surfLeft = pointArray[0][0];
var surfRight = pointArray[0][0];
var surfTop = pointArray[0][1];
var surfBottom = pointArray[0][1];

for (var i = 0; i < pointArrayLength; ++i)
{
	var _x = pointArray[i][0];
	if		(_x < surfLeft) { surfLeft =  _x; }
	else if (_x > surfRight) { surfRight =  _x; }
	
	var _y = pointArray[i][1];
	if		(_y < surfTop) { surfTop =  _y; }
	else if (_y > surfBottom) { surfBottom =  _y; }
}

surfMargin = 32;
surfWidth = surfRight - surfLeft + surfMargin;
surfHeight = surfBottom - surfTop + surfMargin;
surfX = surfLeft;
surfY = surfTop;
lineSurf = -1;

progressX = pointArray[0][0];
progressY = pointArray[0][1];
destroyX = pointArray[length-1][0]
destroyY = pointArray[length-1][1]

visible = true;