///chat_command_exists(command_name);
var _command_name = argument[0];

//Check for command name inside ds map and return it
return ds_map_exists(global.command_database, string_upper(_command_name));
