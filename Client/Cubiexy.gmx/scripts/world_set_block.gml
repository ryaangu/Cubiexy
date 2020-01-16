///world_set_block(layer, x, y, block_id);
var _layer    = argument[0],
    _x        = argument[1],
    _y        = argument[2],
    _block_id = argument[3];

//Check for position inside grid
if (ds_grid_check(global.world_grid[_layer], _x, _y))
{
    //Set the block
    ds_grid_set(global.world_grid[_layer], _x, _y, _block_id);
    
    //Punch the surface
    surface_set_target(global.world_surface[_layer]);
    draw_null_block(_x * BLOCK_SIZE, _y * BLOCK_SIZE);
    
    if (_block_id > BLOCK.NULL)
        draw_block(_block_id, _x * BLOCK_SIZE, _y * BLOCK_SIZE, BLOCK_SIZE, c_white);
    
    surface_reset_target();
}
