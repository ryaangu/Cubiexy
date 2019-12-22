///Import resources
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using Newtonsoft.Json;

//Global namespace
namespace Server
{
	//Create the class
	public class Database
	{
		//Default variables
		string path;
		
		//Initialize the class
		public Database(string folder, string file)
		{
			//Set the path
			path = "Database/" + folder + "/" + file + ".json";
		}
		
		//Write the json file
		public void write(string json_string)
		{
			File.WriteAllText(path, json_string);
		}
		
		//Read the json file
		public string read()
		{
			using (StreamReader file = new StreamReader(path))
			{
				return file.ReadToEnd();
			}
		}
		
		//Check if file exists
		public bool exists()
		{
			return File.Exists(path);
		}
		
		//Encode to JSON
		public string encode(object obj)
		{
			return JsonConvert.SerializeObject(obj, Formatting.Indented);
		}
		
		//Decode to object
		public Account decode_account(string json_string)
		{
			return JsonConvert.DeserializeObject<Account>(json_string);
		}
		
		public World decode_world(string json_string)
		{
			return JsonConvert.DeserializeObject<World>(json_string);
		}
		
		//Hash string
		public string hash(string _string)
		{
			using (MD5 hash = MD5.Create())
			{
				byte[] data = hash.ComputeHash(Encoding.UTF8.GetBytes(_string));
				StringBuilder s_builder = new StringBuilder();
				
				for (int i = 0; i < data.Length; i++)
				{
					s_builder.Append(data[i].ToString("x2"));
				}
				
				return s_builder.ToString();
			}
		}
	}
	
	//Objects
	public class Account
	{
		public string username {get; set;}
		public string password {get; set;}
	}
	
	public class World
	{
		public string name {get; set;}
		public string owner {get; set;}
		public string data {get; set;}
	}
}