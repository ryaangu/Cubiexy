///chat_check_variable(message, variable, value);
var _message  = argument[0],
    _variable = argument[1],
    _value    = argument[2];

//Check for the variable in message
if (string_pos(string_upper(_variable), _message))
{
    //Replace the variable with the value
    _message = string_replace_all(_message, string_upper(_variable), string(_value));
}

return string(_message);
