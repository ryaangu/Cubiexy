///Import resources
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Dynamic;
using IniParser;
using IniParser.Model;

//Global namespace
namespace Server
{
	//Create the class
	public class Database
	{
		//Default variables
		public string            path;
		public FileIniDataParser parser;
		public IniData           data;
		
		//Initialize the class
		public Database(string folder, string file)
		{
			//Set the path
			path = "Database/" + folder + "/" + file + ".ini";

			//Create the ini parser
			parser = new FileIniDataParser();

			//Update data
			update_data();
		}

		//Update ini data
		public void update_data()
		{
			//Check if the file exists and parse it
			if (exists()) 
			{
				data = parser.ReadFile(path); 
			}
			else
			{
				data = new IniData();
			}
		}

		//Add section to ini
		public void add_section(string section_name)
		{
			data.Sections.AddSection(section_name);
			save();
		}

		//Remove section from ini
		public void remove_section(string section_name)
		{
			data.Sections.RemoveSection(section_name);
			save();
		}

		//Add key to section
		public void add_key(string section_name, string key_name, string _value)
		{
			data[section_name].AddKey(key_name, _value);
			save();	
		}

		//Edit key from section
		public void edit_key(string section_name, string key_name, string _value)
		{
			data[section_name][key_name] = _value;
			save();
		}

		//Remove key from section
		public void remove_key(string section_name, string key_name)
		{
			data[section_name].RemoveKey(key_name);
			save();
		}

		//Get key value from section
		public int get_integer_key(string section_name, string key_name)
		{
			return Int32.Parse(data[section_name][key_name]);
		}

		public bool get_boolean_key(string section_name, string key_name)
		{
			return bool.Parse(data[section_name][key_name]);
		}

		public string get_string_key(string section_name, string key_name)
		{
			return data[section_name][key_name];
		}

		//Check if file exists
		public bool exists()
		{
			return File.Exists(path);
		}

		//Save file
		public void save()
		{
			parser.WriteFile(path, data);
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
}