///chat_execute_command(command_name, arguments);
var _command_name = argument[0],
    _arguments    = argument[1];
    
//Get the command script
var _command_script = chat_get_command(_command_name, COMMAND.CALLBACK_SCRIPT);

//Execute the script
if (script_exists(_command_script))
    script_execute(_command_script, _arguments);
