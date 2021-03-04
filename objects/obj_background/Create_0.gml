//Disable editor background and make this object go at bottom draw order
layer_destroy(layer_get_id("Background"));
layer = layer_create(300, "Background");

//Background variables
backgroundColor = col_skyblue;

//Cloud generation
var cloudAmount = round(room_width * room_height / 40000);
var cloudDirection = choose(1, -1);

repeat (cloudAmount)
{
    var cloud = instance_create_layer(	irandom(room_width), 
										irandom(room_height), 
										layer,
										obj_background_cloud);
	
	//Cloud movement
	cloud.dir = cloudDirection;
	
	//Layer clouds just after background is drawn
	cloud.depth = 299;
}