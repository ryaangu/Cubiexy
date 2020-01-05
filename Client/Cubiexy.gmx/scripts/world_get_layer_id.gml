///world_get_layer_id(layer_name);
var _layer_name = argument[0];

//Check for layer id
if (_layer_name == "background_layer")
    return LAYER.BACKGROUND;
else
    return LAYER.FOREGROUND;
