///handle_chat(type);
var _type = argument[0];

//Enums
enum CHAT
{
    EVERYONE,
    WORLD,
    PRIVATE
}

//Check for type
switch (_type)
{
    //Everyone
    case CHAT.EVERYONE: handle_chat_everyone(); break;
    
    //World
    case CHAT.WORLD: handle_chat_world(); break;
    
    //Private
    case CHAT.PRIVATE: handle_chat_private(); break;
}
