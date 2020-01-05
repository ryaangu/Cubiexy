///handle_client_data();

//Read data
var _client_id = buffer_read(read_buffer, buffer_u16);

//Set the client id
global.client_id = _client_id;
