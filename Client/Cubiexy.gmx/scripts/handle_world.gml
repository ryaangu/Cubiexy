///handle_world();

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

//Read data
var _type = buffer_read(read_buffer, buffer_u8);

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
