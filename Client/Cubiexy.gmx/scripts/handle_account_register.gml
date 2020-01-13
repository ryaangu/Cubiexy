///handle_account_register();

//Read data
var _result = packet_read(BOOL),
    _error  = packet_read(STRING);

//Show notification
show_notification(_error);
