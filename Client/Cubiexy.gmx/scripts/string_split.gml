///string_split(string, delimiter)
var s = argument[0], d = argument[1], r;
r = ds_list_create();
var p = string_pos(d, s);
var dl = string_length(d);
if (dl) while (p) {
    p -= 1;
    ds_list_add(r, string_copy(s, 1, p));
    s = string_delete(s, 1, p + dl);
    p = string_pos(d, s);
}
ds_list_add(r, s);
var array;
for(var q=0;q<ds_list_size(r);q++){
    array[q] = ds_list_find_value(r,q);
}
ds_list_destroy(r)
return array;
