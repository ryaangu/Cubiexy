///handle_account_register();

//Read data
var _result = buffer_read(read_buffer, buffer_bool),
    _error  = buffer_read(read_buffer, buffer_string);

//Show notification
show_notification(_error);
