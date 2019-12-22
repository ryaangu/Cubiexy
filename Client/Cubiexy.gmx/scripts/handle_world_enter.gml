///handle_account_login();

//Read data
var _result      = buffer_read(read_buffer, buffer_bool),
    _error       = buffer_read(read_buffer, buffer_string),
    _world_name  = buffer_read(read_buffer, buffer_string),
    _world_owner = buffer_read(read_buffer, buffer_string);
    
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
