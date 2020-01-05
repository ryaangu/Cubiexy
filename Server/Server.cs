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
	public class Server
	{
		//Default variables
		public int port = 0;
		
		//Client variables
		public List<Client> client_list;
		public List<string> accounts_online;
		
		public int client_id = 1;
		
		Thread      tcp_thread;
		TcpListener tcp_listener = null;
		
		//Start the server
		public void start(int tcp_port)
		{
			//Set the port
			port = tcp_port;
			
			//Create the lists
			client_list     = new List<Client>();
			accounts_online = new List<string>();
			
			//Start listening to new connections
			tcp_thread = new Thread(new ThreadStart(delegate 
			{
				listen();
			}));
			
			tcp_thread.Start();
		}
		
		//Stop the server
		public void stop()
		{
			//Stop listening
			tcp_listener.Stop();
			
			//Abort threading
			tcp_thread.Abort();
			
			//Close and abort client stuff
			foreach (Client client in client_list)
			{
				client.tcp_client.GetStream().Close();
				client.tcp_client.Close();
				client.read_thread.Abort();
				client.write_thread.Abort();
			}
			
			//Clear client list
			client_list.Clear();
		}
		
		//Listen to new connections
		private void listen()
		{
			//Create tcp listener
			tcp_listener = new TcpListener(IPAddress.Any, port);
			tcp_listener.Start();
			
			//Handle connections
			while (true)
			{
				Thread.Sleep(10);
				
				//Accept the connection
				TcpClient tcp_client = tcp_listener.AcceptTcpClient();
				
				//Show console message
				Console.WriteLine("Client connected! [" + client_id + "]");
				
				//Create and start the client
				Client client = new Client();
					   client.start(tcp_client, this, client_id);
						 
				//Add the client to client list
				client_list.Add(client);
				
				//Increase client id
				client_id += 1;
			}
		}
	}
}