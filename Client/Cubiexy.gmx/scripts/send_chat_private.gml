///send_chat_private(text, username);
packet_clear();

packet_write(USHORT, DATA.CHAT);
packet_write(BYTE,   CHAT.PRIVATE);
packet_write(STRING, string_upper(argument[0]));
packet_write(STRING, string_upper(argument[1]));

packet_send();
