///send_account_logout();
packet_clear();

packet_write(USHORT, DATA.ACCOUNT);
packet_write(BYTE,   ACCOUNT.LOGOUT);

packet_send();
