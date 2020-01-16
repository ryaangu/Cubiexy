///is_chat_arguments_correct(command_name, arguments);
var _command_name = argument[0],
    _arguments    = argument[1];
    
//Get the command argument count
var _argument_count = chat_get_command(_command_name, COMMAND.ARGUMENT_COUNT);

//Check for same argument count and return it
return array_length_1d(_arguments) == _argument_count;
