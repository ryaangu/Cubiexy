///chat_command_owner(arguments);
var _arguments = argument[0];

//Get the command information
var _command_name = _arguments[0];

//Check for correct arguments
if (is_chat_arguments_correct(_command_name, _arguments))
{
    //Send the owner name
    chat_add_message("~GSYSTEM: The owner of the world is " + string(global.world_owner)); 
}
else
{
    //Error
    chat_add_message("~RSYSTEM: Invalid command arguments received!");
}   
