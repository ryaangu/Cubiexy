///handle_player_update();

//Read data
var _client_id    = buffer_read(read_buffer, buffer_u16),
    _data         = buffer_read(read_buffer, buffer_string),
    _name         = buffer_read(read_buffer, buffer_string);
    
//Check if same client id
if (_client_id == global.client_id) return false;

//Create the player
if (!player_exists(_client_id))
    player_create(_client_id);

//Get the player
var _player = player_get(_client_id);

//Update the player
if (instance_exists(_player))
{
    player_read_data(_player, _data);
    _player.name = _name;
}
else
{
    //Create the player
    player_create(_client_id);
}
