///send_world_create(world_name, world_owner);
packet_clear();

packet_write(USHORT, DATA.WORLD);
packet_write(BYTE,   WORLD.CREATE);
packet_write(STRING, string_upper(argument[0]));
packet_write(STRING, string_upper(argument[1]));

packet_send();
