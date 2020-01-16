///database_add_block(block_id, solid, shadow);
var _block_id = argument[0],
    _solid    = argument[1],
    _shadow   = argument[2];
    
//Create an array with block information
var _array;
    _array[BLOCK_INFORMATION.SOLID]  = _solid;
    _array[BLOCK_INFORMATION.SHADOW] = _shadow;
    
//Add the block array to the database
ds_map_add(global.block_database, string(_block_id), _array);
