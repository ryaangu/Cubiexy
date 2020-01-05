///chunk_destroy(layer, chunk_x, chunk_y);
var _layer   = argument[0],
    _chunk_x = argument[1],
    _chunk_y = argument[2];
    
//Get the surface
var _surface = ds_grid_get(global.surface_grid[_layer], _chunk_x, _chunk_y);

//Check if the surface exists and destroy it
if (surface_exists(_surface))
{
    surface_free(_surface);
    ds_grid_set(global.surface_grid[_layer], _chunk_x, _chunk_y, -1);
}
