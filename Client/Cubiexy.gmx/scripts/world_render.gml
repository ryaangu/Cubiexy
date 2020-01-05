///world_render();

//Get the load positions
load_x = obj_player.x div (CHUNK_SIZE * BLOCK_SIZE);
load_y = obj_player.y div (CHUNK_SIZE * BLOCK_SIZE);

load_x = clamp(load_x, load_distance, CHUNK_MAX_HORIZONTAL - load_distance);
load_y = clamp(load_y, load_distance, CHUNK_MAX_VERTICAL   - load_distance);

//Get the unload positions
var _unload_left  = max(load_x - unload_distance, 0),
    _unload_right = min(load_x + unload_distance, CHUNK_MAX_HORIZONTAL),
    _unload_up    = max(load_y - unload_distance, 0),
    _unload_down  = min(load_y + unload_distance, CHUNK_MAX_VERTICAL);

//Loop through layers
for (var _layer = 0; _layer < LAYER.COUNT; _layer++)
{
    //Loop through unload positions
    for (var _chunk_y = _unload_up;   _chunk_y <= _unload_down;  _chunk_y++)
    for (var _chunk_x = _unload_left; _chunk_x <= _unload_right; _chunk_x++)
    {
        //Check for chunk position in grid
        if (ds_grid_check(global.surface_grid[_layer], _chunk_x, _chunk_y))
        {
            //Check for chunk position in load distance
            if ((_chunk_x >= (load_x - load_distance) || _chunk_x < (load_x + load_distance)) || (_chunk_y >= (load_y - load_distance) || _chunk_y < (load_y + load_distance)))
            {
                //Render the chunk
                chunk_render(_layer, _chunk_x, _chunk_y);
            }
            else
            {
                //Destroy the chunk
                chunk_destroy(_layer, _chunk_x, _chunk_y);
            }
        }
    }
}
