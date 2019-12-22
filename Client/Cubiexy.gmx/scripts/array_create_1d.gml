///array_create_1d(size, value);
var _size  = argument[0],
    _value = argument[1];
    
var _array;
    
//Loop through and create an array with the value
for (var i = 0; i < _size; i++)
{
    _array[i] = _value;
}

return _array;
