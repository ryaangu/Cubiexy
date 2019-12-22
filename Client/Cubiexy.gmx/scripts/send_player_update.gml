///send_player_update();
buffer_seek(global.buffer, buffer_seek_start, 0);

buffer_write(global.buffer, buffer_u16, DATA.PLAYER);
buffer_write(global.buffer, buffer_u8, PLAYER.UPDATE);
buffer_write(global.buffer, buffer_s16, x);
buffer_write(global.buffer, buffer_s16, y);
buffer_write(global.buffer, buffer_u8, sprite_index);
buffer_write(global.buffer, buffer_u8, image_index);
buffer_write(global.buffer, buffer_s16, image_xscale);
buffer_write(global.buffer, buffer_f32, image_speed);
buffer_write(global.buffer, buffer_f32, image_alpha);
buffer_write(global.buffer, buffer_string, global.username);

network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));
