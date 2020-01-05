///ds_grid_create_ext(width, height, value);
var _width  = argument[0],
    _height = argument[1],
    _value  = argument[2];
    
//Create the grid
var _grid = ds_grid_create(_width, _height);

//Clear the grid with value
ds_grid_clear(_grid, _value);

return _grid;
