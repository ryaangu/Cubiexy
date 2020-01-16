///packet_read(buffer_type);
var _buffer_type = argument[0];

//Check for connection
if (!global.connected) return false;

return buffer_read(read_buffer, _buffer_type);
