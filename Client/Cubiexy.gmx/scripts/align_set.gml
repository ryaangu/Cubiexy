///align_set(horizontal_align, vertical_align);
var _horizontal_align = argument[0],
    _vertical_align   = argument[1];
    
if (_horizontal_align != -1)
    draw_set_halign(_horizontal_align);

if (_vertical_align != -1)
    draw_set_valign(_vertical_align);
