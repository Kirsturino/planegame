//var buttonSize = 8;
//var margin = 32;
//var squash = 4;
//var stickShift = 8;

//if (!surface_exists(guiSurf))
//{
//	guiSurf = surface_create(viewWidth, viewHeight);
//	guiTexelW = outlineThiccness * texture_get_texel_width(surface_get_texture(guiSurf));
//	guiTexelH = outlineThiccness * texture_get_texel_height(surface_get_texture(guiSurf));
//}

//surface_set_target(guiSurf);
//draw_clear_alpha(col_black, 0);

//var joyL = gamepad_axis_value(0, gp_axislv);
//var _y = viewHeight/2 + joyL*stickShift;

//draw_circle_color(margin, viewHeight/2, buttonSize*0.5, col_black, col_black, false);
//draw_line_width(margin, viewHeight/2, margin, viewHeight/2+joyL*squash*1.1, 6);
//draw_circle_color(margin, viewHeight/2, 3, col_white, col_white, false);
//draw_ellipse_color(margin-buttonSize, _y-buttonSize+abs(joyL)*squash, margin+buttonSize, _y+buttonSize-abs(joyL)*squash, col_black, col_black, false);
//draw_ellipse_color(margin-buttonSize+2, _y-buttonSize+2+abs(joyL)*squash, margin+buttonSize-2, _y+buttonSize-2-abs(joyL)*squash, col_white, col_white, false);

//var joyR = gamepad_axis_value(0, gp_axisrv);
//var _y = viewHeight/2 + joyR*stickShift;

////draw_circle_color(viewWidth-margin, viewHeight/2, buttonSize*0.5, col_black, col_black, false);
//draw_line_width(viewWidth-margin, viewHeight/2, viewWidth - margin, viewHeight/2+joyR*squash*1.1, 6);
//draw_circle_color(viewWidth-margin, viewHeight/2, 3, col_white, col_white, false);
//draw_ellipse_color(viewWidth-margin-buttonSize, _y-buttonSize+abs(joyR)*squash, viewWidth-margin+buttonSize, _y+buttonSize-abs(joyR)*squash, col_black, col_black, false);
//draw_ellipse_color(viewWidth-margin-buttonSize+2, _y-buttonSize+2+abs(joyR)*squash, viewWidth-margin+buttonSize-2, _y+buttonSize-2-abs(joyR)*squash, col_white, col_white, false);

//surface_reset_target();

//shader_set(shd_outline);
//shader_set_uniform_f(upixelW, guiTexelW);
//shader_set_uniform_f(upixelH, guiTexelH);
//draw_surface(guiSurf, 0, 0);
//shader_reset();