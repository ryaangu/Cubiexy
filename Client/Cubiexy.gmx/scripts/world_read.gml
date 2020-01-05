///world_read(layer, data);
var _layer = argument[0],
    _data  = argument[1];
    
var _data = json_decode(_data);

for (var _y = 0; _y < WORLD_HEIGHT div BLOCK_SIZE; _y++)
{  
    if (ds_exists(_data, ds_type_map))
    {
        var _block_data = string_split(_data[? string(_y)], ", ");
        
        for (var _x = 0; _x < WORLD_WIDTH  div BLOCK_SIZE; _x++)
        {
            world_set_block(1, _x, _y, real(_block_data[_x]));
        }
    }
}

ds_map_destroy(_data);
