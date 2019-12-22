///view_check(x, y);
var _x = argument[0],
    _y = argument[1];
    
//Check for position inside grid
var _check_x = (_x >= view_xview && _x <= view_wview),
    _check_y = (_y >= view_yview && _y <= view_hview);
    
return _check_x && _check_y;
