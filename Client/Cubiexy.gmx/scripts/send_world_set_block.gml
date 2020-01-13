///send_world_set_block(world_name, layer, x, y, block_id);

//Check for position outside grid
if (!ds_grid_check(global.world_grid[argument[1]], argument[2], argument[3])) return false;

//Send
packet_clear();

packet_write(USHORT, DATA.WORLD);
packet_write(BYTE,   WORLD.SET_BLOCK);
packet_write(STRING, string_upper(argument[0]));
packet_write(STRING, world_get_layer_name(argument[1]));
packet_write(BYTE,   argument[2]);
packet_write(BYTE,   argument[3]);
packet_write(BYTE,   argument[4]);

packet_send();
