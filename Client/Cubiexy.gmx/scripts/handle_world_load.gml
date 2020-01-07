///handle_world_load();

//Read data
var _layer_id = buffer_read(read_buffer, buffer_u8),
    _y        = buffer_read(read_buffer, buffer_u8),
    _data     = buffer_read(read_buffer, buffer_string);
    
//Read the data
world_read_horizontal_blocks(_layer_id, _y, _data);

//Update chunks
if (_layer_id == LAYER.FOREGROUND && _y == 49)
{
    chunk_update_all();
}
