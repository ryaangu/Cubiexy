///send_account_logout();
buffer_seek(global.buffer, buffer_seek_start, 0);

buffer_write(global.buffer, buffer_u16, DATA.ACCOUNT);
buffer_write(global.buffer, buffer_u8, ACCOUNT.LOGOUT);

network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));
