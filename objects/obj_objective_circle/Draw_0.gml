if (!isInView(self, radius)) {exit;}

if (!surface_exists(circleSurf))
	{
		circleSurf = surface_create(surfSize, surfSize);
		
		//Shader
		upixelH = shader_get_uniform(shd_outline, "pixelH");
		upixelW = shader_get_uniform(shd_outline, "pixelW");

		circleTexelW = outlineThiccness * texture_get_texel_width(surface_get_texture(circleSurf));
		circleTexelH = outlineThiccness * texture_get_texel_height(surface_get_texture(circleSurf));
	}

surface_set_target(circleSurf);
draw_clear_alpha(col_black, 0);

if (!completed)
{
	//Draw a dotted, rotating circle outline
	var i = 0;
	var rad = drawRad;
	repeat(segments)
	{
		//Draw every other segment for dotted look
		if (i mod 2 == 0)
		{
			var _x = surfSize/2 + lengthdir_x(rad, 360/segments*i+rot);
			var _y = surfSize/2 + lengthdir_y(rad, 360/segments*i+rot);
	
			var _x2 = surfSize/2 + lengthdir_x(rad, 360/segments*(i+1)+rot);
			var _y2 = surfSize/2 + lengthdir_y(rad, 360/segments*(i+1)+rot);
	
			draw_line_width_color(_x, _y, _x2, _y2, thiccness, col, col);
		} else if (completion != 0)
		{
			//When player completes objective, circle outline starts filling
			var _x = surfSize/2 + lengthdir_x(rad, 360/segments*i+rot);
			var _y = surfSize/2 + lengthdir_y(rad, 360/segments*i+rot);
	
			var _x2 = surfSize/2 + lengthdir_x(rad, 360/segments*(i+completion/completionMax)+rot);
			var _y2 = surfSize/2 + lengthdir_y(rad, 360/segments*(i+completion/completionMax)+rot);
	
			draw_line_width_color(_x, _y, _x2, _y2, thiccness, col, col);
		}
	
		i++;
	}
	
	drawFunction();
} else
{
	draw_circle_color(surfCenter, surfCenter, radius, col_black, col_black, false);
}

surface_reset_target();

shader_set(shd_outline);
shader_set_uniform_f(upixelW, circleTexelW);
shader_set_uniform_f(upixelH, circleTexelH);
draw_surface(circleSurf, x-surfSize/2, y-surfSize/2);
shader_reset();