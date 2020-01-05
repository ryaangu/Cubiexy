///buffer_custom_compress(buffer);
var _buffer = argument[0];
var _buffer_t = buffer_tell(_buffer);
var _new_buffer = buffer_create(2, buffer_grow, 1);
buffer_seek(_buffer, buffer_seek_start, 0);
buffer_seek(_new_buffer, buffer_seek_start, 0);
var _val_c = -1, _val_d = -1, _count = 0;
while (buffer_tell(_buffer) < _buffer_t)
{
    _val_c = buffer_read(_buffer, buffer_u16);
    
    //check if same as active value
    if (_val_c == _val_d && _count < 254)
    {
        _count++;
    }
    else
    {
        //Paste and reset counter
        if (_val_d != -1 && _count > 0)
        {
            buffer_write(_new_buffer, buffer_u8, _count);
            buffer_write(_new_buffer, buffer_u16, _val_d);
        }
        _val_d = _val_c;
        _count = 1;
    }
}
//write left over bit
if (_val_d != -1 && _count > 0)
{
    buffer_write(_new_buffer, buffer_u8, _count);
    buffer_write(_new_buffer, buffer_u16, _val_d);
}

//destroy old buffer
buffer_delete(_buffer);
return _new_buffer;
