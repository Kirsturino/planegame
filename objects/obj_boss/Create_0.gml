global.objectiveCount = 9999;

line = boss_line;
circles = [circle_01, circle_02, circle_03, circle_04];
instance_deactivate_object(boss_line);
for (var i = 0; i < 4; i++)
{
	instance_deactivate_object(circles[i]);
}

//Bullet styles
bulletStormBullets =
{
	delay : 2,
	weight : 1,
	spd : 4,
	dmg : 60,
	destroyTimer : 180,
	amount : 12,
	burstAmount : 3,
	burstDelay : 64,
	cooldown : 128,
	circleSpd : 1.8,
	spread : 10
}

bulletRingStormBullets =
{
	delay : 2,
	weight : 1,
	spd : 4,
	dmg : 40,
	destroyTimer : 180,
	amount : 12,
	burstAmount : 3,
	burstDelay : 128,
	cooldown : 180,
	circleSpd : 1.8,
	spread : 10
}

bulletRingBullets =
{
	delay : 2,
	weight : 1,
	spd : 1.5,
	dmg : 60,
	destroyTimer : 320,
	amount : 16,
	burstAmount : 5,
	burstDelay : 0,
	cooldown : 128,
	circleSpd : 1,
	spread : 0
}

bulletHoseBullets =
{
	delay : 1,
	weight : 1,
	spd : 4,
	dmg : 20,
	destroyTimer : 240,
	amount : 256,
	burstAmount : 1,
	burstDelay : 0,
	cooldown : 0,
	circleSpd : 1,
	spread : 20
}

finalPhaseBullets =
{
	delay : 2,
	weight : 1,
	spd : 4,
	dmg : 60,
	destroyTimer : 240,
	amount : 256,
	burstAmount : 1,
	burstDelay : 0,
	cooldown : 0,
	circleSpd : 1,
	spread : 0
}

//Generic bullet tracking
bulletAmount = 0;
burstAmount = 0;
bulletDelay = 0;
bulletDir = 0;

//Other stuff
attackCooldown = 0;
burstCooldown = 0;
attack = bulletStormBullets;

function spawnBullet(x, y, dir, struct)
{
	var bullet = instance_create_layer(x, y, layer, obj_bullet);
	var _dir = dir + random_range(-struct.spread, struct.spread);
	var xSpd = lengthdir_x(struct.spd, _dir);
	var ySpd = lengthdir_y(struct.spd, _dir);
	bullet.hsp = xSpd;
	bullet.vsp = ySpd;
	bullet.dmg = struct.dmg;
	bullet.target = obj_player;
	bullet.dir = _dir;
	bullet.weight = struct.weight;
	bullet.behaviour = bossBulletBehaviour;
	bullet.drawFunction = bossBulletDrawing;
	bullet.destroyTimer = struct.destroyTimer;
	
	//Reset timer
	bulletDelay = struct.delay;
	bulletAmount++;
}

function spawnCircle(x, y, dir, spd, radius, amount, obj)
{
	var circle = instance_create_layer(x, y, layer, obj);
	
	var xSpd = lengthdir_x(spd, dir);
	var ySpd = lengthdir_y(spd, dir);
	circle.hsp = xSpd;
	circle.vsp = ySpd;
	circle.radiusTo = radius;
	circle.segments = radius/2;
	circle.surfSize = radius*4;
	circle.surfCenter = radius*2;
	circle.completionMax = amount;
	
	return circle;
}

//Attacks
function bulletStorm()
{
	if (bulletDelay == 0 && burstCooldown == 0)
	{
		bulletDir = point_direction(x, y, obj_player.x, obj_player.y);
		spawnBullet(x, y, bulletDir, attack);
		
		if (bulletAmount == attack.amount - 1 && burstAmount == attack.burstAmount - 1)
		{
			spawnCircle(x, y, bulletDir, attack.circleSpd, 32, 30, obj_objective_circle_boss);
			toCoolingDown(attack.cooldown);
		} else if (bulletAmount == attack.amount)
		{
			bulletAmount = 0;
			burstAmount++;
			burstCooldown = attack.burstDelay;
			
			//Shoot an objective circle between bursts
			spawnCircle(x, y, bulletDir, attack.circleSpd, 32, 30, obj_objective_circle_boss);
		}
	} else
	{
		bulletDelay = approach(bulletDelay, 0, 1);
		burstCooldown = approach(burstCooldown, 0, 1);
	}
}

