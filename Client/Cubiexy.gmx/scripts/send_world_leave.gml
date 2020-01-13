///send_world_leave();
packet_clear();

packet_write(USHORT, DATA.WORLD);
packet_write(BYTE,   WORLD.LEAVE);

packet_send();
