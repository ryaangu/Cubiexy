///world_render_players();

//Draw the other players
with (obj_other_player)
{
    //Shadow
    draw_sprite_ext(sprite_index, image_index, x + 3, y + 3, image_xscale, image_yscale, image_angle, c_black, 0.70);
    draw_self();
}

//Draw the player
with (obj_player)
{
    //Shadow
    draw_sprite_ext(sprite_index, image_index, x + 3, y + 3, image_xscale, image_yscale, image_angle, c_black, 0.70);
    draw_self();
}
