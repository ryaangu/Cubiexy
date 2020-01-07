///player_write_data(player_instance);
var _player_instance = argument[0];

var _data = "";

//Add the data to the string
_data += string(_player_instance.x)            + ", ";
_data += string(_player_instance.y)            + ", ";
_data += string(_player_instance.sprite_index) + ", ";
_data += string(_player_instance.image_index)  + ", ";
_data += string(_player_instance.image_xscale) + ", ";
_data += string(_player_instance.image_speed)  + ", ";
_data += string(_player_instance.image_alpha);

return string(_data);
