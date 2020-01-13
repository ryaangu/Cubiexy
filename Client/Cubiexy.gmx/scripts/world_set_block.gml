///world_set_block(layer, x, y, block_id);
var _layer    = argument[0],
    _x        = argument[1],
    _y        = argument[2],
    _block_id = argument[3];
    
//Get the previous position
var _x_previous = _x,
    _y_previous = _y;
    
//Divide the positions
_x = _x div BLOCK_SIZE;
_y = _y div BLOCK_SIZE;

show_debug_message(string_position(_x, _y));

//Check for position inside grid
if (ds_grid_check(global.world_grid[_layer], _x, _y))
{
    //Set the block
    ds_grid_set(global.world_grid[_layer], _x, _y, _block_id);
    
    //Update the chunks
    chunk_update(_layer, _x_previous, _y_previous);
}
