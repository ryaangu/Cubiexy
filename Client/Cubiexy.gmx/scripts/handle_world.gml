///handle_world();

//Read data
var _type = buffer_read(read_buffer, buffer_u8);

//Check for type
switch (_type)
{
    //Create
    case WORLD.CREATE: handle_world_create(); break;
    
    //Enter
    case WORLD.ENTER: handle_world_enter(); break;
}
