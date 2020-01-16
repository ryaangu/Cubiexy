///draw_sprite_shadow_ext(sprite_index, image_index, shadow_amount, x, y);
var _sprite_index  = argument[0],
    _image_index   = argument[1],
    _shadow_amount = argument[2],
    _x             = argument[3],
    _y             = argument[4];

//Draw the sprite shadow
draw_sprite_ext(_sprite_index, _image_index, _x + _shadow_amount, _y + _shadow_amount, 1, 1, 0, c_black, 0.70);

//Draw the sprite
draw_sprite(_sprite_index, _image_index, _x, _y);
