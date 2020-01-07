///world_read_horizontal_blocks(layer, y, data);
var _layer = argument[0],
    _y     = argument[1],
    _data  = argument[2];

//Split the data
var _data_array = string_split(_data, ", ");

//Loop through world width and set the blocks
for (var _x = 0; _x < WORLD_WIDTH div BLOCK_SIZE; _x++)
{
    world_set_block(_layer, _x * BLOCK_SIZE, _y * BLOCK_SIZE, real(_data_array[_x]));
}
