///draw_text_custom_ext(x, y, string, color, align, font, shadow_size);
var _x      = argument[0],
    _y      = argument[1],
    _string = argument[2],
    _color  = argument[3],
    _align  = argument[4],
    _font   = argument[5],
    _size   = argument[6];
    
//Draw the texts
draw_text_custom(_x + _size, _y + _size, string_keywords_remove(_string), c_black, _align, _font);
draw_text_custom(_x, _y, _string, _color, _align, _font);
