///send_world_save(world_name, layer);

//Loop through world height and send every row
for (var _y = 0; _y < WORLD_HEIGHT div BLOCK_SIZE; _y++)
{
    packet_clear();
    
    packet_write(USHORT, DATA.WORLD);
    packet_write(BYTE,   WORLD.SAVE);
    packet_write(STRING, string_upper(argument[0]));
    packet_write(STRING, world_get_layer_name(argument[1]));
    packet_write(BYTE,   _y);
    packet_write(STRING, world_write_horizontal_blocks(argument[1], _y));
    
    packet_send();
}
