///handle_client_data();

//Read data
var _client_id = packet_read(USHORT);

//Set the client id
global.client_id = _client_id;
