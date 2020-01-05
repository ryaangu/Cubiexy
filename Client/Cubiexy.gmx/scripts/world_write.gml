///world_write(layer);
var _layer = argument[0];

var _map = ds_map_create();

for (var _y = 0; _y < WORLD_HEIGHT div BLOCK_SIZE; _y++)
{
    var _block_data = "";

    for (var _x = 0; _x < WORLD_WIDTH  div BLOCK_SIZE; _x++)
    {
        _block_data += string(world_get_block(1, _x, _y)) + ", ";
    }
    
    ds_map_add(_map, string(_y), string(_block_data));
}

var _data = json_encode(_map);
ds_map_destroy(_map);

return string(_data);
