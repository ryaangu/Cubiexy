///handle_chat_world();

//Read data
var _text = packet_read(STRING);
    
//Add the message to the chat
chat_add_message(_text);
