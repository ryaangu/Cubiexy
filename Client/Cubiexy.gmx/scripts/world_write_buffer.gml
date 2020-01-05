///world_write_buffer(layer);
var _layer = argument[0];

//Create the buffer
var _buffer = buffer_create(2, buffer_grow, 1);

//Seek the buffer
buffer_seek(_buffer, buffer_seek_start, 0);
buffer_write(_buffer, buffer_string, "gay");

//Loop through layer blocks and write to the buffer
for (var _y = 0; _y < WORLD_HEIGHT div BLOCK_SIZE; _y++)
for (var _x = 0; _x < WORLD_WIDTH  div BLOCK_SIZE; _x++)
{
    buffer_write(_buffer, buffer_u8, world_get_block(_layer, _x * BLOCK_SIZE, _y * BLOCK_SIZE));
}

return _buffer;
