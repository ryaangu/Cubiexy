///send_ping();
packet_clear();

packet_write(USHORT, DATA.CLIENT);
packet_write(BYTE,   CLIENT.PING);
packet_write(UINT,   current_time);

packet_send();
