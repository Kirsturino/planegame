var buttonSize = 16;
var margin = 32;
var squash = 8;
var stickShift = 16;
var stickWidth = 12;

if (!surface_exists(controlSurf))
{
	controlSurf = surface_create(viewWidth, viewHeight);
	controlTexelW = outlineThiccness * texture_get_texel_width(surface_get_texture(controlSurf));
	controlTexelH = outlineThiccness * texture_get_texel_height(surface_get_texture(controlSurf));
	upixelH = shader_get_uniform(shd_outline, "pixelH");
	upixelW = shader_get_uniform(shd_outline, "pixelW");
}

surface_set_target(controlSurf);
draw_clear_alpha(col_black, 0);

var joyL = gamepad_axis_value(0, gp_axislv);
var _y = viewHeight/2 + joyL*stickShift;

draw_line_width(margin, viewHeight/2, margin, viewHeight/2+joyL*squash*1.1, stickWidth);
draw_circle_color(margin, viewHeight/2, stickWidth/2, col_white, col_white, false);
draw_ellipse_color(margin-buttonSize+2, _y-buttonSize+2+abs(joyL)*squash, margin+buttonSize-2, _y+buttonSize-2-abs(joyL)*squash, col_white, col_white, false);

var joyR = gamepad_axis_value(0, gp_axisrv);
var _y = viewHeight/2 + joyR*stickShift;

draw_line_width(viewWidth-margin, viewHeight/2, viewWidth - margin, viewHeight/2+joyR*squash*1.1, stickWidth);
draw_circle_color(viewWidth-margin, viewHeight/2, stickWidth/2, col_white, col_white, false);
draw_ellipse_color(viewWidth-margin-buttonSize+2, _y-buttonSize+2+abs(joyR)*squash, viewWidth-margin+buttonSize-2, _y+buttonSize-2-abs(joyR)*squash, col_white, col_white, false);

surface_reset_target();

shader_set(shd_outline);
shader_set_uniform_f(upixelW, controlTexelW);
shader_set_uniform_f(upixelH, controlTexelH);
draw_surface(controlSurf, 0, 0);
shader_reset();