//Import resources
const { RichEmbed } = require("discord.js");

//Command
module.exports = {
	name: "game_info",
	category: "information",
	description: "Returns game information",
	usage: "/game_info",

	run: async (client, message, args) => {

		//Send a pinging message
		var _msg = await message.channel.send(`:printer: Getting game information..`);

		//Create embed message with information
		var _embed = new RichEmbed()
		.setColor("#00a3e0")
		.setTitle(":page_with_curl: Game Information")
		.addField("Game Name", "Cubiexy")
		.addField("Game Server", "Offline")
		.addField("Game Download Link", "Not available yet")
		.setThumbnail(message.guild.iconURL);

		//Edit the message with the embed
		_msg.edit(_embed);
	}
}