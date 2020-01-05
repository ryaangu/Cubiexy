///handle_player_destroy();

//Read data
var _client_id = buffer_read(read_buffer, buffer_u16);

//Check if same client id
if (_client_id == global.client_id) return false;

//Check for player inside map
if (ds_map_exists(global.player_map, string(_client_id)))
{
    //Get the player
    var _player = ds_map_find_value(global.player_map, string(_client_id));

    //Destroy the player
    instance_destroy(_player);
    
    //Delete the key from map
    ds_map_delete(global.player_map, string(_client_id));
}
