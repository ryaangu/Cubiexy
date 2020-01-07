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
	public class Client
	{
		//Default variables
		Queue<BufferStream> write_queue = new Queue<BufferStream>();
		public Thread read_thread;
		public Thread write_thread;
		public Thread abort_thread;
		
		public TcpClient tcp_client;
		public Server    server;
		
		public string username   = "";
		public string world_name = "";
		public int    client_id;
		
		public bool connected = true;
		
		public Handler handler;
		
		//Buffer variables
		public int buffer_size      = 20000;
		public int buffer_alignment = 1;
		
		//Start the client
		public void start(TcpClient client, Server parent_server, int id)
		{
			//Set the client and server
			tcp_client = client;
			server     = parent_server;
			client_id  = id;
			
			//Set the client variables
			client.SendBufferSize    = buffer_size;
            client.ReceiveBufferSize = buffer_size;
			
			//Create and start handler
			handler = new Handler();
			handler.start(this);
			
			//Create and start threads
			read_thread = new Thread(new ThreadStart(delegate
			{
				read();
			}));
			
			read_thread.Start();
			
			write_thread = new Thread(new ThreadStart(delegate
			{
				write();
			}));
			
			write_thread.Start();
		}
		
		//Send data
		public void send(BufferStream buffer)
		{
			write_queue.Enqueue(buffer);
		}
		
		public void send_to_world(BufferStream buffer)
		{
			foreach (Client client in server.client_list)
			{
				if (client.world_name == world_name && world_name != "")
				{
					client.send(buffer);
				}
            }
		}
		
		//Disconnect the client
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
			Console.WriteLine("Client disconnected. [" + client_id + "]");
			
			//Remove client from server
			server.client_list.Remove(this);
			
			//Close stream
			tcp_client.Close();
			
			//Create and start abort thread
			abort_thread = new Thread(new ThreadStart(delegate
			{
				abort();
			}));
			
			abort_thread.Start();
		}
		
		//Stop threads
		public void abort()
		{
			try
			{
				read_thread.Abort();
				write_thread.Abort();
				abort_thread.Abort();
			}
			catch (System.PlatformNotSupportedException)
			{
				//Do nothing.
				return;
			}
			
			//Disconnect
			connected = false;
		}
		
		//Write data
		public void write()
		{
			while (true)
			{
				Thread.Sleep(5);
				if (write_queue.Count != 0)
				{
					try
					{
						BufferStream buffer = write_queue.Dequeue();
						NetworkStream stream = tcp_client.GetStream();
						stream.Write(buffer.Memory, 0, buffer.Iterator);
						stream.Flush();
					}
					catch (System.IO.IOException)
					{
						disconnect();
						break;
					}
					catch (NullReferenceException)
					{
						disconnect();
						break;
					}
					catch (ObjectDisposedException)
					{
						break;
					}
					catch (System.InvalidOperationException)
					{
						break;
					}
				}
			}
		}
		
		//Read data
		public void read()
		{
			while (true)
			{
				try
				{
					Thread.Sleep(1);
					BufferStream read_buffer = new BufferStream(buffer_size, 1);
					NetworkStream stream     = tcp_client.GetStream();
					stream.Read(read_buffer.Memory, 0, buffer_size);

					//Handle data
					handler.handle(read_buffer);
				}
				catch (System.IO.IOException)
				{
					disconnect();
					break;
				}
				catch (NullReferenceException)
				{
					disconnect();
					break;
				}
				catch (ObjectDisposedException)
				{
					//Do nothing.
					break;
				}
			}
		}
	}
}