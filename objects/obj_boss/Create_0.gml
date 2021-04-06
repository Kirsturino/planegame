//Storm
bulletStormBullets =
{
	delay : 2,
	weight : 1,
	spd : 5,
	dmg : 40,
	amount : 12,
	burstAmount : 4,
	burstDelay : 16,
	cooldown : 60
}

//Generic bullet tracking
bulletAmount = 0;
burstAmount = 0;
bulletDelay = 0;

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
	
	//Reset timer
	bulletDelay = struct.delay;
	bulletAmount++;
}

//Attacks
function bulletStorm()
{
	if (bulletDelay == 0 && burstCooldown == 0)
	{
		var dir = point_direction(x, y, obj_player.x, obj_player.y);
		spawnBullet(x, y, dir, attack);
		
		if (bulletAmount == attack.amount - 1 && burstAmount == attack.burstAmount - 1)
		{
			toCoolingDown(attack.cooldown);
		} else if (bulletAmount == attack.amount)
		{
			bulletAmount = 0;
			burstAmount++;
			burstCooldown = attack.burstDelay;
			
			//Shoot an objective circle between bursts
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
		//Initiate random attack
		var rand = irandom(0);
		switch(rand)
		{
			case 0:
				state = bulletStorm;
			break;
		}
	}
}

function toCoolingDown(amount)
{
	attackCooldown = amount;
	bulletAmount = 0;
	burstAmount = 0;
	
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
			energy = approach_pure(energy, 0, blt.dmg);
			hsp += lengthdir_x(blt.weight, blt.dir);
			vsp += lengthdir_y(blt.weight, blt.dir);
			energyCooldown = energyCooldownMax;
			
			//FX
			freeze(50);
			shakeCamera(50, 0, 20);
			part_particles_create(global.ps, blt.x, blt.y, global.electricityPart, 4);
			part_particles_create(global.psTop, blt.x, blt.y, global.bulletHitPart, 1);
			
			instance_destroy(blt);
		}
	}
}