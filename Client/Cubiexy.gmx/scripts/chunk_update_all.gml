///chunk_update_all();

//Loop through world layers
for (var _layer = 0; _layer < LAYER.COUNT; _layer++)
{
    //Loop through chunks
    for (var _chunk_y = 0; _chunk_y < CHUNK_MAX_VERTICAL;   _chunk_y++)
    for (var _chunk_x = 0; _chunk_x < CHUNK_MAX_HORIZONTAL; _chunk_x++)
    {
        //Destroy the chunk
        chunk_destroy(_layer, _chunk_x, _chunk_y);
    }
}
