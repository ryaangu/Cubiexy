///have_command_permission(command_name);
var _command_name = argument[0];

//Get the command permission
var _command_permission = chat_get_command(_command_name, COMMAND.PERMISSION);

//Check for same permission and return it
return _command_permission >= global.command_permission;
