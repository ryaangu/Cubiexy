///send_player_destroy();
packet_clear();

packet_write(USHORT, DATA.PLAYER);
packet_write(BYTE,   PLAYER.DESTROY);

packet_send();
