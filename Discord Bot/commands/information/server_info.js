//Import resources
const { RichEmbed } = require("discord.js");

//Command
module.exports = {
	name: "server_info",
	category: "information",
	description: "Returns server information",
	usage: "/server_info",

	run: async (client, message, args) => {

		//Send a pinging message
		var _msg = await message.channel.send(`:printer: Getting server information..`);

		//Create embed message with information
		var _embed = new RichEmbed()
		.setColor("#00a3e0")
		.setTitle(":page_with_curl: Server Information")
		.addField("Server Name", message.guild.name)
		.addField("Server Created At", message.guild.createdAt)
		.addField("Server Member Count", message.guild.memberCount)
		.addField("You joined at", message.member.joinedAt)
		.setThumbnail(message.guild.iconURL);

		//Edit the message with the embed
		_msg.edit(_embed);
	}
}