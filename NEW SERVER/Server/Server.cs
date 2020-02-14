//Import
using System;

using System.Net;
using System.Net.Sockets;
using System.Threading.Tasks;

using System.Collections.Generic;

namespace Server
{
	//Create server class
	public class Server
	{
		//Server variables
		public string      SERVER_IP;
		public int         SERVER_PORT;
		public TcpListener LISTENER;
		public bool        RUNNING;

		//Lists variables
		public List<Client> client_list;

		//Client variables
		public int client_id;

		//Initialize the server
		public Server(string server_ip, int server_port)
		{
			//Set the server variables
			SERVER_IP   = server_ip;
			SERVER_PORT = server_port;
			LISTENER    = new TcpListener(IPAddress.Parse(SERVER_IP), SERVER_PORT);
			RUNNING     = true;

			//Initialize the variables
			client_list = new List<Client>();
			client_id   = 1;

			Console.WriteLine("Server started!");

			//Handle connections
			var _ = HandleConnections();

			//Destroy server
			Console.ReadLine();
			Stop();
		}

		//Handle connections
		public async Task HandleConnections()
		{
			//Start the listener
			LISTENER.Start();

			//Accept connections
			TcpClient tcp_client;
			Client    client;

			while (RUNNING)
			{
				tcp_client = await LISTENER.AcceptTcpClientAsync();

				//Connection accepted
				if (tcp_client != null)
				{
					//Create client class
					client = new Client(tcp_client, this, client_id);
					var _  = client.HandleData();

					//Add the client
					client_list.Add(client);
					client_id += 1;

					Console.WriteLine($"Client connected! [ID: {client.CLIENT_ID}]");
				}
			}
		}

		//Stop the server
		public void Stop()
		{
			//Stop the listener
			LISTENER.Stop();
		}
	}
}