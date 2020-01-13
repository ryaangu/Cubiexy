///send_player_update();
packet_clear();

packet_write(USHORT, DATA.PLAYER);
packet_write(BYTE,   PLAYER.UPDATE);
packet_write(STRING, player_write_data(obj_player));
packet_write(STRING, global.username);

packet_send();
