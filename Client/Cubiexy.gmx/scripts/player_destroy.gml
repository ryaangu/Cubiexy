///player_destroy(client_id);
var _client_id = string(argument[0]);

//Get the player
var _player = player_get(_client_id);

//Destroy the player
instance_destroy(_player);

//Delete the key from map
ds_map_delete(global.player_map, _client_id);
