///is_chat_command(text);
var _text = argument[0];

//Check for /
return string_copy(_text, 1, 1) == "/";
