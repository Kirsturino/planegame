textSurf = -1;

var txtWidth = string_width(txt);
var txtHeight = string_height(txt);
maxWidth = viewWidth/2;

width = min(string_width(txt), viewWidth/2);
height = string_height(txt)*ceil(txtWidth/maxWidth);
margin = 16;