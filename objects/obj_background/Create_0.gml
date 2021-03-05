//Disable editor background and make this object go at bottom draw order
layer_destroy(layer_get_id("Background"));
layer = layer_create(300, "Background");

//Cloud generation
var cloudAmount = round(room_width * room_height / 40000);
var cloudDirection = choose(1, -1);

for (var i = 0; i < cloudAmount; i++;)
{
	//Somewhat even distribution
	var spawnY = room_height * i / cloudAmount;
    var cloud = instance_create_layer(	irandom(room_width), 
										spawnY, 
										layer,
										obj_background_cloud);
	
	//Cloud movement
	cloud.dir = cloudDirection;
}

//City surface init
citySurf = -1;

//City variables
buildingFrequency = 8;
buildingFrequencyVariance = 16;
buildingHeight = 64;
buildingWidth = 16;
buildingHeightVariance = 64;
buildingWidthVariance = 16;

surfWidth = viewWidth*2;
surfHeight = buildingHeight+buildingHeightVariance;

function generateCityScape()
{
	citySurf = surface_create(surfWidth, surfHeight);
	
	surface_set_target(citySurf);
	
	for (var i = 0; i < surfWidth; i += buildingFrequency + irandom(buildingFrequencyVariance);)
	{
		var width = i + buildingWidth + irandom(buildingWidthVariance);
		var height = surfHeight - buildingHeight + irandom(buildingHeightVariance);
		var col = col_black;
		
		draw_rectangle_color(i, height, width, surfHeight, col, col, col, col, false);
	}
	
	surface_reset_target();
}