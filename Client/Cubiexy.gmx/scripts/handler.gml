///handler(read_buffer);
read_buffer = argument[0];

//Read data
var _data_id = buffer_read(read_buffer, buffer_u16);

//Check for data id
switch (_data_id)
{
    //Client
    case DATA.CLIENT: handle_client(); break;
    
    //Account
    case DATA.ACCOUNT: handle_account(); break;
    
    //World
    case DATA.WORLD: handle_world(); break;
    
    //Player
    case DATA.PLAYER: handle_player(); break;
}
