///array_create_2d(width, height, value);
var _width  = argument[0],
    _height = argument[1],
    _value  = argument[2];
    
var _array;
    
//Loop through and create an array with the value
for (var j = 0; j < _height; j++)
for (var i = 0; i < _width; i++)
{
    _array[i, j] = _value;
}

return _array;
