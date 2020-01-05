///handle_world_load();

//Read data
var _layer_id = buffer_read(read_buffer, buffer_u8),
    _data     = buffer_read(read_buffer, buffer_string);
    
show_message(_data);
    
//Read the grid data
//world_read(_layer_id, _data);

//Update the chunks
chunk_update_all();
