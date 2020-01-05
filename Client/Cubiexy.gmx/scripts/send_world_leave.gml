///send_world_leave();
buffer_seek(global.buffer, buffer_seek_start, 0);

buffer_write(global.buffer, buffer_u16, DATA.WORLD);
buffer_write(global.buffer, buffer_u8, WORLD.LEAVE);

network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));
