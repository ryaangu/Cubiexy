///send_world_save(world_name, layer);

//Loop through world height and send every row
for (var _y = 0; _y < WORLD_HEIGHT div BLOCK_SIZE; _y++)
{
    var _buffer = buffer_create(1200, buffer_fixed, 1);
    buffer_seek(_buffer, buffer_seek_start, 0);
    
    buffer_write(_buffer, buffer_u16, DATA.WORLD);
    buffer_write(_buffer, buffer_u8, WORLD.SAVE);
    buffer_write(_buffer, buffer_string, string_upper(argument[0]));
    buffer_write(_buffer, buffer_string, world_get_layer_name(argument[1]));
    buffer_write(_buffer, buffer_u8, _y);
    buffer_write(_buffer, buffer_string, world_write_horizontal_blocks(argument[1], _y));
    
    network_send_raw(global.socket, _buffer, buffer_tell(_buffer));
    buffer_delete(_buffer);
}
