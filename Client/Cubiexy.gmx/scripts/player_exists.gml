///player_exists(client_id);
var _client_id = string(argument[0]);

return ds_map_exists(global.player_map, _client_id);
