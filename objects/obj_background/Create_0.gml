//Disable editor background and make this object go at bottom draw order
layer_destroy(layer_get_id("Background"));
layer = layer_create(300, "Background");

//Cloud generation
var cloudAmount = round(room_width * room_height / 30000);
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
	cloud.cloudSpeedVariance = 0.2;
	cloud.cloudSpeed = (0.05 + random(cloud.cloudSpeedVariance)) * cloudDirection;
}

instance_create_layer(0, 0, layer, obj_background_sun);

//City surface init
citySurf = -1;

//City variables
buildingFrequency = 8;
buildingFrequencyVariance = 16;
buildingHeight = 128;
buildingWidth = 32;
buildingHeightVariance = 128;
buildingWidthVariance = 32;

surfWidth = viewWidth*2;
surfHeight = buildingHeight+buildingHeightVariance;
cityParallaxMultiplier = 0.5;
cityColor = col_cityblue;
citySideColor = make_color_rgb(37, 49, 94);

function generateCityScape()
{
	citySurf = surface_create(surfWidth, surfHeight);
	
	surface_set_target(citySurf);
	draw_clear_alpha(citySideColor, 0);
	
	for (var i = 0; i < surfWidth; i += buildingFrequency + irandom(buildingFrequencyVariance);)
	{
		var width = i + buildingWidth + irandom(buildingWidthVariance);
		var height = surfHeight - buildingHeight + irandom(buildingHeightVariance);
		var col = cityColor;
		
		draw_rectangle_color(i, height, width, surfHeight, col, col, col, col, false);
	}
	
	surface_reset_target();
}