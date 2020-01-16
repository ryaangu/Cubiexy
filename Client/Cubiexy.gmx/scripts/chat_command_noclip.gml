///chat_command_noclip(arguments);
var _arguments = argument[0];

//Get the command information
var _command_name = _arguments[0];

//Check for correct arguments
if (is_chat_arguments_correct(_command_name, _arguments))
{
    //Check for permissions
    if (have_command_permission(_command_name))
    {
        //Enable noclip
        if (!obj_player.noclip)
        {
            obj_player.noclip = true;
            chat_add_message("~GSYSTEM: Noclip enabled!"); 
        }
        else //Disable noclip
        {
            obj_player.noclip = false;
            chat_add_message("~GSYSTEM: Noclip disabled!");
        }
    }
}
else
{
    //Error
    chat_add_message("~RSYSTEM: Invalid command arguments received!");
}   
