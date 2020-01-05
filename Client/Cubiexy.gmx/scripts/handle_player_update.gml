///handle_player_update();

//Read data
var _client_id    = buffer_read(read_buffer, buffer_u16),
    _x            = buffer_read(read_buffer, buffer_s16),
    _y            = buffer_read(read_buffer, buffer_s16),
    _sprite_index = buffer_read(read_buffer, buffer_u8),
    _image_index  = buffer_read(read_buffer, buffer_u8),
    _image_xscale = buffer_read(read_buffer, buffer_s16),
    _image_speed  = buffer_read(read_buffer, buffer_f32),
    _image_alpha  = buffer_read(read_buffer, buffer_f32),
    _name         = buffer_read(read_buffer, buffer_string);
    
//Check if same client id
if (_client_id == global.client_id) return false;

//Check for player inside map
if (!ds_map_exists(global.player_map, string(_client_id)))
{
    //Create the player
    var _player           = instance_create(0, 0, obj_other_player);
        _player.client_id = _client_id;
    
    //Add to the map
    ds_map_add(global.player_map, string(_client_id), _player);
}

//Get the player
var _player = ds_map_find_value(global.player_map, string(_client_id));

//Update the player
if (instance_exists(_player))
{
    _player.x            = _x;
    _player.y            = _y;
    _player.sprite_index = _sprite_index;
    _player.image_index  = _image_index;
    _player.image_xscale = _image_xscale;
    _player.image_speed  = _image_speed;
    _player.image_alpha  = _image_alpha;
    _player.name         = _name;
}
else
{
    //Create the player
    var _player           = instance_create(0, 0, obj_other_player);
        _player.client_id = _client_id;
    
    //Add to the map
    ds_map_replace(global.player_map, string(_client_id), _player);
}
