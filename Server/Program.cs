//Import resources
using System;

namespace Server
{
	//Create the class
    class Program
    {
    	//Initialize the class
        static void Main(string[] args)
        {
            //Create and start the server
            Server _server = new Server();
            	   _server.start();
        }
    }
}
