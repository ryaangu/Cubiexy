///handle_world_set_block();

//Read data
var _layer_id = buffer_read(read_buffer, buffer_u8),
    _x        = buffer_read(read_buffer, buffer_u8),
    _y        = buffer_read(read_buffer, buffer_u8),
    _block_id = buffer_read(read_buffer, buffer_u16);
    
//Set the block
world_set_block(_layer_id, _x * BLOCK_SIZE, _y * BLOCK_SIZE, _block_id);
