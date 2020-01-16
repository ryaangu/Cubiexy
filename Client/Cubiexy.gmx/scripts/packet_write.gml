///packet_write(buffer_type, value);
var _buffer_type = argument[0],
    _value       = argument[1];
    
//Check for connection
if (!global.connected) return false;
    
buffer_write(global.buffer, _buffer_type, _value);
