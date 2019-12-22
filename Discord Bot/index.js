//Import resources
const { Client, Collection } = require("discord.js");
const { config } = require("dotenv");
const fs = require("fs");

//Create and set up the client
const client            = new Client();
	  client.commands   = new Collection();
	  client.aliases    = new Collection();
	  client.categories = fs.readdirSync("./commands/");

//Get the .env data
config({
	path: __dirname + "/.env"
});

//Set up the handler
["command"].forEach(handler => {
	require(`./handlers/${handler}`)(client);
});

//Initialize the bot
client.on("ready", () => {
	console.log("The bot is online!");

	//Set the bot status
	client.user.setPresence({
		status: "online",
		game: {
			name: "Cubiexy",
			type: "PLAYING"
		}
	});
});

//Start handling the commands
client.on("message", async message => {

	//Set the prefix
	const prefix = "/";

	//Check for message stuff
	if (message.author.bot) return;
    if (!message.guild) return;
    if (!message.content.startsWith(prefix)) return;
    if (!message.member) message.member = await message.guild.fetchMember(message);

    //Get the arguments and command
    const args = message.content.slice(prefix.length).trim().split(/ +/g);
    const cmd = args.shift().toLowerCase();

    //Check for command length
    if (cmd.length === 0) return;

    //Check for command and run it
    let command = client.commands.get(cmd);
    if (!command) command = client.commands.get(client.aliases.get(cmd));

    if (command) 
        command.run(client, message, args);

});

//Handle enter and leave members
client.on("guildMemberAdd", (member) => {

	//Get the channel
	let guild = member.guild;
	let channel = guild.channels.find(channel => channel.name === "general-chat");

	//Check for channel
	if (!channel) return false;

	//Send welcome message
	return channel.send("Welcome **" + member.user.username + "**! Make sure you read all important channels before talking!");

});

client.on("guildMemberRemove", (member) => {

	//Get the channel
	let guild = member.guild;
	let channel = guild.channels.find(channel => channel.name === "general-chat");

	//Check for channel
	if (!channel) return false;

	//Send welcome message
	return channel.send("**" + member.user.tag + "** just left the server..")

});

//Login the bot
client.login(process.env.TOKEN);