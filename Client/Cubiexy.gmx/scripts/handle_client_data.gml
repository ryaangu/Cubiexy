///handle_client_data();

//Read data
var _client_id   = packet_read(USHORT),
    _message     = packet_read(STRING),
    _version     = packet_read(STRING),
    _maintenance = packet_read(STRING),
    _staff       = packet_read(STRING);

//Set the variables
global.client_id   = _client_id;
global.message     = _message;
global.version     = _version;
global.maintenance = _maintenance;
global.staff       = _staff;

//Check the variables

//Version
if (GAME_VERSION != global.version && room != rm_account_menu)
{
    //Leave and destroy
    send_world_leave();
    send_account_logout();
    send_player_destroy();
    
    //Go to the main menu
    show_notification("Please update your client!");
    transition_go_to(rm_account_menu);
}

//Maintenance
if (global.maintenance == "true" && room != rm_account_menu && !global.staff_permission)
{
    //Leave and destroy
    send_world_leave();
    send_account_logout();
    send_player_destroy();
    
    //Go to the main menu
    show_notification("Maintenance!");
    transition_go_to(rm_account_menu);
}

//Staff
if (string_pos(global.username, global.staff))
{
    //Add the staff permission
    global.staff_permission   = true;
    global.command_permission = COMMAND_PERMISSION.STAFF;
}
else
{
    //Remove the staff permission
    global.staff_permission   = false;
    global.command_permission = COMMAND_PERMISSION.EVERYONE;
}
