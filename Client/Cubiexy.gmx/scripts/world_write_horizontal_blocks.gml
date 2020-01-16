///world_write_horizontal_blocks(layer, y);
var _layer = argument[0],
    _y     = argument[1];

//Loop through world width and add block ids to a string
var _data = "";

for (var _x = 0; _x < WORLD_WIDTH div BLOCK_SIZE; _x++)
{
    _data += string(world_get_block(_layer, _x, _y));
    if (_x != (WORLD_WIDTH div BLOCK_SIZE) - 1) _data += ", ";
}

return string(_data);
