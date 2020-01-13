///handle_world_create();

//Read data
var _world_name = packet_read(STRING),
    _result     = packet_read(BOOL),
    _error      = packet_read(STRING);
    
//Add the world name to the worlds created list
ds_list_add(global.worlds_created, _world_name);

//Show notification
show_notification(_error);
