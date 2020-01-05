///world_write_data(layer);
var _layer = argument[0];

//Create a map for the layer data
var _layer_data = ds_map_create(),
    _data       = "";
    
//Add tnhe layer id to the layer data map
ds_map_add(_layer_data, "layer_id", _layer);

//Loop through layer blocks
for (var _y = 0; _y < WORLD_HEIGHT div BLOCK_SIZE; _y++)
{
    var _block_data = "";

    for (var _x = 0; _x < WORLD_WIDTH div BLOCK_SIZE; _x++)
    {
        //Add the block id to the data
        _block_data += string(world_get_block(_layer, _x * BLOCK_SIZE, _y * BLOCK_SIZE));
        if (_x != (WORLD_WIDTH div BLOCK_SIZE) - 1) _block_data += ", ";
    } 
    
    //Add the block data to the layer data map
    ds_map_add(_layer_data, string(_y), _block_data);
}

//Get the json from layer data map
_data = json_encode(_layer_data);

//Destroy the layer data map
ds_map_destroy(_layer_data);

return _data;
