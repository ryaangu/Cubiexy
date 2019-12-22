///send_account_login(username, password);
buffer_seek(global.buffer, buffer_seek_start, 0);

buffer_write(global.buffer, buffer_u16, DATA.ACCOUNT);
buffer_write(global.buffer, buffer_u8, ACCOUNT.LOGIN);
buffer_write(global.buffer, buffer_string, string_upper(argument[0]));
buffer_write(global.buffer, buffer_string, string_upper(argument[1]));

network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));
