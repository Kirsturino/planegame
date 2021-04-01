//Transition in room
startRoomTransition(transition.in, obj_player.x, obj_player.y, room);

//Spawn extra logic objects because room inheritance sucks
instance_create_layer(0, 0, layer, obj_background);

//Keep track of level we're in
global.lastLevel = room;

//Reset level objective
global.objectiveCount = 0;