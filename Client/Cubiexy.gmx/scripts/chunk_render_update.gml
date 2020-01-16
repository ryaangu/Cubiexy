///chunk_render_update(layer, chunk_x, chunk_y, x, y);
var _layer   = argument[0],
    _chunk_x = argument[1],
    _chunk_y = argument[2],
    _x       = argument[3],
    _y       = argument[4];
    
show_debug_message(string_position(_x, _y));
    
//Get the block positions
var _block_x = _x / BLOCK_SIZE,//_chunk_x * CHUNK_SIZE * BLOCK_SIZE + _x,
    _block_y = _y / BLOCK_SIZE;//_chunk_y * CHUNK_SIZE * BLOCK_SIZE + _y;
    
show_debug_message(string_position(_block_x, _block_y));
    
//Get the surface
var _surface = ds_grid_get(global.surface_grid[_layer], _chunk_x, _chunk_y);

//Check if the surface exists and destroy it
if (surface_exists(_surface))
{
    //Draw null block
    draw_null_block(_block_x, _block_y);
    
    //Draw the block
    var _block_id = world_get_block(_layer, _x, _y);
    
    if (_block_id > 0)
    {
        draw_block(_block_id, _block_x, _block_y, BLOCK_SIZE, c_white);
    }
}
