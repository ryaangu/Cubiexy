///view_check(x, y);
var _x = argument[0],
    _y = argument[1];
    
//Check for position inside grid
var _check_x = (_x >= view_xview - 32 && _x <= view_xview + view_wview),
    _check_y = (_y >= view_yview - 32 && _y <= view_yview + view_hview);
    
return _check_x && _check_y;
