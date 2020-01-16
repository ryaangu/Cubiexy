///chat_init();

//Enums
enum COMMAND
{
    NAME,
    ARGUMENT_COUNT,
    CALLBACK_SCRIPT,
    INFORMATION,
    PERMISSION
}

enum COMMAND_PERMISSION
{
    STAFF,
    EVERYONE
}

//Add the commands
chat_add_command("/help", 1, chat_command_help, "/help - Show the command list.", COMMAND_PERMISSION.EVERYONE);
chat_add_command("/debug", 1, chat_command_debug, "/debug - Enable/disable debug.", COMMAND_PERMISSION.EVERYONE);
chat_add_command("/broadcast", 2, chat_command_broadcast, "/broadcast <message> - Send message to everyone.", COMMAND_PERMISSION.STAFF);
chat_add_command("/private", 3, chat_command_private, "/private <username> <message> - Send message to user.", COMMAND_PERMISSION.EVERYONE);
chat_add_command("/noclip", 1, chat_command_noclip, "/noclip - Enable/disable noclip.", COMMAND_PERMISSION.STAFF);
chat_add_command("/owner", 1, chat_command_owner, "/owner - Show the world owner.", COMMAND_PERMISSION.EVERYONE);
