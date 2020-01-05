///send_world_set_block(world_name, layer, x, y, block_id);

//Check for position outside grid
if (!ds_grid_check(global.world_grid[argument[1]], argument[2], argument[3])) return false;

buffer_seek(global.buffer, buffer_seek_start, 0);

buffer_write(global.buffer, buffer_u16, DATA.WORLD);
buffer_write(global.buffer, buffer_u8, WORLD.SET_BLOCK);
buffer_write(global.buffer, buffer_string, string_upper(argument[0]));
buffer_write(global.buffer, buffer_string, world_get_layer_name(argument[1]));
buffer_write(global.buffer, buffer_u8, argument[2]);
buffer_write(global.buffer, buffer_u8, argument[3]);
buffer_write(global.buffer, buffer_u16, argument[4]);

network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));
