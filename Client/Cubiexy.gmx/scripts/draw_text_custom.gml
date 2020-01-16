///draw_text_custom(x, y, string, color, align, font);
draw_set_font(argument5);
draw_set_color(argument3);
str_w = string_width(string_keywords_remove(argument2))/2;
str_h = string_height(string_keywords_remove(argument2))/2;
argument2 = string_keywords_validate(argument2);
if (argument4 = true){
   draw_text_colored(argument0-str_w,argument1-str_h,argument2,1);
}
if (argument4 = false){
   draw_text_colored(argument0,argument1,argument2,1);
}
draw_set_color(c_white);
