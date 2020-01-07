///send_player_update();
buffer_seek(global.buffer, buffer_seek_start, 0);

buffer_write(global.buffer, buffer_u16, DATA.PLAYER);
buffer_write(global.buffer, buffer_u8, PLAYER.UPDATE);
buffer_write(global.buffer, buffer_string, player_write_data(obj_player));
buffer_write(global.buffer, buffer_string, global.username);

network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));
