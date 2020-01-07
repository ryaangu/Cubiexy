///handle_player_destroy();

//Read data
var _client_id = buffer_read(read_buffer, buffer_u16);

//Check if same client id
if (_client_id == global.client_id) return false;

//Destroy the player
if (player_exists(_client_id))
    player_destroy(_client_id);
