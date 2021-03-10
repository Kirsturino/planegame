//Delta time particle tick
global.particleTick += delta;

if (global.particleTick > 1)
{
	global.particleTick = frac(global.particleTick);
	global.updateParticles = true;
} else
{
	global.updateParticles = false;
}