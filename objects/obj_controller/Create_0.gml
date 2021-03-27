//Spawn extra logic objects because room inheritance sucks
instance_create_layer(0, 0, layer, obj_background);

//Keep track of level we're in
global.lastLevel = room;

//Reset level objective
global.objectiveCount = 0;

transitionTimerMax = 30;
transitionTimer = 0;
transitioningOut = false;
transitioningIn = true;
transitionFunction = nextLevel;