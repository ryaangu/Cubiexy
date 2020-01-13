///handle_account_login();

//Read data
var _result   = packet_read(BOOL),
    _error    = packet_read(STRING),
    _username = packet_read(STRING);
    
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
