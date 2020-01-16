///handle_player_destroy();

//Read data
var _client_id = packet_read(USHORT);

//Check for stuff
if (_client_id == global.client_id) return false;
if (room != rm_world) return false;

//Destroy the player
if (player_exists(_client_id))
{
    player_destroy(_client_id);
}
