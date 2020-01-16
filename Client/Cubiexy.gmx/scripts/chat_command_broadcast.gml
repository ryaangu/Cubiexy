///chat_command_broadcast(arguments);
var _arguments = argument[0];

//Get the command information
var _command_name = _arguments[0];

//Check for correct arguments
if (array_length_1d(_arguments) >= 2)
{
    //Check for permissions
    if (have_command_permission(_command_name))
    {
        //Get the complete text
        var _text = "";
        
        for (var i = 1; i < array_length_1d(_arguments); i++)
            _text += string(_arguments[i]) + " ";
    
        //Send the message
        send_chat_everyone("~GBroadcast from " + global.username + ": " + string(_text));
    }
}
else
{
    //Error
    chat_add_message("~RSYSTEM: Invalid command arguments received!");
}   
