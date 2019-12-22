///handle_account_login();

//Read data
var _result   = buffer_read(read_buffer, buffer_bool),
    _error    = buffer_read(read_buffer, buffer_string),
    _username = buffer_read(read_buffer, buffer_string);
    
//Show notification
show_notification(_error);
    
//Check for result
if (_result)
{
    //Set the username
    global.username = _username;
    
    //Go to world menu
    transition_go_to(rm_world_menu);
}
