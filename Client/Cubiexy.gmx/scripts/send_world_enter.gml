///send_world_enter(world_name);
packet_clear();

packet_write(USHORT, DATA.WORLD);
packet_write(BYTE,   WORLD.ENTER);
packet_write(STRING, string_upper(argument[0]));

packet_send();
