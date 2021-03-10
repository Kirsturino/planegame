x += hsp*delta;
y += vsp*delta;

if (global.updateParticles) part_particles_create(global.psTop, x, y, global.smokePartShort, 1);

destroyTimer = approach(destroyTimer, 0, 1);
if (destroyTimer == 0) { instance_destroy(); }