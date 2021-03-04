//Movement
rotSpd = [0, 0];
rotAxl = 0.4;
rotDrag = 0.2;
rotSpdMax = 4;
hsp = 0;
vsp = 0;
axl = 0.09;
spdMax = 3;
reverseSpdModifier = 0.8;
drag = 0.02;
curDrag = drag;
dragTransitionSpd = 0.001;
lift = 0.06;
grv = 0.055;
curSpdMax = spdMax;
curAxl = axl;
spdTransitionSpd = 0.05;

//Turbo
turboSpdMax = 5;
turboAxl = 0.2;
turbo = false;
turboCost = 1;
turboStartCost = 5;

//Energy
energyMax = 200;
energy = energyMax;
energyCooldown = 0;
energyCooldownMax = 60;
energyRechargeRate = 6;
dangerEnergyDrain = 4;

//Shooting
shootDrag = 0.06;

//Bullets
bulletDelayMax = 6;
bulletDelay = 0;
bulletCost = 4;
bulletWeight = 0.3;
bulletSpd = 10;
bulletDmg = 1;

//Controller stuff and inputs
deadZoneMin = 0.3;
deadZoneMax = 0.8;
gamepad_set_axis_deadzone(0, deadZoneMin);
joyL = 0;
joyR = 0;
neutral = true;
fullSteam = false;
shouldTurbo = false;
shouldShoot = false;

//Misc
fallingTurnSpd = 0;
maxFallingTurnSpd = 2;
fallingTurnSpdAxl = 0.03;
inDanger = false;
dummyReset = false;

//Graphics
wingSpan = 1;
horWingSpan = 1;
engineDistance = sprite_get_height(spr_wings_small) / 2;
part = global.thrustPart;
wiggleBlend = 0;
xScale = 1;
yScale = 1;
xScaleTarget = 1;
yScaleTarget = 1;
squashSpeed = 0.1;

//Sounds
outOfEnergySound = snd_out_of_energy;
engineSound = audio_play_sound(snd_engine_persistent, 0, true);
audio_sound_gain(engineSound, 0, 0);
engineSoundVolumeMultiplier = 0.03;

turboKickSound = snd_turbo_kick;
turboSound = snd_turbo;

bulletSound = snd_shoot_default;
cloudSound = snd_cloud_damage;
warningSound = snd_warning;

//Movement functions
function calculateRotation()
{
	//Angular curDrag
	rotSpd[0] = approach(rotSpd[0], 0, rotDrag);
	rotSpd[1] = approach(rotSpd[1], 0, rotDrag);
	
	//Rotation
	rotSpd[0] = clamp(rotSpd[0] + joyL * rotAxl, -rotSpdMax, rotSpdMax);
	rotSpd[1] = clamp(rotSpd[1] + joyR * rotAxl, -rotSpdMax, rotSpdMax);
	
	//Angle plane down if neutraling and falling
	if (neutral && !shouldShoot && vsp > 0)
	{
		if (image_angle < 280 && image_angle > 260) { wiggleBlend = approach(wiggleBlend, 1, 0.01); }
		else										{ wiggleBlend = 0; }
	
		fallingTurnSpd = approach(fallingTurnSpd, maxFallingTurnSpd, fallingTurnSpdAxl);
		
		var pd = 270 + wave(-5, 5, 0.3, 0, true) * wiggleBlend;
		var dd = angle_difference(image_angle, pd);
		image_angle -= min(abs(dd), fallingTurnSpd) * sign(dd);

	} else
	{
		fallingTurnSpd = 0;
	}

	//Wrap rotation
	if (image_angle > 359)		{ image_angle = 0; }
	else if (image_angle < 0)	{ image_angle = 359; }
}

function applyRotation()
{
	image_angle += rotSpd[0] - rotSpd[1];	
}

