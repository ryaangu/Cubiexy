///ds_grid_check(grid, x, y);
var _grid = argument[0],
    _x    = argument[1],
    _y    = argument[2];
    
//Check for position inside grid
var _check_x = (_x >= 0 && _x <= ds_grid_width(_grid)  - 1),
    _check_y = (_y >= 0 && _y <= ds_grid_height(_grid) - 1);
    
return _check_x && _check_y;
