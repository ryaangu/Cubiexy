///player_exists(client_id);
var _client_id = argument[0];

return ds_map_exists(global.player_map, string(_client_id));