function calculateMovement()
{
	//Modify thrust power if reversing
	//This needs to be after rotation code so it doesn't affect it
	if (joyL > 0) { joyL *= reverseSpdModifier; }
	if (joyR > 0) { joyR *= reverseSpdModifier; }
	
	//Drag
	hsp = approach(hsp, 0, curDrag * wingSpan * abs(hsp) / curSpdMax);
	vsp = approach(vsp, 0, lift * horWingSpan * abs(vsp) / curSpdMax);
	
	if (turbo)
	{
		var hspFinalLimit = abs(lengthdir_x(curSpdMax, image_angle));
		var vspFinalLimit = abs(lengthdir_y(curSpdMax, image_angle));
		var downLimit = vspFinalLimit;
	} else
	{
		var hspFinalLimit = max(abs(lengthdir_x(curSpdMax, image_angle)), curSpdMax/2);
		var vspFinalLimit = max(abs(lengthdir_y(curSpdMax, image_angle)), curSpdMax/2);
		var downLimit = turboSpdMax - min(abs(hsp), spdMax);
	}
	
	hsp += (lengthdir_x(-joyL, image_angle) + lengthdir_x(-joyR, image_angle)) * curAxl;
	vsp += (lengthdir_y(-joyL, image_angle) + lengthdir_y(-joyR, image_angle)) * curAxl + grv;
	
	//Speed limits
	//Break out going up and down, you can fall faster than normal speedlimit without turbo
	hsp = clamp(hsp, -hspFinalLimit, hspFinalLimit);
	vsp = clamp(vsp, -vspFinalLimit, downLimit);
}

function applyMovement()
{
	//Apply momentum
	x += hsp;
	y += vsp;
}

function turboLogic()
{
	//Turbo
	if (shouldTurbo && fullSteam && energy > 0)
	{
		curSpdMax = turboSpdMax;
		energy = approach(energy, 0, turboCost);
		energyCooldown = energyCooldownMax;
	
		shakeCamera(15, 0, 20);
		if (!turbo)
		{
			curAxl = turboAxl;
			pushCamera(50, image_angle);
			flash(0.1); 
			part = global.turboPart;
			energy = approach(energy, 0, turboStartCost);
			turbo = true;
			setSquashTarget(0.9, 1.1);
			setSquash(0.6, 1.4);
			
			//Remove all turning when initiating turbo
			rotSpd[0] = 0;
			rotSpd[1] = 0;
			
			//SFX
			audio_stop_sound(turboKickSound);
			audio_play_sound(turboSound, 0, true);
			audio_play_sound(turboKickSound, 0, false);
		}
	} else
	{
		curSpdMax = approach(curSpdMax, spdMax, spdTransitionSpd);
	
		if (turbo)
		{
			curAxl = axl;
			part = global.thrustPart;
			turbo = false;
			resetSquashTarget();
			audio_stop_sound(turboSound);
		}
	}
}

