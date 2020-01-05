//Import resources
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Dynamic;

//Global namespace
namespace Server
{
	//Create the class
	class Program
	{
		//Initialize the class
		static void Main(string[] args)
		{
			//Create and start the server
			Server server = new Server();
				   server.start(9700);
					  
			//Show console message
			Console.WriteLine("Server started!");
		}
	}
}