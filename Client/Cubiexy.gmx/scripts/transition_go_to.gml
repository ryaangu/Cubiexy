///transition_go_to(room);
var _room = argument[0];

//Check for transition
if (instance_exists(obj_transition)) instance_destroy(obj_transition);

//Create the transition
var _transition      = instance_create(0, 0, obj_transition);
    _transition.goto = _room;
