///world_save();
for (var _layer = 0; _layer < LAYER.COUNT; _layer++)
{
    send_world_save(global.world_name, _layer);
}
