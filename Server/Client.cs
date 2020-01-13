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
		public const int BUFFER_SIZE = 20000;

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
			read_buffer.ZeroMemory();
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
		}

		//Disconnect
		public void disconnect()
		{
			//Destroy the player
			if (world_name != "")
			{
				handler.handle_player_destroy();
				handler.handle_world_leave();
			}
			
			//Leave from account
			if (username != "")
				handler.handle_account_logout();

			//Show console message
			Console.WriteLine("Client disconnected [ID: " + client_id + "]");

			//Set connected to false
			connected = false;

			//Destroy
			destroy();
		}

		//Send data
		public void send(BufferStream _buffer)
		{
			//Begin sending data
			socket.BeginSend(_buffer.Memory, 0, _buffer.Iterator, SocketFlags.None, new AsyncCallback(send_data), null);
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

				//Check for data length
				if (_data > 0)
				{
					//Handle
					read_buffer.Seek(0);
					handler.handle(read_buffer);
				} 
				else 
				{
					disconnect();
					return;
				}

				//Receive more data
				if (connected)
				{
					read_buffer.ZeroMemory();
					socket.BeginReceive(read_buffer.Memory, 0, BUFFER_SIZE, SocketFlags.None, new AsyncCallback(receive_data), null);
				}
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