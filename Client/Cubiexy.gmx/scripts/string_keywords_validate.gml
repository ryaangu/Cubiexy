///string_keywords_validate(string)
_str = string(argument0);

_str = string_replace_all(_str, "~W", "[$=16777215]");
_str = string_replace_all(_str, "~Y", "[$=65535]");
_str = string_replace_all(_str, "~R", "[$=255]");
_str = string_replace_all(_str, "~G", "[$=65280]");
_str = string_replace_all(_str, "~B", "[$=16711680]");

_str = string_replace_all(_str, "~", "");

return string(_str);
