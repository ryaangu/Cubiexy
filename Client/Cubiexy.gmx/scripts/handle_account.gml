///handle_account(type);
var _type = argument[0];

//Enums
enum ACCOUNT
{
    REGISTER,
    LOGIN,
    LOGOUT
}

//Check for type
switch (_type)
{
    //Register
    case ACCOUNT.REGISTER: handle_account_register(); break;
    
    //Login
    case ACCOUNT.LOGIN: handle_account_login(); break;
}
