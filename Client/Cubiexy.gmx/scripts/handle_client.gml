///handle_client(type);
var _type = argument[0];

//Enums
enum CLIENT
{
    PING,
    DATA
}

//Check for type
switch (_type)
{
    //Ping
    case CLIENT.PING: handle_ping(); break;
    
    //Data
    case CLIENT.DATA: handle_client_data(); break;
}
