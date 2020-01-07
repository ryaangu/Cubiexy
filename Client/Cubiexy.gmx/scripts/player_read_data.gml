///player_read_data(player_instance, data);
var _player_instance = argument[0],
    _data            = argument[1];

//Split the data into array
var _data_array = string_split(_data, ", ");

//Set the player data
_player_instance.x            = real(_data_array[0]);
_player_instance.y            = real(_data_array[1]);
_player_instance.sprite_index = real(_data_array[2]);
_player_instance.image_index  = real(_data_array[3]);
_player_instance.image_xscale = real(_data_array[4]);
_player_instance.image_speed  = real(_data_array[5]);
_player_instance.image_alpha  = real(_data_array[6]);
