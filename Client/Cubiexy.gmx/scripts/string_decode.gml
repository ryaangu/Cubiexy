///string_decode(string);
var _string = argument[0];

repeat (3)
{
    _string = base64_decode(_string);
}

return _string;
