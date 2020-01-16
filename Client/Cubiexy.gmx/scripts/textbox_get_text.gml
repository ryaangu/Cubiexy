///textbox_get_text(textbox_type);
var _textbox_type = argument[0];

//Variables
var _text = "";

//Get the textbox text
with (obj_textbox)
{
    if (type == _textbox_type)
        _text = text;
}

return string_replace_all(_text, "\#", "#");
