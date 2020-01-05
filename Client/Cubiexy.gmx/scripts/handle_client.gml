///handle_client();

//Enums
enum CLIENT
{
    PING,
    DATA
}

//Read data
var _type = buffer_read(read_buffer, buffer_u8);

//Check for type
switch (_type)
{
    //Ping
    case CLIENT.PING: handle_ping(); break;
    
    //Data
    case CLIENT.DATA: handle_client_data(); break;
}
