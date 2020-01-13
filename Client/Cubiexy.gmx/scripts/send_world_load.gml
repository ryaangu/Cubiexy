///send_world_load(world_name, layer);
packet_clear();

packet_write(USHORT, DATA.WORLD);
packet_write(BYTE,   WORLD.LOAD);
packet_write(STRING, string_upper(argument[0]));
packet_write(STRING, world_get_layer_name(argument[1]));

packet_send();
