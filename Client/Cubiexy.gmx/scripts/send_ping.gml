///send_ping();
buffer_seek(global.buffer, buffer_seek_start, 0);

buffer_write(global.buffer, buffer_u16, DATA.CLIENT);
buffer_write(global.buffer, buffer_u8, CLIENT.PING);
buffer_write(global.buffer, buffer_u32, current_time);

var _result = network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));

//Check for result
if (_result < 0)
{
    global.connected = false;
    global.ping      = -1;   
}
