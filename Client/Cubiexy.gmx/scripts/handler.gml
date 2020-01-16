///handler();

//Read data
var _data_id = packet_read(USHORT),
    _type    = packet_read(BYTE);
    
//Check for data id
switch (_data_id)
{
    //Client
    case DATA.CLIENT: handle_client(_type); break;
    
    //Account
    case DATA.ACCOUNT: handle_account(_type); break;
    
    //World
    case DATA.WORLD: handle_world(_type); break;
    
    //Player
    case DATA.PLAYER: handle_player(_type); break;
    
    //Chat
    case DATA.CHAT: handle_chat(_type); break;
}
