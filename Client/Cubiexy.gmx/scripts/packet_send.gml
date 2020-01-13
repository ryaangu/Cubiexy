///packet_send();

//Send the message
var _sent = network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));

//Check for connection
if (_sent < 0)
{
    //Reset variables
    global.connected = false;
    global.ping      = -1;
    global.client_id = -1;
}
    
return _sent;
