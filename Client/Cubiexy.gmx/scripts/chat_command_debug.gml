///chat_command_debug(arguments);
var _arguments = argument[0];

//Get the command information
var _command_name = _arguments[0];

//Check for correct arguments
if (is_chat_arguments_correct(_command_name, _arguments))
{
    //Enable debug
    if (!global.debug)
    {
        global.debug = true;
        chat_add_message("~GSYSTEM: Debug enabled!"); 
    }
    else //Disable debug
    {
        global.debug = false;
        chat_add_message("~GSYSTEM: Debug disabled!");
    }
}
else
{
    //Error
    chat_add_message("~RSYSTEM: Invalid command arguments received!");
}   
