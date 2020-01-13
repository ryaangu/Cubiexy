///handle_world_enter();

//Read data
var _result      = packet_read(BOOL),
    _error       = packet_read(STRING),
    _world_name  = packet_read(STRING),
    _world_owner = packet_read(STRING);
    
//Show notification
show_notification(_error);
    
//Check for result
if (_result)
{
    //Set the world information
    global.world_name  = _world_name;
    global.world_owner = _world_owner;
    
    //Go to world room
    transition_go_to(rm_world);
}
