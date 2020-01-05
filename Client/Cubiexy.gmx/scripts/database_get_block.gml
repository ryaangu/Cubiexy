///database_get_block(block_id, information);
var _block_id    = argument[0],
    _information = argument[1];

//Get the array with block information
var _array = ds_map_find_value(global.block_database, string(_block_id));

//Return the block information
return _array[_information];
