///handle_ping();

//Read data
var _time = packet_read(UINT);

//Set the ping
global.ping = current_time - _time - room_speed;