function bulletHose()
{
	if (bulletDelay == 0 && burstCooldown == 0)
	{
		bulletDir = point_direction(x, y, obj_player.x, obj_player.y);
		spawnBullet(x, y, bulletDir, attack);
		
		if (bulletAmount == attack.amount - 1 && burstAmount == attack.burstAmount - 1)
		{			
			toCoolingDown(attack.cooldown);
		} else if (bulletAmount == attack.amount)
		{
			bulletAmount = 0;
			burstAmount++;
			burstCooldown = attack.burstDelay;
		}
	} else
	{
		bulletDelay = approach(bulletDelay, 0, 1);
		burstCooldown = approach(burstCooldown, 0, 1);
	}
	
	if (line.completed)
	{
		incrementPhase();
		toCoolingDown(240);
	}
}

function finalPhase()
{
	if (bulletDelay == 0 && burstCooldown == 0)
	{
		
		var slices = 4;
		var wiggle = 360;
		var rot = 2;
		
		bulletDir += rot;
		for (var i = 0; i < slices; i++)
		{
			var dir = i*360/slices + wave(0, wiggle, 24, 0, true);
			spawnBullet(x, y, dir, attack);
		}
		
		if (bulletAmount == attack.amount - 1 && burstAmount == attack.burstAmount - 1)
		{			
			toCoolingDown(attack.cooldown);
		} else if (bulletAmount == attack.amount)
		{
			bulletAmount = 0;
			burstAmount++;
			burstCooldown = attack.burstDelay;
		}
	} else
	{
		bulletDelay = approach(bulletDelay, 0, 1);
		burstCooldown = approach(burstCooldown, 0, 1);
	}
	
	//Check completion
	var allDone = true;
	for (var i = 0; i < 4; i++)
	{
		if (instance_exists(circles[i])) { allDone = false; break; }
	}
	
	if (allDone) incrementPhase();
}

function bulletRings()
{
	if (bulletDelay == 0 && burstCooldown == 0)
	{
		var offset = 360/attack.amount / 2;
		bulletDir = 360/attack.amount * bulletAmount + burstAmount*offset;
		spawnBullet(x, y, bulletDir, attack);
		
		if (bulletAmount == attack.amount - 1 && burstAmount == attack.burstAmount - 1)
		{
			//spawnCircle(x, y, bulletDir, attack.spd*0.6, 32);
			toCoolingDown(attack.cooldown);
		} else if (bulletAmount == attack.amount)
		{
			bulletAmount = 0;
			burstAmount++;
			burstCooldown = attack.burstDelay;
		}
	} else
	{
		bulletDelay = approach(bulletDelay, 0, 1);
		burstCooldown = approach(burstCooldown, 0, 1);
	}
}

function bulletRingStorm()
{
	if (bulletDelay == 0 && burstCooldown == 0)
	{
		if (bulletAmount == 0)
		{
			var blts = 24;
			for (var i = 0; i < blts; i++)
			{
				var dir = 360/blts * i;
				spawnBullet(x, y, dir, bulletRingBullets);
			}
			bulletAmount = 0;
			bulletDelay = 0;
		}
		
		var spread = 10;
		bulletDir = point_direction(x, y, obj_player.x, obj_player.y) + random_range(-spread, spread);
		spawnBullet(x, y, bulletDir, attack);
		
		if (bulletAmount == attack.amount - 1 && burstAmount == attack.burstAmount - 1)
		{
			spawnCircle(x, y, bulletDir, attack.circleSpd, 32, 180, obj_objective_circle_boss_rotate);
			toCoolingDown(attack.cooldown);
		} else if (bulletAmount == attack.amount)
		{
			bulletAmount = 0;
			burstAmount++;
			burstCooldown = attack.burstDelay;
			
			//Shoot an objective circle between bursts
			spawnCircle(x, y, bulletDir, attack.circleSpd, 32, 180, obj_objective_circle_boss_rotate);
		}
	} else
	{
		bulletDelay = approach(bulletDelay, 0, 1);
		burstCooldown = approach(burstCooldown, 0, 1);
	}
}

