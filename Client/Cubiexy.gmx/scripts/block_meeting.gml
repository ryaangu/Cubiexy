///block_meeting(x, y);
var _x = argument[0],
    _y = argument[1];
    
//Variables
var _layer = LAYER.FOREGROUND;
    
//Get the previous position
var _x_previous = x,
    _y_previous = y;
    
//Set the position
x = _x;
y = _y;
    
//Check for meeting
var _meeting = (database_get_block(world_get_block(_layer, floor(bbox_left div BLOCK_SIZE), floor(bbox_top div BLOCK_SIZE)), BLOCK_INFORMATION.SOLID))     ||
               (database_get_block(world_get_block(_layer, floor(bbox_right div BLOCK_SIZE), floor(bbox_top div BLOCK_SIZE)), BLOCK_INFORMATION.SOLID))    ||
               (database_get_block(world_get_block(_layer, floor(bbox_left div BLOCK_SIZE), floor(bbox_bottom div BLOCK_SIZE)), BLOCK_INFORMATION.SOLID))  ||
               (database_get_block(world_get_block(_layer, floor(bbox_right div BLOCK_SIZE), floor(bbox_bottom div BLOCK_SIZE)), BLOCK_INFORMATION.SOLID)) ||
               (database_get_block(world_get_block(_layer, floor(x div BLOCK_SIZE), floor(bbox_top div BLOCK_SIZE)), BLOCK_INFORMATION.SOLID))             ||
               (database_get_block(world_get_block(_layer, floor(x div BLOCK_SIZE), floor(bbox_bottom div BLOCK_SIZE)), BLOCK_INFORMATION.SOLID))          ||
               (database_get_block(world_get_block(_layer, floor(bbox_left div BLOCK_SIZE), floor(y div BLOCK_SIZE)), BLOCK_INFORMATION.SOLID))            ||
               (database_get_block(world_get_block(_layer, floor(bbox_right div BLOCK_SIZE), floor(y div BLOCK_SIZE)), BLOCK_INFORMATION.SOLID))           ||
               (database_get_block(world_get_block(_layer, floor(x div BLOCK_SIZE), floor(y div BLOCK_SIZE)), BLOCK_INFORMATION.SOLID));

//Set the position to the previous
x = _x_previous;
y = _y_previous;

return _meeting;
