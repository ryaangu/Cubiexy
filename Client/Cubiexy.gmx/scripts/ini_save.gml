///ini_save(ini_file, section, key, value);
var _ini_file = argument[0],
    _section  = argument[1],
    _key      = argument[2],
    _value    = string(argument[3]);
    
ini_open(_ini_file);
ini_write_string(_section, _key, _value);
ini_close();
