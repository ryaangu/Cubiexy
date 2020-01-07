///handle_player(type);
var _type = argument[0];

//Enums
enum PLAYER
{
    UPDATE,
    DESTROY
}

//Check for type
switch (_type)
{
    //Update
    case PLAYER.UPDATE: handle_player_update(); break;
    
    //Destroy
    case PLAYER.DESTROY: handle_player_destroy(); break;
}