function destructionPhase()
{
	
}

//This is dumb, but I just want to finish this game
function spawnLine()
{
	instance_activate_object(line);
	with (line) event_perform(ev_alarm, 0);
}

function dormant()
{
	if (!obj_player.neutral && obj_player.dummyReset)
	{
		toCoolingDown(60);
	}
}

function coolingDown()
{
	attackCooldown = approach(attackCooldown, 0, 1);
	
	if (attackCooldown == 0)
	{
		//Initiate attack
		switch (phase)
		{
			case 0:
				state = bulletStorm;
				attack = bulletStormBullets;
			break;
			
			case 1:
				state = bulletRings;
				attack = bulletRingBullets;
			
				var dir = point_direction(x, y, obj_player.x, obj_player.y) + 180;
				var circ = spawnCircle(x, y, dir, attack.circleSpd, 32, 20, obj_objective_circle_boss_shoot);
				addCameraFocus(circ);
			break;
			
			case 2:
				state = bulletRingStorm;
				attack = bulletRingStormBullets;
				
				var blts = 18;
				for (var i = 0; i < blts; i++)
				{
					var dir = 360/blts * i;
					spawnBullet(x, y, dir, bulletRingBullets);
				}
				bulletAmount = 0;
				bulletDelay = 0;
			break;
			
			case 3:
				state = bulletHose;
				attack = bulletHoseBullets;
			break;
			
			case 4:
				if (state != finalPhase)
				{
					for (var i = 0; i < 4; i++)
					{
						instance_activate_object(circles[i]);
					}
				}
				
				state = finalPhase;
				attack = finalPhaseBullets;
			break;
			
			case 5:
				state = destructionPhase;
			break;
		}
	}	
}

function toCoolingDown(amount)
{
	attackCooldown = amount;
	bulletAmount = 0;
	burstAmount = 0;
	bulletDir = 0;
	
	state = coolingDown;
}

state = dormant;

//Yeah, this is kinda weird, but I don't want the player having to do this shit anywhere else
function playerBulletChecking()
{
	with (obj_player)
	{
		var size = 2;
		var blt = collision_rectangle(x - size, y - size, x + size, y + size, obj_bullet, false, false);
		if (blt != noone && blt.target == object_index)
		{
			hsp += lengthdir_x(blt.weight, blt.dir);
			vsp += lengthdir_y(blt.weight, blt.dir);
			
			if (energy != 0)
			{
				energy = approach_pure(energy, 0, blt.dmg);
				energyCooldown = energyCooldownMax;
			}
			
			//FX
			freeze(50);
			shakeCamera(50, 0, 20);
			part_particles_create(global.ps, blt.x, blt.y, global.electricityPart, 4);
			part_particles_create(global.psTop, blt.x, blt.y, global.bulletHitPart, 1);
			
			instance_destroy(blt);
		}
	}
}

function incrementPhase()
{
	phase++;
	circleCount = 0;
	toCoolingDown(attack.cooldown);
	
	//FX
	shakeCamera(80, 2, 60);
	flash(1.1);
}

//Tracking stuff
circleCount = 0;
transitionAmount = 3;
phase = 3;
incrementPhase();

//Graphics
drawSize = 32;
surfMargin = 16;
cubeSurf = -1;
cubeTexelW = 0;
cubeTexelH = 0;
upixelH = 0;
upixelW = 0;