///draw_string_outline(x, y, string, string_color, outline_color, outline_size);
var _x             = argument[0],
    _y             = argument[1],
    _string        = argument[2],
    _string_color  = argument[3],
    _outline_color = argument[4],
    _outline_size  = argument[5];
    
//Draw the outline text
draw_set_color(_outline_color);
draw_text(_x, _y + _outline_size, _string);
draw_text(_x, _y - _outline_size, _string);
draw_text(_x + _outline_size, _y, _string);
draw_text(_x - _outline_size, _y, _string);
draw_text(_x + _outline_size, _y + _outline_size, _string);
draw_text(_x - _outline_size, _y - _outline_size, _string);
draw_text(_x - _outline_size, _y + _outline_size, _string);
draw_text(_x + _outline_size, _y - _outline_size, _string);
draw_text(_x + _outline_size, _y + _outline_size, _string);

//Draw the normal text
draw_set_color(_string_color);
draw_text(_x, _y, _string);
