///chat_get_command(command_name, information);
var _command_name = argument[0],
    _information  = argument[1];

//Get the array with information
var _array = ds_map_find_value(global.command_database, string_upper(_command_name));

//Return the information
return _array[_information];
