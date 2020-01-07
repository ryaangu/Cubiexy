///send_world_load(world_name, layer);
buffer_seek(global.buffer, buffer_seek_start, 0);

buffer_write(global.buffer, buffer_u16, DATA.WORLD);
buffer_write(global.buffer, buffer_u8, WORLD.LOAD);
buffer_write(global.buffer, buffer_string, string_upper(argument[0]));
buffer_write(global.buffer, buffer_string, world_get_layer_name(argument[1]));

network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));
