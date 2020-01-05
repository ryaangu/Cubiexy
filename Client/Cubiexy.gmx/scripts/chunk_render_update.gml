///chunk_render_update(layer, x, y);
var _layer   = argument[0],
    _x       = argument[1],
    _y       = argument[2];
    
//Get the chunk and block positions
var _chunk_x = floor((_x * BLOCK_SIZE) / (CHUNK_SIZE * BLOCK_SIZE)),
    _chunk_y = floor((_y * BLOCK_SIZE) / (CHUNK_SIZE * BLOCK_SIZE));
    
var _x1 = (_chunk_x * CHUNK_SIZE) * BLOCK_SIZE,
    _y1 = (_chunk_y * CHUNK_SIZE) * BLOCK_SIZE;
        
var _block_x = ((_x * BLOCK_SIZE) - _x1) div BLOCK_SIZE,
    _block_y = ((_y * BLOCK_SIZE) - _y1) div BLOCK_SIZE;
    
//Get the draw block positions
var _draw_block_x = _block_x * BLOCK_SIZE,
    _draw_block_y = _block_y * BLOCK_SIZE;
    
//Get the surface
var _surface = ds_grid_get(global.surface_grid[_layer], _chunk_x, _chunk_y);
    
//Check if the surface exists
if (surface_exists(_surface))
{
    //Start redrawing inside surface
    surface_set_target(_surface);
    
    //Draw null block
    draw_null_block(_draw_block_x, _draw_block_y);
    
    //Get the block id
    var _block_id = ds_grid_get(global.world_grid[_layer], _block_x, _block_y);
    
    //Check if the block id is not null
    if (_block_id > BLOCK.NULL)
    {
        //Shadow control
        var _radius = 0,
            _dist   = 1;
        
        while (_radius <= shadow_distance)
        {
            if (ds_grid_value_disk_exists(global.world_grid[_layer], _block_x, _block_y, _radius, BLOCK.NULL))
            {
                _dist   = _radius;
                _radius = shadow_distance + 1;
            }
            else
            {
                _radius++;
                _dist = _radius;
            }
        }
        
        //Get the block color
        var _color = c_white;
        if (database_get_block(_block_id, BLOCK_INFORMATION.SHADOW)) _color = merge_colour(c_white, c_gray, (_dist - 1) / shadow_distance);
    
        //Draw the block
        draw_block(_block_id, _draw_block_x, _draw_block_y, BLOCK_SIZE, _color);
    }
    
    surface_reset_target();
}
