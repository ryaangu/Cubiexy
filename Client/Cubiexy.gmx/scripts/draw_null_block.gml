///draw_null_block(x, y);
var _x = argument[0],
    _y = argument[1];
    
//Set blend mode and color
draw_set_blend_mode(bm_subtract);
draw_set_color(c_black);

//Draw a rectangle
draw_rectangle(_x, _y, _x + BLOCK_SIZE - 1, _y + BLOCK_SIZE - 1, false);

//Reset blend mode and color
draw_set_blend_mode(bm_normal);
draw_set_color(c_white);
