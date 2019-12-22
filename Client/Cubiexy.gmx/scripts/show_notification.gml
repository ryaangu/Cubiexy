///show_notification(text)
var _text = argument[0];

//Check if notification exists
if (instance_exists(obj_notification))
{
    //Set text and show notification
    obj_notification.text = _text;
    obj_notification.alarm[0] = 1;
}
