///player_create(client_id);
var _client_id = argument[0];

//Create the player
var _player           = instance_create(0, 0, obj_other_player);
    _player.client_id = _client_id;

//Add to the map
ds_map_add(global.player_map, string(_client_id), _player);
