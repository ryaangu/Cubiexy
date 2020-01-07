///player_get(client_id);
var _client_id = argument[0];

return ds_map_find_value(global.player_map, string(_client_id));
