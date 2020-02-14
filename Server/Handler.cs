//Import resources
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace Server
{	
	//Create the class
	public class Handler
	{
		//Enums
		public enum DATA
		{
			CLIENT,
			ACCOUNT,
			WORLD,
			PLAYER,
			CHAT
		}
		
		//Default variables
		public Client       client;
		public BufferStream buffer;
		public BufferStream read_buffer;
		public bool         send_data = false;
		
		//Start the handler
		public void start(BufferStream _buffer, Client _client)
		{
			//Set the variables
			buffer = _buffer;
			client = _client;
		}
		
		//Handle data
		public void handle(BufferStream _read_buffer)
		{
			//Set the read buffer
			read_buffer = _read_buffer;
	
			//Check for connection
			if (client.connected)
			{
				//Get data
				ushort _data_id;
				read_buffer.Read(out _data_id);

				//Check for data id
				switch (_data_id)
				{
					//Client
					case (ushort) DATA.CLIENT: handle_client(); break;
				
					//Account
					case (ushort) DATA.ACCOUNT: handle_account(); break;
					
					//World
					case (ushort) DATA.WORLD: handle_world(); break;
					
					//Player
					case (ushort) DATA.PLAYER: handle_player(); break;

					//Chat
					case (ushort) DATA.CHAT: handle_chat(); break;
				}
			}
		}
		

		#region CLIENT

		//Enums
		public enum CLIENT
		{
			PING,
			DATA
		}

		//Handle client
		private void handle_client()
		{
			//Read data
			byte _type;
			read_buffer.Read(out _type);
			
			//Check for type
			switch (_type)
			{
				//Ping
				case (byte) CLIENT.PING: handle_ping(); break;
			}
		}
		
		//Handle and send ping
		private void handle_ping()
		{
			//Read data
			uint _time;
			read_buffer.Read(out _time);
			
			//Send back
			send_ping(_time);
			
			//Send data
			if (send_data)
				send_client_data();
		}
		
		public void send_ping(uint time)
		{
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.CLIENT;
			byte _type = (byte) CLIENT.PING;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(time);
			
			client.send(buffer);
		}
		
		//Send client data
		public void send_client_data()
		{
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.CLIENT;
			byte _type = (byte) CLIENT.DATA;
			ushort _client_id = (ushort) client.client_id;

			//Create the database
			Database system_db = new Database("", "system");

			//Get all the data
			string _message     = system_db.get_string_key("information", "message");
			string _version     = system_db.get_string_key("information", "version");
			string _maintenance = system_db.get_string_key("information", "maintenance");
			string _staff       = system_db.get_string_key("information", "staff");
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(_client_id);
			buffer.Write(_message);
			buffer.Write(_version);
			buffer.Write(_maintenance);
			buffer.Write(_staff);
			
			client.send(buffer);
		}

		#endregion

		#region ACCOUNT

		//Enums
		public enum ACCOUNT
		{
			REGISTER,
			LOGIN,
			LOGOUT
		}

		//Handle account
		private void handle_account()
		{
			//Read data
			byte _type;
			read_buffer.Read(out _type);
			
			//Check for type
			switch (_type)
			{
				//Register
				case (byte) ACCOUNT.REGISTER: handle_account_register(); break;
				
				//Login
				case (byte) ACCOUNT.LOGIN: handle_account_login(); break;
				
				//Logout
				case (byte) ACCOUNT.LOGOUT: handle_account_logout(); break;
			}
		}
		
		//Handle and send account register
		public void handle_account_register()
		{
			//Read data
			string _username;
			string _password;
			
			read_buffer.Read(out _username);
			read_buffer.Read(out _password);
			
			//Variables
			bool result = false;
			string error = "";
			
			//Create the database
			Database account_db = new Database("Accounts", _username);
			
			//Hash the password
			_password = account_db.hash(_password);
			
			//Check if account doesn't exists
			if (!account_db.exists())
			{
				//Create the account
				
				//Add the sections
				account_db.add_section("information");

				//Add the keys
				account_db.add_key("information", "username", _username);
				account_db.add_key("information", "password", _password);
				
				//Show console message
				Console.WriteLine("Account created: " + _username);
				
				//Set the result and error
				result = true;
				error = "Account created!";
			}
			else
			{
				//Set the error
				error = "This account already exists!";
			}
			
			//Send back
			send_account_register(result, error);
		}
		
		public void send_account_register(bool result, string error)
		{
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.ACCOUNT;
			byte _type = (byte) ACCOUNT.REGISTER;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(result);
			buffer.Write(error);
			
			client.send(buffer);
		}
		
		//Handle and send account login
		public void handle_account_login()
		{
			//Read data
			string _username;
			string _password;
			
			read_buffer.Read(out _username);
			read_buffer.Read(out _password);
			
			//Variables
			bool result = false;
			string error = "";
			
			//Create the database
			Database account_db = new Database("Accounts", _username);
			
			//Hash the password
			_password = account_db.hash(_password);
			
			//Check if account exists
			if (account_db.exists())
			{
				//Get the account information
				string _account_password = account_db.get_string_key("information", "password");
				
				//Check if password is equal
				if (_password == _account_password)
				{
					//Check if account online
					if (!client.server.accounts_online.Contains(_username))
					{
						//Show console message
						Console.WriteLine("Account entered: " + _username);
						
						//Add the account to the accounts online list
						client.server.accounts_online.Add(_username);
						
						//Set the client username
						client.username = _username;
						
						//Set the result and error
						result = true;
						error = "Account entered!";
					}
					else
					{
						//Set the error
						error = "This account is already online!";
					}
				}
				else
				{
					//Set the error
					error = "Incorrect password.";
				}
			}
			else
			{
				//Set the error
				error = "This account doesn't exists!";
			}
			
			//Send back
			send_account_login(result, error, _username);
		}
	
		public void send_account_login(bool result, string error, string username)
		{
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.ACCOUNT;
			byte _type = (byte) ACCOUNT.LOGIN;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(result);
			buffer.Write(error);
			buffer.Write(username);
			
			client.send(buffer);
		}
		
		//Handle account logout
		public void handle_account_logout()
		{
			//Show console message
			Console.WriteLine("Account left: " + client.username);
			
			//Remove account from accounts online
			client.server.accounts_online.Remove(client.username);
			
			//Reset username
			client.username = "";
		}
	
		#endregion

		#region WORLD

		//Enums
		public enum WORLD
		{
			CREATE,
			ENTER,
			SET_BLOCK,
			SAVE,
			LOAD,
			LEAVE
		}

		public enum LAYER
		{
			BACKGROUND,
			FOREGROUND,
			COUNT
		}

		//Functions
		public string world_get_layer_name(int layer_id)
		{
			//Check for layer id
			if (layer_id == (int) LAYER.BACKGROUND)
				return "background_layer";
			else
				return "foreground_layer";
		}

		public int world_get_layer_id(string layer_name)
		{
			//Check for layer id
			if (layer_name == "background_layer")
				return (int) LAYER.BACKGROUND;
			else
				return (int) LAYER.FOREGROUND;
		}

		//Handle world
		private void handle_world()
		{
			//Read data
			byte _type;
			read_buffer.Read(out _type);
			
			//Check for type
			switch (_type)
			{
				//Create
				case (byte) WORLD.CREATE: handle_world_create(); break;
				
				//Enter
				case (byte) WORLD.ENTER: handle_world_enter(); break;

				//Set block
				case (byte) WORLD.SET_BLOCK: handle_world_set_block(); break;

				//Save
				case (byte) WORLD.SAVE: handle_world_save(); break;

				//Load
				case (byte) WORLD.LOAD: handle_world_load(); break;

				//Leave
				case (byte) WORLD.LEAVE: handle_world_leave(); break;
			}
		}
		
		//Handle and send world create
		public void handle_world_create()
		{
			//Read data
			string _world_name;
			string _world_owner;
			
			read_buffer.Read(out _world_name);
			read_buffer.Read(out _world_owner);
			
			//Variables
			bool result = false;
			string error = "";
			
			//Create the database
			Database world_db = new Database("Worlds", _world_name);
			
			//Check if world doesn't exists
			if (!world_db.exists())
			{
				//Create the world
				
				//Add the sections
				world_db.add_section("information");
				world_db.add_section("block_data");
				world_db.add_section("foreground_layer");
				world_db.add_section("background_layer");

				//Add the keys
				world_db.add_key("information", "name", _world_name);
				world_db.add_key("information", "owner", _world_owner);
				world_db.add_key("information", "world_width", "100");
				world_db.add_key("information", "world_height", "50");
				
				//Show console message
				Console.WriteLine("World created: " + _world_name);
				
				//Set the result and error
				result = true;
				error = "World created!";
			}
			else
			{
				//Set the error
				error = "This world already exists!";
			}
			
			//Send back
			send_world_create(_world_name, result, error);
		}
		
		public void send_world_create(string world_name, bool result, string error)
		{
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.WORLD;
			byte _type = (byte) WORLD.CREATE;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(world_name);
			buffer.Write(result);
			buffer.Write(error);
			
			client.send(buffer);
		}
		
		//Handle and send world enter
		public void handle_world_enter()
		{
			//Read data
			string _world_name;
			
			read_buffer.Read(out _world_name);
			
			//Variables
			bool result = false;
			string error = "";
			string _world_owner = "";
			
			//Create the database
			Database world_db = new Database("Worlds", _world_name);
			
			//Check if world exists
			if (world_db.exists())
			{
				//Get the world information
				_world_owner = world_db.get_string_key("information", "owner");
			
				//Show console message
				Console.WriteLine("World entered: " + _world_name);
				
				//Set the client world name
				client.world_name = _world_name;
				
				//Set the result and error
				result = true;
				error = "World entered!";
			}
			else
			{
				//Set the error
				error = "This world doesn't exists!";
			}
			
			//Send back
			send_world_enter(result, error, _world_name, _world_owner);
		}
		
		public void send_world_enter(bool result, string error, string world_name, string world_owner)
		{
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.WORLD;
			byte _type = (byte) WORLD.ENTER;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(result);
			buffer.Write(error);
			buffer.Write(world_name);
			buffer.Write(world_owner);
			
			client.send(buffer);
		}
		
		//Handle world save
		public void handle_world_save()
		{
			//Read data
			string _world_name;
			string _layer_name;
			byte   _y;
			string _data;
			
			read_buffer.Read(out _world_name);
			read_buffer.Read(out _layer_name);
			read_buffer.Read(out _y);
			read_buffer.Read(out _data);
			
			//Create the database
			Database world_db = new Database("Worlds", _world_name);
			
			//Check if world exists
			if (world_db.exists())
			{
				//Edit the position in database
				world_db.edit_key(_layer_name, _y.ToString(), _data);
			}
		}

		//Handle and send world set block
		public void handle_world_set_block()
		{
			//Read data
			string _world_name;
			string _layer_name;
			byte   _x;
			byte   _y;
			byte   _block_id;
			
			read_buffer.Read(out _world_name);
			read_buffer.Read(out _layer_name);
			read_buffer.Read(out _x);
			read_buffer.Read(out _y);
			read_buffer.Read(out _block_id);

			//Create the database
			Database world_db = new Database("Worlds", _world_name);
			
			//Check if world exists
			if (world_db.exists())
			{
				//Get the position data
				string _data = world_db.get_string_key(_layer_name, _y.ToString());

				//Split the data
				string[] _data_array = _data.Split(", ");

				//Change the block id
				_data_array[_x] = _block_id.ToString();

				//Create new data
				string _new_data = "";

				for (int i = 0; i < _data_array.Length; i++)
				{
					_new_data += _data_array[i].ToString();
					if (i != _data_array.Length - 1) _new_data += ", ";
				}

				//Save the new data
				world_db.edit_key(_layer_name, _y.ToString(), _new_data);

				//Get the layer id
				byte _layer_id = (byte) world_get_layer_id(_layer_name);

				//Send back
				send_world_set_block(_layer_id, _x, _y, _block_id);
			}
		}

		public void send_world_set_block(byte layer_id, byte x, byte y, byte block_id)
		{
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.WORLD;
			byte _type = (byte) WORLD.SET_BLOCK;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(layer_id);
			buffer.Write(x);
			buffer.Write(y);
			buffer.Write(block_id);
			
			client.send_to_world(buffer);
		}

		//Handle and send world load
		public void handle_world_load()
		{
			//Read data
			string _world_name;
			
			read_buffer.Read(out _world_name);
			
			//Create the database
			Database world_db = new Database("Worlds", _world_name);
			
			//Check if world exists
			if (world_db.exists())
			{
				//Send back
				send_world_load(world_db, (byte) world_get_layer_id("background_layer"), "background_layer");
				send_world_load(world_db, (byte) world_get_layer_id("foreground_layer"), "foreground_layer");
			}
		}

		public void send_world_load(Database world_db, byte layer_id, string layer_name)
		{
			//Variables
			ushort _data_id = (ushort) DATA.WORLD;
			byte _type = (byte) WORLD.LOAD;

			//Loop through world height and send every row
			for (byte _y = 0; _y < 50; _y += 1)
			{
				//Get the data
				string _data = world_db.get_string_key(layer_name, _y.ToString());

				buffer.Seek(0);
				
				buffer.Write(_data_id);
				buffer.Write(_type);
				buffer.Write(layer_id);
				buffer.Write(_y);
				buffer.Write(_data);
				
				client.send(buffer);
			}
		}

		//Handle world leave
		public void handle_world_leave()
		{
			//Show console message
			Console.WriteLine("World left: " + client.world_name);
			
			//Reset world name
			client.world_name = "";
		}

		#endregion

		#region PLAYER

		//Enums
		public enum PLAYER
		{
			UPDATE,
			DESTROY
		}

		//Handle player
		private void handle_player()
		{
			//Read data
			byte _type;
			read_buffer.Read(out _type);
			
			//Check for type
			switch (_type)
			{
				//Update
				case (byte) PLAYER.UPDATE: handle_player_update(); break;
				
				//Destroy
				case (byte) PLAYER.DESTROY: handle_player_destroy(); break;
			}
		}
		
		//Handle and send player update
		public void handle_player_update()
		{
			//Read data
			string _data;
			string _username;
			
			read_buffer.Read(out _data);
			read_buffer.Read(out _username);
			
			//Send back
			send_player_update(_data, _username);
		}
		
		public void send_player_update(string data, string username)
		{
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.PLAYER;
			byte _type = (byte) PLAYER.UPDATE;
			ushort _client_id = (ushort) client.client_id;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(_client_id);
			buffer.Write(data);
			buffer.Write(username);
			
			client.send_to_world(buffer);
		}
		
		//Handle player destroy
		public void handle_player_destroy()
		{
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.PLAYER;
			byte _type = (byte) PLAYER.DESTROY;
			ushort _client_id = (ushort) client.client_id;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(_client_id);
			
			client.send_to_world(buffer);
		}

		#endregion

		#region CHAT

		//Enums
		public enum CHAT
		{
			EVERYONE,
			WORLD,
			PRIVATE
		}

		//Handle chat
		private void handle_chat()
		{
			//Read data
			byte _type;
			read_buffer.Read(out _type);
			
			//Check for type
			switch (_type)
			{
				//Everyone
			    case (byte) CHAT.EVERYONE: handle_chat_everyone(); break;
			    
			    //World
			    case (byte) CHAT.WORLD: handle_chat_world(); break;
			    
			    //Private
			    case (byte) CHAT.PRIVATE: handle_chat_private(); break;
			}
		}
		
		//Handle chat everyone
		public void handle_chat_everyone()
		{
			//Read data
			string _text;
			
			read_buffer.Read(out _text);
			
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.CHAT;
			byte _type      = (byte) CHAT.EVERYONE;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(_text);
			
			client.send_to_everyone(buffer);
		}

		//Handle chat world
		public void handle_chat_world()
		{
			//Read data
			string _text;
			
			read_buffer.Read(out _text);
			
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.CHAT;
			byte _type      = (byte) CHAT.WORLD;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(_text);
			
			client.send_to_world(buffer);
		}

		//Handle chat private
		public void handle_chat_private()
		{
			//Read data
			string _text;
			string _username;
			
			read_buffer.Read(out _text);
			read_buffer.Read(out _username);
			
			//Send back
			buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.CHAT;
			byte _type      = (byte) CHAT.PRIVATE;
			
			buffer.Write(_data_id);
			buffer.Write(_type);
			buffer.Write(_text);
			buffer.Write(client.username);
			
			client.send_to(buffer, _username);
		}

		#endregion
	}
}