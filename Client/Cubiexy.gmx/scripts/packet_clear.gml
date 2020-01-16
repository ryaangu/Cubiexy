///packet_clear();

//Check for connection
if (!global.connected) return false;

//Seek the buffer
buffer_seek(global.buffer, buffer_seek_start, 0);
