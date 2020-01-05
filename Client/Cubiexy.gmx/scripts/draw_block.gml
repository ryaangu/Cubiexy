///draw_block(block_id, x, y, size, color);
var _block_id = argument[0],
    _x        = argument[1],
    _y        = argument[2],
    _size     = argument[3],
    _color    = argument[4];
    
//Get cell info
var _cell_size   = 32,
    _cell_width  = 6,
    _cell_height = 6;
    
//Get position to draw
var _x_position = (_block_id mod _cell_width)  * _cell_size,
    _y_position = (_block_id div _cell_height) * _cell_size;
    
//Draw the block
draw_background_part_ext(bg_world_blocks, _x_position, _y_position, _size, _size, _x, _y, 1, 1, _color, 1);
