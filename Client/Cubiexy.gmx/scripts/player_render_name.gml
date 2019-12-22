///player_render_name(name);
var _name = argument[0];

//Draw the player name
draw_set(-1, 1, fnt_player_name);
align_set(fa_center, fa_center);

draw_string(x, y - 25, _name, c_white, c_black);

align_reset();
draw_reset();
