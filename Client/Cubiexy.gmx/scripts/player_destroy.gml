///player_destroy(client_id);
var _client_id = argument[0];

//Get the player
var _player = ds_map_find_value(global.player_map, string(_client_id));

//Destroy the player
instance_destroy(_player);

//Delete the key from map
ds_map_delete(global.player_map, string(_client_id));
