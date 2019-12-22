///handle_account();

//Read data
var _type = buffer_read(read_buffer, buffer_u8);

//Check for type
switch (_type)
{
    //Register
    case ACCOUNT.REGISTER: handle_account_register(); break;
    
    //Login
    case ACCOUNT.LOGIN: handle_account_login(); break;
}
