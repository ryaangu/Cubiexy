///chunk_update(layer, x, y);
var _layer = argument[0],
    _x     = argument[1],
    _y     = argument[2];
    
//Get chunk positions
var _x_chunk = _x div (CHUNK_SIZE * BLOCK_SIZE),
    _y_chunk = _y div (CHUNK_SIZE * BLOCK_SIZE);
    
//Get the reload positions
var _reload_left  = max(_x_chunk - obj_world.reload_distance, 0),
    _reload_right = min(_x_chunk + obj_world.reload_distance, CHUNK_MAX_HORIZONTAL - 1),
    _reload_up    = max(_y_chunk - obj_world.reload_distance, 0),
    _reload_down  = min(_y_chunk + obj_world.reload_distance, CHUNK_MAX_VERTICAL - 1);
    
//Loop through reload positions
for (var _chunk_y = _reload_up;   _chunk_y <= _reload_down;  _chunk_y++)
for (var _chunk_x = _reload_left; _chunk_x <= _reload_right; _chunk_x++)
{
    //Destroy the chunk
    chunk_render_update(_layer, _chunk_x, _chunk_y, _x div BLOCK_SIZE, _y div BLOCK_SIZE);
}
