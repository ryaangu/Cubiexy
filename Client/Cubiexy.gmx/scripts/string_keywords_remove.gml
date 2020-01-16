///string_keywords_remove(string)
_str = string(argument0);

_str = string_replace_all(_str, "~W",  "");
_str = string_replace_all(_str, "~Y",  "");
_str = string_replace_all(_str, "~R",  "");
_str = string_replace_all(_str, "~G",  "");
_str = string_replace_all(_str, "~B",  "");

_str = string_replace_all(_str, "~", "");

return string(_str);
