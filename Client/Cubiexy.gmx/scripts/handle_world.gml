///handle_world(type);
var _type = argument[0];

//Enums
enum WORLD
{
    CREATE,
    ENTER,
    SET_BLOCK,
    SAVE,
    LOAD,
    LEAVE
}

//Check for type
switch (_type)
{
    //Create
    case WORLD.CREATE: handle_world_create(); break;
    
    //Enter
    case WORLD.ENTER: handle_world_enter(); break;
    
    //Set block
    case WORLD.SET_BLOCK: handle_world_set_block(); break;
    
    //Load
    case WORLD.LOAD: handle_world_load(); break;
}
