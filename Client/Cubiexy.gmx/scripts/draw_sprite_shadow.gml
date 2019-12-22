///draw_sprite_shadow(shadow_amount);
var _shadow_amount = argument[0];

//Draw the sprite shadow
draw_sprite_ext(sprite_index, image_index, x + _shadow_amount, y + _shadow_amount, image_xscale, image_yscale, image_angle, c_black, 0.70);
