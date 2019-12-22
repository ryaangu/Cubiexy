///handle_ping();

//Read data
var _time = buffer_read(read_buffer, buffer_u32);

//Set the ping
global.ping = current_time - _time - room_speed;