function shootingLogic()
{
	//Shooting pew pew
	if (shouldShoot && bulletDelay == 0 && !turbo && energy > 0)
	{
		var offset = engineDistance * wingSpan * 0.75;
		
		//Left bullet
		var spawnX = x + lengthdir_x(offset, image_angle-90);
		var spawnY = y + lengthdir_y(offset, image_angle-90);
		var bullet = instance_create_layer(spawnX, spawnY, layer, obj_bullet);
	

		var xSpd = lengthdir_x(bulletSpd, image_angle);
		var ySpd = lengthdir_y(bulletSpd, image_angle);
		bullet.hsp = xSpd;
		bullet.vsp = ySpd;
		bullet.dmg = bulletDmg;
		
		//Left particles
		part_type_direction(global.shootPart,image_angle-20,image_angle+20,0,0);
		part_particles_create(global.ps, spawnX, spawnY, global.shootPart, 5);
		
		
		//Right bullet
		var spawnX = x + lengthdir_x(offset, image_angle+90);
		var spawnY = y + lengthdir_y(offset, image_angle+90);
		var bullet = instance_create_layer(spawnX, spawnY, layer, obj_bullet);
	
		var xSpd = lengthdir_x(bulletSpd, image_angle);
		var ySpd = lengthdir_y(bulletSpd, image_angle);
		bullet.hsp = xSpd;
		bullet.vsp = ySpd;
		bullet.dmg = bulletDmg;
		
		//Right particles
		part_particles_create(global.ps, spawnX, spawnY, global.shootPart, 4);
		
		//Movement ramifications
		hsp += lengthdir_x(bulletWeight, image_angle+180);
		vsp += lengthdir_y(bulletWeight, image_angle+180);
		rotSpd[1] = approach(rotSpd[0], 0, bulletWeight);
		rotSpd[0] = approach(rotSpd[1], 0, bulletWeight);
	
		//Energy stuff
		bulletDelay = bulletDelayMax;
		energy = approach(energy, 0, bulletCost);
		energyCooldown = energyCooldownMax;
		
		//FX
		pushCamera(bulletWeight*150, image_angle+180);
		directionShakeCamera(bulletWeight*100, 10, image_angle, 0.1);
		setSquash(1+bulletWeight, 1-bulletWeight);
		//flash(0.05);
		audio_play_sound(bulletSound, 0, false);
	}
	
	//Increase drag when shooting to avoid player drift, but still allow up/down momentum
	if (shouldShoot)
	{
		curDrag = approach(curDrag, shootDrag, dragTransitionSpd);
	} else
	{
		curDrag = approach(curDrag, drag, dragTransitionSpd);
	}

	bulletDelay = approach(bulletDelay, 0, 1);
}

function energyRecovery()
{
	if (!shouldTurbo && !shouldShoot)
		{ energyCooldown = approach(energyCooldown, 0, 1); }
		
	//Energy recovery
	if (energyCooldown == 0)
		{ energy = approach(energy, energyMax, energyRechargeRate); }
}

//States
function dummy()
{
	getInput();
	
	hsp = 0;
	vsp = 0;
	
	if (neutral) { dummyReset = true; }
	if (!neutral && dummyReset) { toAlive(); }
}

function toAlive()
{
	audio_stop_sound(outOfEnergySound);
	audio_stop_sound(warningSound);
	state = alive;
}

function toOutOfEnergy()
{
	freeze(100);
	shakeCamera(100, 20, 20);
	
	audio_stop_sound(turboSound);
	audio_stop_sound(cloudSound);
	audio_sound_gain(engineSound, 0, 100);
	audio_play_sound(outOfEnergySound, 0, false);
	audio_play_sound(warningSound, 0, true);
	
	resetInput();
	turbo = false;
	shouldShoot = false;
	state = outOfEnergy;
}

function alive()
{
	getInput();

	calculateRotation();
	applyRotation();
	
	turboLogic();
	shootingLogic();
	
	calculateMovement();
	applyMovement();

	engineParticles();
	
	checkForDanger();
	
	if (energy == 0) {toOutOfEnergy();}
}

function outOfEnergy()
{
	calculateRotation();
	applyRotation();
	
	calculateMovement();
	applyMovement();
	
	checkForDanger();
	
	if (energy == energyMax) { toAlive(); }
}

state = dummy;

