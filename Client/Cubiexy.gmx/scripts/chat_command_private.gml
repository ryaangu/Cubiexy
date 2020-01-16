///chat_command_private(arguments);
var _arguments = argument[0];

//Get the command information
var _command_name = _arguments[0];

//Check for correct arguments
if (array_length_1d(_arguments) >= 3)
{
    //Get the complete text
    var _text = "";
    
    for (var i = 2; i < array_length_1d(_arguments); i++)
        _text += string(_arguments[i]) + " ";

    //Send the message
    send_chat_private(_text, _arguments[1]);
}
else
{
    //Error
    chat_add_message("~RSYSTEM: Invalid command arguments received!");
}   
