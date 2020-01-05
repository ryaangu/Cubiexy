///handle_world_create();

//Read data
var _world_name = buffer_read(read_buffer, buffer_string),
    _result     = buffer_read(read_buffer, buffer_bool),
    _error      = buffer_read(read_buffer, buffer_string);
    
//Add the world name to the worlds created list
ds_list_add(global.worlds_created, _world_name);

//Show notification
show_notification(_error);
