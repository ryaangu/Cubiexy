///world_set_blocks(layer, y, data);
var _layer = argument[0],
    _y     = argument[1],
    _data  = argument[2];

//Split the x blocks
var _block_data = string_split(_data, ", ");

//Loop through hoziontal blocks
for (var _x = 0; _x < WORLD_WIDTH div BLOCK_SIZE; _x++)
{    
    //Set the block id from block data array
    ds_grid_set(global.world_grid[_layer], _x, _y, real(_block_data[_x]));
}
