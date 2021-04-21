//Cloud variables
cloudWidth = 86;
cloudHeight = 32;
col = col_cloudblue;

//Variance
widthVariance = 256;
heightVariance = 128;

//Generate random dimensions
width = cloudWidth + irandom(widthVariance);
height = cloudHeight + irandom(heightVariance);
relativeSize = (width/cloudWidth + height/cloudHeight) / 2;

//No parallax for now, as these are meant to look like they're really far away
parallaxMultiplier = 0.7;

//Init surface
backgroundCloudSurface = -1;

//Shape variables
baseHeight = 4 * relativeSize;
circleFrequency = 4 * relativeSize;
circleSize = 6 * relativeSize;
sizeVariance = 12;

function drawCloud()
{
	surface_set_target(backgroundCloudSurface);
	draw_clear_alpha(col_black, 0);
	
	//Draw bottom of cloud
	draw_ellipse_color(0, height-baseHeight, width, height+baseHeight, col, col, false);
		
	//Draw rounded top
	var margin = (circleSize + sizeVariance * 1.5);
	for (var i = margin; i < width-margin; i += circleFrequency)
	{
		var rad = circleSize + irandom(sizeVariance);
	    draw_circle_color(i, height-baseHeight, rad, col, col, false);
	}
	
	surface_reset_target();
}