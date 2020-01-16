///handle_player_update();

//Read data
var _client_id    = packet_read(USHORT),
    _data         = packet_read(STRING),
    _name         = packet_read(STRING);
    
//Check for stuff
if (_client_id == global.client_id) return false;
if (room != rm_world) return false;

//Create the player
if (!player_exists(_client_id))
    player_create(_client_id);

//Get the player
var _player = player_get(_client_id);

//Update the player
player_read_data(_player, _data);
_player.name = _name;
