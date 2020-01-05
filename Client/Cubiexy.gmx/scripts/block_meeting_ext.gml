///block_meeting_ext(x, y, block_id);
var _x        = argument[0],
    _y        = argument[1],
    _block_id = argument[2];
    
//Variables
var _layer = LAYER.FOREGROUND;
    
//Get the previous position
var _x_previous = x,
    _y_previous = y;
    
//Set the position
x = _x;
y = _y;
    
//Check for meeting
var _meeting = (world_get_block(_layer, bbox_left, bbox_top)     == _block_id) ||
               (world_get_block(_layer, bbox_right, bbox_top)    == _block_id) ||
               (world_get_block(_layer, bbox_left, bbox_bottom)  == _block_id) ||
               (world_get_block(_layer, bbox_right, bbox_bottom) == _block_id) ||
               (world_get_block(_layer, x, bbox_top)             == _block_id) ||
               (world_get_block(_layer, x, bbox_bottom)          == _block_id) ||
               (world_get_block(_layer, bbox_left, y)            == _block_id) ||
               (world_get_block(_layer, bbox_right, y)           == _block_id) ||
               (world_get_block(_layer, x, y)                    == _block_id);

//Set the position to the previous
x = _x_previous;
y = _y_previous;

return _meeting;
