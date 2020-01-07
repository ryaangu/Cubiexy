///world_load();
for (var _layer = 0; _layer < LAYER.COUNT; _layer++)
{
    send_world_load(global.world_name, _layer);
}
