//Storm
bulletStormBullets =
{
	delay : 2,
	weight : 1,
	spd : 4,
	dmg : 40,
	destroyTimer : 180,
	amount : 12,
	burstAmount : 3,
	burstDelay : 64,
	cooldown : 128
}

bulletRingBullets =
{
	delay : 1,
	weight : 1,
	spd : 1.5,
	dmg : 60,
	destroyTimer : 320,
	amount : 20,
	burstAmount : 5,
	burstDelay : 0,
	cooldown : 128
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
	
	var xSpd = lengthdir_x(struct.spd, dir);
	var ySpd = lengthdir_y(struct.spd, dir);
	bullet.hsp = xSpd;
	bullet.vsp = ySpd;
	bullet.dmg = struct.dmg;
	bullet.target = obj_player;
	bullet.dir = dir;
	bullet.weight = struct.weight;
	bullet.behaviour = bossBulletBehaviour;
	bullet.drawFunction = bossBulletDrawing;
	bullet.destroyTimer = struct.destroyTimer;
	
	//Reset timer
	bulletDelay = struct.delay;
	bulletAmount++;
}

function spawnCircle(x, y, dir, spd, radius, amount)
{
	var circle = instance_create_layer(x, y, layer, obj_objective_circle_boss);
	
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
		var spread = 10;
		bulletDir = point_direction(x, y, obj_player.x, obj_player.y) + random_range(-spread, spread);
		spawnBullet(x, y, bulletDir, attack);
		
		if (bulletAmount >= attack.amount - 1 && burstAmount >= attack.burstAmount - 1)
		{
			spawnCircle(x, y, bulletDir, attack.spd*0.6, 32, 30);
			toCoolingDown(attack.cooldown);
		} else if (bulletAmount == attack.amount)
		{
			bulletAmount = 0;
			burstAmount++;
			burstCooldown = attack.burstDelay;
			
			//Shoot an objective circle between bursts
			spawnCircle(x, y, bulletDir, attack.spd*0.6, 32, 30);
		}
	} else
	{
		bulletDelay = approach(bulletDelay, 0, 1);
		burstCooldown = approach(burstCooldown, 0, 1);
	}
}

function bulletRings()
{
	if (bulletDelay == 0 && burstCooldown == 0)
	{
		var offset = 360/attack.amount / 2;
		bulletDir = 360/attack.amount * bulletAmount + burstAmount*offset;
		spawnBullet(x, y, bulletDir, attack);
		
		if (bulletAmount >= attack.amount - 1 && burstAmount >= attack.burstAmount - 1)
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
		var spread = 10;
		bulletDir = point_direction(x, y, obj_player.x, obj_player.y) + random_range(-spread, spread);
		spawnBullet(x, y, bulletDir, attack);
		
		if (bulletAmount >= attack.amount - 1 && burstAmount >= attack.burstAmount - 1)
		{
			spawnCircle(x, y, bulletDir, attack.spd*0.6, 32, 30);
			toCoolingDown(attack.cooldown);
		} else if (bulletAmount == attack.amount)
		{
			bulletAmount = 0;
			burstAmount++;
			burstCooldown = attack.burstDelay;
			
			//Shoot an objective circle between bursts
			spawnCircle(x, y, bulletDir, attack.spd*0.6, 32, 30);
		}
	} else
	{
		bulletDelay = approach(bulletDelay, 0, 1);
		burstCooldown = approach(burstCooldown, 0, 1);
	}
}

//States
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
				var circ = spawnCircle(x, y, dir, attack.spd*0.6, 32, 30);
				addCameraFocus(circ);
			break;
			
			case 2:
				state = bulletRingStorm;
				attack = bulletStormBullets;
				
				var blts = 18;
				for (var i = 0; i < blts; i++)
				{
					var dir = 360/blts * i;
					spawnBullet(x, y, dir, bulletRingBullets);
				}
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

//Tracking stuff
circleCount = 0;
transitionAmount = 3;
phase = 0;