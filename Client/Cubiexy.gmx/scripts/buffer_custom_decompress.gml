///buffer_custom_decompress(buffer);
var _comp_buffer = argument[0];
var _un_buffer = buffer_create(2, buffer_grow, 1);

var _buffer_t = buffer_tell(_comp_buffer);

buffer_seek(_comp_buffer, buffer_seek_start, 0);
buffer_seek(_un_buffer, buffer_seek_start, 0);

while (buffer_tell(_comp_buffer) < _buffer_t)
{
    var _amt = buffer_read(_comp_buffer, buffer_u8);
    var _val = buffer_read(_comp_buffer, buffer_u16);
    
    repeat (_amt)
    {
        buffer_write(_un_buffer, buffer_u16, _val);
    }
}

//delete old buffer
buffer_delete(_comp_buffer);
return _un_buffer;
