//Import resources
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace Server
{
	//Create the class
	public class Client
	{
		//Default variables
		public const int BUFFER_SIZE = 10240;

		public BufferStream  buffer       = new BufferStream(BUFFER_SIZE, 1);
		BufferStream         read_buffer  = new BufferStream(BUFFER_SIZE, 1);
		public Handler       handler;

		public Socket socket;
		public Server server;
		public int    client_id;
		public string username   = "";
		public string world_name = "";

		public bool connected = true;

		//Initialize the client
		public Client(Socket _socket, Server _server, int _client_id)
		{
			//Set the variables
			socket    = _socket;
			server    = _server;
			client_id = _client_id;

			//Begin receiving data
			socket.BeginReceive(read_buffer.Memory, 0, BUFFER_SIZE, SocketFlags.None, new AsyncCallback(receive_data), null);
		
			//Create and start handler
			handler = new Handler();
			handler.start(buffer, this);
		}

		//Destroy everything
		public void destroy()
		{
			//Remove self from the lists
			server.socket_list.Remove(socket);
			server.client_list.Remove(this);

			//Shutdown and Close the socket
			socket.Shutdown(SocketShutdown.Both);
			socket.Close();

			//Set connected to false
			connected = false;
		}

		//Disconnect
		public void disconnect()
		{
			//Leave from world
			if (world_name != "")
			{
				//Reset world name
				world_name = "";
			}
			
			//Leave from account
			if (username != "")
			{
				//Remove account from accounts online
				server.accounts_online.Remove(username);
			
				//Reset username
				username = "";
			}

			//Show console message
			Console.WriteLine("Client disconnected [ID: " + client_id + "]");

			//Destroy
			destroy();
		}

		//Send data
		public void send(BufferStream _buffer)
		{
			try
			{
				BufferStream _buffer_size = new BufferStream(4, 1);
				int          _size        = _buffer.Iterator + 1;

				_buffer_size.Write(_size);
				_buffer.BlockCopy(_buffer_size, 0, 4);

				//Begin sending data
				socket.BeginSend(_buffer.Memory, 0, _buffer.Iterator, SocketFlags.None, new AsyncCallback(send_data), null);
			}
			catch (SocketException)
			{
				disconnect();
				return;
			}
			catch (System.IO.IOException)
			{
				disconnect();
				return;
			}
			catch (NullReferenceException)
			{
				disconnect();
				return;
			}
			catch (ObjectDisposedException)
			{
				return;
			}
			catch (System.InvalidOperationException)
			{
				return;
			}
		}

		public void send_to_world(BufferStream _buffer)
		{
			foreach (Client _client in server.client_list)
			{
				if (_client.world_name == world_name && world_name != "")
				{
					_client.send(_buffer);
				}
            }
		}

		public void send_to_everyone(BufferStream _buffer)
		{
			foreach (Client _client in server.client_list)
			{
				_client.send(_buffer);
            }
		}

		public void send_to(BufferStream _buffer, string _username)
		{
			foreach (Client _client in server.client_list)
			{
				if (_client.username == _username)
				{
					_client.send(_buffer);
				}
            }
		}

		//Send data callback
		public void send_data(IAsyncResult AR)
		{
			//Get the data
			int _data;

			try
			{
				//End sending
				_data = socket.EndSend(AR);
			}
			catch (SocketException)
			{
				disconnect();
				return;
			}
			catch (System.IO.IOException)
			{
				disconnect();
				return;
			}
			catch (NullReferenceException)
			{
				disconnect();
				return;
			}
			catch (ObjectDisposedException)
			{
				return;
			}
			catch (System.InvalidOperationException)
			{
				return;
			}
		}

		//Receive data callback
		public void receive_data(IAsyncResult AR)
		{
			//Get the data
			int _data;

			try
			{
				//End receiving
				_data = socket.EndReceive(AR);

				if (_data == 0) return;

				read_buffer.SetBytes(_data);

				read_buffer.Seek(0);

				//Check for data length
				while (read_buffer.BYTES > 0)
				{
					//Handle
					handler.handle(read_buffer);
				}

				//Receive more data
				socket.BeginReceive(read_buffer.Memory, 0, BUFFER_SIZE, SocketFlags.None, new AsyncCallback(receive_data), null);
			}
			catch (SocketException)
			{
				disconnect();
				return;
			}
			catch (System.IO.IOException)
			{
				disconnect();
				return;
			}
			catch (NullReferenceException)
			{
				disconnect();
				return;
			}
			catch (ObjectDisposedException)
			{
				//Do nothing.
				return;
			}
		}
	}
}