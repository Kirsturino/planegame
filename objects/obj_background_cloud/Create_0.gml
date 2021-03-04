//Cloud variables
cloudWidth = 128;
cloudHeight = 64;
col = col_white;

//Variance
widthVariance = 300;
heightVariance = 150;

//Generate random dimensions
width = cloudWidth + irandom(widthVariance);
height = cloudHeight + irandom(heightVariance);
relativeSize = (width/cloudWidth + height/cloudHeight) / 2;

//Parallax
parallaxMultiplier = 0.04 * relativeSize

//Moving
dir = 0;
cloudSpeedVariance = 0.1;
cloudSpeed = 0.2 + random(cloudSpeedVariance) * dir;

//Init surface
backgroundCloudSurface = -1;

//Shape variables
baseHeight = 8 * relativeSize;
circleFrequency = 16;
circleSize = 8 * relativeSize;
sizeVariance = 24;

function drawCloud()
{
	surface_set_target(backgroundCloudSurface);
	
	//Draw bottom of cloud
	draw_ellipse_color(0, height-baseHeight, width, height+baseHeight, col, col, false);
		
	//Draw rounded top
	var margin = (circleSize + sizeVariance) * 2;
	for (var i = margin; i < width-margin; i += circleFrequency)
	{
		var rad = circleSize + irandom(sizeVariance);
	    draw_circle_color(i, height-baseHeight, rad, col, col, false);
	}
	
	surface_reset_target();
}