//Misc functions
function engineParticles()
{
	//Particles
	var p = part;
	var offset = engineDistance * wingSpan * 0.75;
	if (abs(joyR) > deadZoneMin)
	{
		var partX = x + lengthdir_x(offset, image_angle - 90) + lengthdir_x(-4, image_angle);
		var partY = y + lengthdir_y(offset, image_angle - 90) + lengthdir_y(-4, image_angle);
		var partSpd = abs(joyR);
		part_type_speed(p, partSpd, partSpd*(1+random(1)), -0.001, 0.01);
	
		var dir = image_angle + random_range(-20, 20);
		var wig = 10;
		var shift = irandom_range(-1, 1);
		if (joyR > 0)	{ part_type_direction(p, dir, dir, 0, wig); }
		else			{ part_type_direction(p, dir + 180, dir + 180, shift, wig); }
		
		part_particles_create(global.ps, partX, partY, p, 1);
		part_particles_create(global.ps, partX, partY, global.smokePart, 1);
	}

	if (abs(joyL) > deadZoneMin)
	{
		var partX = x + lengthdir_x(offset, image_angle + 90) + lengthdir_x(-4, image_angle);
		var partY = y + lengthdir_y(offset, image_angle + 90) + lengthdir_y(-4, image_angle);
		var partSpd = abs(joyL);
		part_type_speed(p, partSpd, partSpd*(1+random(1)), -0.001, 0.01);
	
		var dir = image_angle + random_range(-20, 20);
		var wig = 10;
		var shift = irandom_range(-1, 1);
		if (joyL > 0)	{ part_type_direction(p, dir, dir, shift, wig); }
		else			{ part_type_direction(p, dir + 180, dir + 180, shift, wig); }
	
		part_particles_create(global.ps, partX, partY, p, 1);
		part_particles_create(global.ps, partX, partY, global.smokePart, 1);
	}

	//Feel the speed
	if (abs(hsp) + abs(vsp) >= turboSpdMax - 0.5 && abs(angle_difference(image_angle, point_direction(0, 0, hsp, vsp))) < 45)
	{
		var dir = image_angle - 180;
		var offset = 30;

		for (var i = 0; i < 2; ++i)
		{
			var partX = lengthdir_x(22, dir + 180) + lengthdir_x(2, dir + sign(offset) * 90);
			var partY = lengthdir_y(22, dir + 180) + lengthdir_y(2, dir + sign(offset) * 90);

			part_type_direction(global.speedPart,dir + offset,dir + offset,0,0);
			part_particles_create(global.ps, x + partX, y + partY, global.speedPart, 1);
	
			offset *= -1;
		}
	}
	
	//Engine sounds
	if (!audio_is_playing(engineSound))
	{
		engineSound = audio_play_sound(snd_engine_persistent, 0, true);
		audio_sound_gain(engineSound, 0, 0);
	}
	
	var volume = (abs(joyL) + abs(joyR)) * engineSoundVolumeMultiplier;
	audio_sound_gain(engineSound, volume, 100);
}

function getInput()
{
	joyL = gamepad_axis_value(global.controller, gp_axislv);
	joyR = gamepad_axis_value(global.controller, gp_axisrv);
	
	neutral = abs(joyL) < deadZoneMin && abs(joyR) < deadZoneMin;
	//Not absolute values, because this needs to be true only when NOT reversing
	fullSteam = (joyL < -deadZoneMax && joyR < -deadZoneMax);
	shouldTurbo = gamepad_button_check(global.controller, gp_shoulderrb);
	shouldShoot = gamepad_button_check(global.controller, gp_shoulderlb);
}

function resetInput()
{
	joyL = 0;
	joyR = 0;
	neutral = true;
	fullSteam = false;
	shouldTurbo = false;
	shouldShoot = false;
}

function checkForDanger()
{
	if (collision_point(x, y, obj_danger_zone, false, false) != noone)
	{
		energyCooldown = energyCooldownMax;
		energy = approach(energy, 0, dangerEnergyDrain);
		
		//FX
		shakeCamera(15, 2, 10);
		
		if (!inDanger)
		{
			//FX
			inDanger = true;
			shakeCamera(40, 4, 20);
			audio_play_sound(cloudSound, 0, true);
		}
	} else if (inDanger)
	{
		inDanger = false;
		shakeCamera(40, 4, 20);

		var dir = point_direction(0, 0, hsp, vsp);
		part_type_direction(global.explosiveSmokePart, dir-45, dir+45, 0, 0);
		part_particles_create(global.ps, x, y, global.explosiveSmokePart, 20);
		
		//SFX
		audio_stop_sound(cloudSound);
	}
}

function setSquashTarget(scale_x, scale_y)
{
	xScaleTarget = scale_y;
	yScaleTarget = scale_x;
}

function resetSquashTarget()
{
	xScaleTarget = 1;
	yScaleTarget = 1;
}

function setSquash(scale_x, scale_y)
{
	xScale = scale_y;
	yScale = scale_x;
}

function resetSquash()
{
	xScale = 1;
	yScale = 1;
}