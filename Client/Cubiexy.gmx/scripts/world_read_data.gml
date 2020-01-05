///world_read_data(json_string);
var _json_string = argument[0];

//Decode the layer data map
var _layer_data = json_decode(_json_string);

//Get the layer
var _layer = real(ds_map_find_value(_layer_data, "layer_id"));

//Loop through world blocks
for (var _y = 0; _y < WORLD_HEIGHT div BLOCK_SIZE; _y++)
{
    //Split the x blocks
    var _block_data = string_split(ds_map_find_value(_layer_data, string(_y)), ", ");

    //Add the block id to block data variable
    for (var _x = 0; _x < WORLD_WIDTH div BLOCK_SIZE; _x++)
    {    
        //Set the block data
        world_set_block(_layer, _x * BLOCK_SIZE, _y * BLOCK_SIZE, real(_block_data[_x]));
    }
}

//Destroy the layer data map
ds_map_destroy(_layer_data);
