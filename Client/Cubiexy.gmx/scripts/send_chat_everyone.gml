///send_chat_everyone(text);
packet_clear();

packet_write(USHORT, DATA.CHAT);
packet_write(BYTE,   CHAT.EVERYONE);
packet_write(STRING, string_upper(argument[0]));

packet_send();
