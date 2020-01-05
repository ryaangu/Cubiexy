///world_optimize();

//Deactivate all objects outside view
instance_deactivate_region(view_xview - 32, view_yview - 32, view_wview + 64, view_hview + 64, false, true);

//Activate all objects inside view
instance_activate_region(view_xview - 32, view_yview - 32, view_wview + 64, view_hview + 64, true);

//Activate important objects
instance_activate_object(obj_client);
instance_activate_object(obj_controller);
instance_activate_object(obj_camera);
instance_activate_object(obj_notification);
instance_activate_object(obj_player);
