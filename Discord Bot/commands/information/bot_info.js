//Import resources
const { RichEmbed } = require("discord.js");

///Command
module.exports = {
	name: "bot_info",
	category: "information",
	description: "Returns bot information",
	usage: "/bot_info",

	run: async (client, message, args) => {

		//Send a pinging message
		var _msg = await message.channel.send(`:printer: Getting bot information..`);

		//Create embed message with information
		var _embed = new RichEmbed()
		.setColor("#00a3e0")
		.setTitle(":page_with_curl: Bot Information")
		.addField("Bot Name", client.user.username)
		.addField("Bot Created At", client.user.createdAt)
		.setThumbnail(message.guild.iconURL);

		//Edit the message with the embed
		_msg.edit(_embed);
	}
}