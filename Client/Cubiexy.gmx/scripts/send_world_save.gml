///send_world_save(world_name, layer);
buffer_seek(global.buffer, buffer_seek_start, 0);

buffer_write(global.buffer, buffer_u16, DATA.WORLD);
buffer_write(global.buffer, buffer_u8, WORLD.SAVE);
buffer_write(global.buffer, buffer_string, string_upper(argument[0]));
buffer_write(global.buffer, buffer_u8, WORLD_WIDTH  div BLOCK_SIZE);
buffer_write(global.buffer, buffer_u8, WORLD_HEIGHT div BLOCK_SIZE);
buffer_write(global.buffer, buffer_string, world_get_layer_name(argument[1]));

for (var _y = 0; _y < WORLD_HEIGHT div BLOCK_SIZE; _y++)
for (var _x = 0; _x < WORLD_WIDTH  div BLOCK_SIZE; _x++)
{
    buffer_write(global.buffer, buffer_u8, world_get_block(argument[1], _x * BLOCK_SIZE, _y * BLOCK_SIZE));
}

network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));
