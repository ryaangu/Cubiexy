///send_account_login(username, password);
packet_clear();

packet_write(USHORT, DATA.ACCOUNT);
packet_write(BYTE,   ACCOUNT.LOGIN);
packet_write(STRING, string_upper(argument[0]));
packet_write(STRING, string_upper(argument[1]));

packet_send();
