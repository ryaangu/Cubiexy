///handler(read_buffer, size);
read_buffer = argument[0];
var _size   = argument[1];

buffer_seek(read_buffer, buffer_seek_start, 0);
while (buffer_tell(read_buffer) < _size)
{
    //Read data
    var _data_id = buffer_read(read_buffer, buffer_u16),
        _type    = buffer_read(read_buffer, buffer_u8);

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
    }
}

buffer_delete(read_buffer);
