///draw_set(color, alpha, font);
for (var i = 0; i < argument_count; i++)
{
    //Check for indexes
    switch (i)
    {
        //Color
        case 0: 
            if (argument[i] != -1)
                draw_set_color(argument[i]);
        break;
        
        //Alpha
        case 1: 
            if (argument[i] != -1)
                draw_set_alpha(argument[i]);
        break;
        
        //Font
        case 2: 
            if (argument[i] != -1)
                draw_set_font(argument[i]);
        break;
    }
}
