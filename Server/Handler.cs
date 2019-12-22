//Import resources
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;
using System.Net;
using System.Threading;

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

		public enum CLIENT
		{
			PING
		}
		
		public enum ACCOUNT
		{
			REGISTER,
			LOGIN,
			LOGOUT
		}
		
		public enum WORLD
		{
			CREATE,
			ENTER,
			SET_BLOCK,
			SAVE,
			LOAD
		}
		
		public enum PLAYER
		{
			UPDATE,
			DESTROY
		}
		
		//Default variables
		public Client client;
		public BufferStream read_buffer;
		BufferStream _buffer;
		
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
		
		//Handle and send client
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
		
		private void handle_ping()
		{
			//Read data
			uint _time;
			read_buffer.Read(out _time);
			
			//Send back
			send_ping(_time);
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
		
		//Handle and send account
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
			
			//Encode the password
			_password = account_db.hash(_password);
			
			//Check if account doesn't exists
			if (!account_db.exists())
			{
				//Create the account
				Account account = new Account
				{
					username = _username,
					password = _password
				};
				
				//Encode the account object into JSON
				string _json = account_db.encode(account);
				
				//Write the file
				account_db.write(_json);
				
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
			
			//Encode the password
			_password = account_db.hash(_password);
			
			//Check if account exists
			if (account_db.exists())
			{
				//Get the account information
				Account account = account_db.decode_account(account_db.read());
				
				//Check if password is equal
				if (_password == account.password)
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
		
		public void handle_account_logout()
		{
			//Show console message
			Console.WriteLine("Account left: " + client.username);
			
			//Remove account from accounts online
			client.server.accounts_online.Remove(client.username);
			
			//Reset username
			client.username = "";
		}
	
		//Handle and send world
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
			}
		}
		
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
				World world = new World
				{
					name = _world_name,
					owner = _world_owner,
					data = ""
				};
				
				//Encode the account object into JSON
				string _json = world_db.encode(world);
				
				//Write the file
				world_db.write(_json);
				
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
			send_world_create(result, error);
		}
		
		public void send_world_create(bool result, string error)
		{
			//Send back
			_buffer.Seek(0);
			
			ushort _data_id = (ushort) DATA.WORLD;
			byte _type = (byte) WORLD.CREATE;
			
			_buffer.Write(_data_id);
			_buffer.Write(_type);
			_buffer.Write(result);
			_buffer.Write(error);
			
			client.send(_buffer);
		}
		
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
			
			//Check if account exists
			if (world_db.exists())
			{
				//Get the world information
				World world = world_db.decode_world(world_db.read());
			
				//Show console message
				Console.WriteLine("World entered: " + _world_name);
				
				//Set the client world name
				client.world_name = _world_name;
				
				//Get the world owner
				_world_owner = world.owner;
				
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
		
		//Handle and send player
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