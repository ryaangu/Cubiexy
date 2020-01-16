///chat_command_help(arguments);
var _arguments = argument[0];

//Get the command information
var _command_name = _arguments[0];

//Check for correct arguments
if (is_chat_arguments_correct(_command_name, _arguments))
{
    //Send the help message
    if (global.staff_permission)
        chat_add_message("~GCOMMAND LIST: /help, /debug, /broadcast, /private, /noclip and /owner."); 
    else
        chat_add_message("~GCOMMAND LIST: /help, /debug, /private and /owner."); 
}
else
{
    //Error
    chat_add_message("~RSYSTEM: Invalid command arguments received!");
}   
