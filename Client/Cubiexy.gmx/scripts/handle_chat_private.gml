///handle_chat_private();

//Read data
var _text     = packet_read(STRING),
    _username = packet_read(STRING);
    
//Add the message to the chat
chat_add_message("~GMessage from " + string_upper(_username) + ": " + _text);
