///world_get_block(layer, x, y);
var _layer = argument[0],
    _x     = argument[1],
    _y     = argument[2];
    
//Divide the positions
_x = _x div BLOCK_SIZE;
_y = _y div BLOCK_SIZE;

//Check for position inside grid
if (ds_grid_check(global.world_grid[_layer], _x, _y))
{
    //Return the block
    return ds_grid_get(global.world_grid[_layer], _x, _y);
}

//Return null
return BLOCK.NULL;
