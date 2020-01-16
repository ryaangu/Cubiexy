///chat_add_command(command_name, argument_count, callback_script, information, permission);

//Create an array with block information
var _array;
    
//Add the values to the array
for (var _index = 0; _index < argument_count; _index++)
{
    _array[_index] = argument[_index];
}
    
//Add the array to the database
ds_map_add(global.command_database, string_upper(argument[0]), _array);
