///handle_world_set_block();

//Read data
var _layer_id = packet_read(BYTE),
    _x        = packet_read(BYTE),
    _y        = packet_read(BYTE),
    _block_id = packet_read(BYTE);
    
//Set the block
world_set_block(_layer_id, _x, _y, _block_id);
