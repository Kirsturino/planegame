col = col_white;

cloudSurf = -1;
topCloudSurf = -1;

onScreen = true;

frequency = 8;
radius = 16;
positionVariance = 6;
radiusVariance = 6;
surfMargin = 64;
margin = 20;

topFrequency = 16;
topRadius = 6;
topPositionVariance = 6;
topRadiusVariance = 4;
topSurfMargin = 32;
topMargin = 36;

function createCloudSurface(surf, freq, posVar, rad, radVar, marg, surfMarg, col, fill)
{
	var surfWidth = sprite_width+surfMarg;
	var surfHeight = sprite_height+surfMarg;
	tempSurf = surface_create(surfWidth, surfHeight);
	
	surface_set_target(tempSurf);
	
	var totalMarg = marg/2 + surfMarg/2;
	var xLimit = surfWidth - totalMarg;
	var yLimit = surfHeight - totalMarg;
	
	//Fill
	if (fill)
	{ draw_rectangle_color(totalMarg, totalMarg, surfWidth-totalMarg, surfHeight-totalMarg, col, col, col, col, false); }
	
	//Make blobby cloud edges
	if (totalMarg < xLimit && totalMarg < yLimit)
	{
		for (var i = totalMarg; i <= xLimit; i += freq;)
		{
		    for (var j = totalMarg; j <= yLimit; j += freq;)
			{
				var _x = i + irandom_range(-posVar, posVar);
				var _y = j + irandom_range(-posVar, posVar);
			    draw_circle_color(_x, _y, max(0, rad + irandom_range(-radVar, radVar)), col, col, false);
			}
		}
	}
	
	surface_reset_target();
	
	surface_copy(surf, 0, 0, tempSurf);
	surface_free(tempSurf);
}