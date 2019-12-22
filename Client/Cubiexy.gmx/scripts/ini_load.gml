///ini_load(ini_file, section, key);
var _ini_file = argument[0],
    _section  = argument[1],
    _key      = argument[2];
    
ini_open(_ini_file);

return ini_read_string(_section, _key, "");

ini_close();
