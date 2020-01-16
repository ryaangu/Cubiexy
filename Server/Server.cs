//Import resources
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace Server
{
	//Create the class
	public class Server
	{
		//Default variables
		public const string IP   = "127.0.0.1";
		public const int    PORT = 9700;

		//Client variables
		public List<Socket> socket_list     = new List<Socket>();
		public List<Client> client_list     = new List<Client>();
		public List<string> accounts_online = new List<string>();

		public int client_id = 1;

		//Socket variables
		public Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

		//Start the server
		public void start()
		{
			//Bind, listen and start receiving new connections
			socket.Bind(new IPEndPoint(IPAddress.Parse(IP), PORT));
			socket.Listen(100);
			socket.BeginAccept(new AsyncCallback(accept_connection), null);

			//Show console message
			Console.WriteLine("Server started!");

			//Close when pressing enter
			Console.ReadLine();

			//Destroy
			destroy();
		}

		//Destroy everything
		public void destroy()
		{
			//Shutdown and close all sockets
			foreach (Client _client in client_list)
			{
				_client.disconnect();
			}

			//Shutdown and Close server socket
			socket.Shutdown(SocketShutdown.Both);
			socket.Close();
		}

		//Accept connection callback
		public void accept_connection(IAsyncResult AR)
		{
			//Show console message
			Console.WriteLine("Client connected [ID: " + client_id + "]");

			Socket _socket;

			//Get the socket
			try
			{
				_socket = socket.EndAccept(AR);
			} 
			catch (ObjectDisposedException)
			{
				return;
			}

			//Add the socket to the list
			socket_list.Add(_socket);

			//Create the client and add the to list
			Client _client = new Client(_socket, this, client_id);
			client_list.Add(_client);

			//Increase client id
			client_id += 1;

			//Accept new connection
			socket.BeginAccept(new AsyncCallback(accept_connection), null);
		}
	}
}