///draw_string(x, y, string, string_color, shadow_color);
var _x            = argument[0],
    _y            = argument[1],
    _string       = argument[2],
    _string_color = argument[3],
    _shadow_color = argument[4];
    
//Draw the shadow string
draw_set_color(_shadow_color);
draw_text(_x + 1, _y + 1, _string);

//Draw the normal string
draw_set_color(_string_color);
draw_text(_x, _y, _string);
