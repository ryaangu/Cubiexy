///send_chat_world(text);
packet_clear();

packet_write(USHORT, DATA.CHAT);
packet_write(BYTE,   CHAT.WORLD);
packet_write(STRING, string_upper(argument[0]));

packet_send();
