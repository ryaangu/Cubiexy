///world_get_blocks(layer, y);
var _layer = argument[0],
    _y     = argument[1];

//Variables
var _block_data = "";

//Loop through horizontal blocks
for (var _x = 0; _x < WORLD_WIDTH div BLOCK_SIZE; _x++)
{
    //Add the block id to the block data string
    _block_data += string(world_get_block(_layer, _x * BLOCK_SIZE, _y * BLOCK_SIZE));
    if (_x != (WORLD_WIDTH div BLOCK_SIZE) - 1) _block_data += ", ";
} 

return string(_block_data);
