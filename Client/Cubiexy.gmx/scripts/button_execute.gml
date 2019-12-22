///button_execute(button_type);
var _button_type = argument[0];

//Play sound
audio_play_sound(snd_button_click, 10, false);

//Check for button type
switch (_button_type)
{
    //Login
    case BUTTON.LOGIN:
    
        //Get the inputs
        var _username = textbox_get_text(TEXTBOX.USERNAME),
            _password = textbox_get_text(TEXTBOX.PASSWORD);
            
        //Check for inputs length
        if (string_length(_username) > 0 && string_replace_all(_username, " ", "") != "")
        {
            if (string_length(_password) > 0 && string_replace_all(_password, " ", "") != "")
            {
                //Login
                send_account_login(_username, _password);
            }
            else
            {
                show_notification("The password textboxes are empty!");
            }
        }
        else
        {
            show_notification("The username textboxes are empty!");
        }
    
    break;
    
    //Register
    case BUTTON.REGISTER:
    
        //Get the inputs
        var _username = textbox_get_text(TEXTBOX.USERNAME),
            _password = textbox_get_text(TEXTBOX.PASSWORD);
            
        //Check for inputs length
        if (string_length(_username) > 0 && string_replace_all(_username, " ", "") != "")
        {
            if (string_length(_password) > 0 && string_replace_all(_password, " ", "") != "")
            {
                //Register
                send_account_register(_username, _password);
            }
            else
            {
                show_notification("The password textboxes are empty!");
            }
        }
        else
        {
            show_notification("The username textboxes are empty!");
        }
        
    break;
    
    //Enter world
    case BUTTON.ENTER_WORLD:
    
        //Get the inputs
        var _world_name = textbox_get_text(TEXTBOX.WORLD_NAME);
            
        //Check for inputs length
        if (string_length(_world_name) > 0 && string_replace_all(_world_name, " ", "") != "")
        {
            //Enter the world
            send_world_enter(_world_name);
        }
        else
        {
            show_notification("The world name textbox is empty!");
        }
    
    break;
    
    //Create world
    case BUTTON.CREATE_WORLD:
    
        //Get the inputs
        var _world_name = textbox_get_text(TEXTBOX.WORLD_NAME);
            
        //Check for inputs length
        if (string_length(_world_name) > 0 && string_replace_all(_world_name, " ", "") != "")
        {
            //Create the world
            send_world_create(_world_name, global.username);
        }
        else
        {
            show_notification("The world name textbox is empty!");
        }
    
    break;
}
