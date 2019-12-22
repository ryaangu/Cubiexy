///send_player_destroy();
buffer_seek(global.buffer, buffer_seek_start, 0);

buffer_write(global.buffer, buffer_u16, DATA.PLAYER);
buffer_write(global.buffer, buffer_u8, PLAYER.DESTROY);

network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));
