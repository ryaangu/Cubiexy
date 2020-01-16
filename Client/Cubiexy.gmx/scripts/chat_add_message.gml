///chat_add_message(text);
var _text = argument[0];

//Check for room
if (room != rm_world) return false;

//Add to the list
ds_list_add(global.chat_list, _text);

//Reset index
with (obj_chat)
{
    index = ds_list_size(global.chat_list) - 1 - draw_max;   
}
