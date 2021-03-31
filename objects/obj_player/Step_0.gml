state();

//Persistent effects/things
rotateCamera((rotSpd[0] - rotSpd[1]) * 0.2, false);
energyRecovery();
squash();
controllerVibration();
//Input blocking handling
inputTimer();
checkifOutOfBounds();