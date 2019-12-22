///string_encode(string);
var _string = argument[0];

repeat (3)
{
    _string = base64_encode(_string);
}

return _string;
