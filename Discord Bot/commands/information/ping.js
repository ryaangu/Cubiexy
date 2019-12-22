//Import resources
const { RichEmbed } = require("discord.js");

//Command
module.exports = {
	name: "ping",
	category: "information",
	description: "Returns latency and API ping",
	usage: "/ping",

	run: async (client, message, args) => {

		//Send a pinging message
		var _msg = await message.channel.send(`:ping_pong: Pinging..`);

		//Create embed message with information
		var _embed = new RichEmbed()
		.setColor("#00a3e0")
		.setTitle(":ping_pong: Pong!")
		.addField("Latency", `${Math.floor(_msg.createdTimestamp - message.createdTimestamp)}ms`)
		.addField("API Latency", `${Math.round(client.ping)}ms`, true);

		//Edit the message with the embed
		_msg.edit(_embed);
	}
}