//Import
using System;

using System.Net;
using System.Net.Sockets;
using System.Threading.Tasks;

using System.Collections.Generic;

namespace Server
{
	//Create client class
	public class Client
	{
		//Client variables
		public TcpClient     CLIENT;
		public NetworkStream STREAM;
		public Server        SERVER;
		public int           CLIENT_ID;
		public BufferStream  BUFFER;

		//Initialize the client
		public Client(TcpClient client, Server server, int client_id)
		{
			//Set the client variables
			CLIENT    = client;
			STREAM    = CLIENT.GetStream();
			SERVER    = server;
			CLIENT_ID = client_id;
			BUFFER    = new BufferStream(1024, 1);

			//Client settings
			CLIENT.NoDelay        = true;
			CLIENT.ReceiveTimeout = 1000;
			CLIENT.SendTimeout    = 1000;
		}

		//Send
		public async Task send(BufferStream b)
		{
			await STREAM.WriteAsync(b.Memory, 0, b.Iterator);
		}

		//Handle data
		public async Task HandleData()
		{
			while (SERVER.RUNNING)
			{
				try
				{
					var received = await STREAM.ReadAsync(BUFFER.Memory, 0, 1024);

					if (received == 0)
					{
						Disconnect();
						break;
					}

					BUFFER.SetBytes(received);
					BUFFER.Seek(0);

					while (BUFFER.BYTES > 0)
					{
						ushort size;
						BUFFER.Read(out size);

						ushort id;
						BUFFER.Read(out id);

						if (id == 0) 
						{
							Console.WriteLine($"DATA! {size}");
					
							BufferStream b = new BufferStream(100, 1);
							b.Seek(0);
							b.Write(size);
							//b.Write(id);

							await send(b);
						}
					}
				}
				catch (System.IO.IOException)
				{
					Disconnect();
					break;
				}
				catch (NullReferenceException)
				{
					Disconnect();
					break;
				}
				catch (ObjectDisposedException)
				{
					//Do nothing.
					break;
				}
			}
		}

		//Disconnect
		public void Disconnect()
		{
			//Remove self from list
			SERVER.client_list.Remove(this);

			//Close the client
			CLIENT.Close();

			Console.WriteLine($"Client disconnected. [ID: {CLIENT_ID}]");
		}
	}
}