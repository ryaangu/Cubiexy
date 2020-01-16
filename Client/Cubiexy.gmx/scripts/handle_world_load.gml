///handle_world_load();

//Read data
var _layer_id = packet_read(BYTE),
    _y        = packet_read(BYTE),
    _data     = packet_read(STRING);
    
//Read the data
world_read_horizontal_blocks(_layer_id, _y, _data);
