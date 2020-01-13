///chunk_render(layer, chunk_x, chunk_y);
var _layer   = argument[0],
    _chunk_x = argument[1],
    _chunk_y = argument[2];
    
//Get the surface
var _surface = ds_grid_get(global.surface_grid[_layer], _chunk_x, _chunk_y);

//Check if the surface doesn't exists
if (!surface_exists(_surface))
{
    //Create the surface
    _surface = surface_create(CHUNK_SIZE * BLOCK_SIZE, CHUNK_SIZE * BLOCK_SIZE);
    
    //Start drawing inside the surface
    surface_set_target(_surface);
    draw_clear_alpha(c_black, 0);

    //Loop through chunk size
    for (var _y = 0; _y < CHUNK_SIZE; _y++)   
    for (var _x = 0; _x < CHUNK_SIZE; _x++) 
    {
        //Get the block position
        var _block_x = _chunk_x * CHUNK_SIZE + _x,
            _block_y = _chunk_y * CHUNK_SIZE + _y;
        
        //Get the block id
        var _block_id = ds_grid_get(global.world_grid[_layer], _block_x, _block_y);
        
        //Check if the block id is not null
        if (_block_id > BLOCK.NULL)
        {
            /*//Shadow control
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
            }*/
            
            //Get the block color
            var _color = c_white;
            //if (database_get_block(_block_id, BLOCK_INFORMATION.SHADOW)) _color = merge_colour(c_white, c_gray, (_dist - 1) / shadow_distance);
        
            //Draw the block
            draw_block(_block_id, _x * BLOCK_SIZE, _y * BLOCK_SIZE, BLOCK_SIZE, _color);
        }
    } 
    
    surface_reset_target();
    
    //Set the surface in grid
    ds_grid_set(global.surface_grid[_layer], _chunk_x, _chunk_y, _surface);
}

//Check if the surface exists and draw it
if (surface_exists(_surface))
{
    //Check for layer and draw shadow
    if (_layer == LAYER.FOREGROUND) 
    {
        //Draw the black surface
        draw_surface_ext(_surface, _chunk_x * CHUNK_SIZE * BLOCK_SIZE + 5, _chunk_y * CHUNK_SIZE * BLOCK_SIZE + 5, 1, 1, 0, c_black, 0.70);
    }
    
    //Draw the surface
    draw_surface(_surface, _chunk_x * CHUNK_SIZE * BLOCK_SIZE, _chunk_y * CHUNK_SIZE * BLOCK_SIZE);
    
    //Check for layer and draw black surface
    if (_layer == LAYER.BACKGROUND)
    {
        //Draw the black surface
        draw_surface_ext(_surface, _chunk_x * CHUNK_SIZE * BLOCK_SIZE, _chunk_y * CHUNK_SIZE * BLOCK_SIZE, 1, 1, 0, c_black, 0.40);
    }
}
