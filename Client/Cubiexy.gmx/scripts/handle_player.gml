///handle_player();

//Read data
var _type = buffer_read(read_buffer, buffer_u8);

//Check for type
switch (_type)
{
    //Update
    case PLAYER.UPDATE: handle_player_update(); break;
    
    //Destroy
    case PLAYER.DESTROY: handle_player_destroy(); break;
}
