//Import resources
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;
using System.Net;
using System.Threading;
using System.Dynamic;

//Global namespace
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
			PLAYER
		}
		
		//Default variables
		public Client       client;
		public BufferStream read_buffer;
		BufferStream        _buffer;
		public bool         send_data = true;
		
		//Start the handler
		public void start(Client _client)
		{
			//Set the client
			client = _client;
			
			//Create the buffer
			_buffer = new BufferStream(1024, 1);
		}
		
		//Handle data
		public void handle(BufferStream _read_buffer)
		{
			//Set the read buffer
			read_buffer = _read_buffer;
	
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
			}
		}
		
		//CLIENT

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
			{
				send_client_data();
				send_data = false;
			}
		}
		
		public void send_ping(uint time)
		{
			//Send back
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.CLIENT;
			byte _type = (byte) CLIENT.PING;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(time);
			
			client.send(_buffer);
		}
		
		//Send client data
		public void send_client_data()
		{
			//Send back
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.CLIENT;
			byte _type = (byte) CLIENT.DATA;
			ushort _client_id = (ushort) client.client_id;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(_client_id);
			
			client.send(_buffer);
		}
		

		//ACCOUNT

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
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.ACCOUNT;
			byte _type = (byte) ACCOUNT.REGISTER;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(result);
			_buffer.Write(error);
			
			client.send(_buffer);
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
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.ACCOUNT;
			byte _type = (byte) ACCOUNT.LOGIN;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(result);
			_buffer.Write(error);
			_buffer.Write(username);
			
			client.send(_buffer);
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
	
		//WORLD

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

				//Save
				case (byte) WORLD.SAVE: handle_world_save(); break;

				//Set block
				case (byte) WORLD.SET_BLOCK: handle_world_set_block(); break;

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
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.WORLD;
			byte _type = (byte) WORLD.CREATE;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(world_name);
			_buffer.Write(result);
			_buffer.Write(error);
			
			client.send(_buffer);
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
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.WORLD;
			byte _type = (byte) WORLD.ENTER;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(result);
			_buffer.Write(error);
			_buffer.Write(world_name);
			_buffer.Write(world_owner);
			
			client.send(_buffer);
		}
		
		//Handle world save
		public void handle_world_save()
		{
			//Read data
			string _world_name;
			byte   _world_width;
			byte   _world_height;
			string _layer_name;
			
			read_buffer.Read(out _world_name);
			read_buffer.Read(out _world_width);
			read_buffer.Read(out _world_height);
			read_buffer.Read(out _layer_name);
			
			//Create the database
			Database world_db = new Database("Worlds", _world_name);
			
			//Check if world exists
			if (world_db.exists())
			{
				//Add the world dimensions to the database
				world_db.add_key("information", "world_width",  _world_width.ToString());
				world_db.add_key("information", "world_height", _world_height.ToString());

				//Loop through world dimensions
				for (byte _y = 0; _y < _world_height; _y++)
				{
					for (byte _x = 0; _x < _world_width; _x++)
					{
						string _data;
						read_buffer.Read(out _data);

						//Edit the position in database
						world_db.edit_key(_layer_name, _x.ToString() + "_" + _y.ToString(), _data);
					}
				}
				
				//Show console message
				Console.WriteLine("World saved: " + _world_name + " - Layer: " + _layer_name);
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
			ushort _block_id;
			
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
				//Send back
				send_world_set_block((byte) world_get_layer_id(_layer_name), _x, _y, _block_id);
			}
		}

		public void send_world_set_block(byte layer_id, byte x, byte y, ushort block_id)
		{
			//Send back
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.WORLD;
			byte _type = (byte) WORLD.SET_BLOCK;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(layer_id);
			_buffer.Write(x);
			_buffer.Write(y);
			_buffer.Write(block_id);
			
			client.send_to_world(_buffer);
		}

		//Handle and send world load
		public void handle_world_load()
		{
			//Read data
			string _world_name;
			string _layer_name;
			
			read_buffer.Read(out _world_name);
			read_buffer.Read(out _layer_name);
			
			//Create the database
			Database world_db = new Database("Worlds", _world_name);
			
			//Check if world exists
			if (world_db.exists())
			{
				//Send back
				send_world_load(world_db, (byte) world_get_layer_id(_layer_name), _layer_name);

				//Show console message
				Console.WriteLine("World loaded: " + _world_name + " - Layer: " + _layer_name);
			}
		}

		public void send_world_load(Database world_db, byte layer_id, string layer_name)
		{
			//Send back
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.WORLD;
			byte _type = (byte) WORLD.LOAD;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(layer_id);

			//Get the data
			string _data = world_db.get_string_key(layer_name, "data");

			//Write the block data
			_buffer.Write(_data);
			
			client.send(_buffer);
		}

		//Handle world leave
		public void handle_world_leave()
		{
			//Show console message
			Console.WriteLine("World left: " + client.world_name);
			
			//Reset world name
			client.world_name = "";
		}

		//PLAYER

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
			short _x;
			short _y;
			byte _sprite_index;
			byte _image_index;
			short _image_xscale;
			float _image_speed;
			float _image_alpha;
			string _username;
			
			read_buffer.Read(out _x);
			read_buffer.Read(out _y);
			read_buffer.Read(out _sprite_index);
			read_buffer.Read(out _image_index);
			read_buffer.Read(out _image_xscale);
			read_buffer.Read(out _image_speed);
			read_buffer.Read(out _image_alpha);
			read_buffer.Read(out _username);
			
			//Send back
			send_player_update(_x, _y, _sprite_index, _image_index, _image_xscale, _image_speed, _image_alpha, _username);
		}
		
		public void send_player_update(short x, short y, byte sprite_index, byte image_index, short image_xscale, float image_speed, float image_alpha, string username)
		{
			//Send back
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.PLAYER;
			byte _type = (byte) PLAYER.UPDATE;
			ushort _client_id = (ushort) client.client_id;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(_client_id);
			_buffer.Write(x);
			_buffer.Write(y);
			_buffer.Write(sprite_index);
			_buffer.Write(image_index);
			_buffer.Write(image_xscale);
			_buffer.Write(image_speed);
			_buffer.Write(image_alpha);
			_buffer.Write(username);
			
			client.send_to_world(_buffer);
		}
		
		//Handle player destroy
		public void handle_player_destroy()
		{
			//Send back
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.PLAYER;
			byte _type = (byte) PLAYER.DESTROY;
			ushort _client_id = (ushort) client.client_id;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(_client_id);
			
			client.send_to_world(_buffer);
		}
	}
}