///world_get_layer_name(layer_id);
var _layer_id = argument[0];

//Check for layer id
if (_layer_id == LAYER.BACKGROUND)
    return "background_layer";
else
    return "foreground_layer";
