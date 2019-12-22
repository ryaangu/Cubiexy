//Import resources
const { RichEmbed } = require("discord.js");
const { stripIndents } = require("common-tags");

//Command
module.exports = {
    name: "help",
    category: "information",
    description: "Returns all commands, or one specific command info",
    usage: "/help <command>",

    run: async (client, message, args) => {

        //Check for command
        if (args[0])
            return get_command(client, message, args[0]);
        else
            return get_all_commands(client, message);

    }
}

//Return all commands
async function get_all_commands(client, message) {

    //Send a getting commands message
    var _msg = await message.channel.send(`:printer: Getting all commands..`);

    //Create embed message for the categorys and commands
    var _embed = new RichEmbed()
    .setColor("#00a3e0")
    .setTitle(":page_with_curl: Command List")
    .setFooter("Use /help <command> to get command information.")

    //Get category and commands
    const commands = (category) => {
		if (category != "moderation")
		{
			return client.commands
				.filter(cmd => cmd.category === category)
				.map(cmd => cmd.name)
				.join("\n");
		}
    }

    const info = client.categories
        .map(cat => stripIndents`**${cat[0].toUpperCase() + cat.slice(1)}** \n${commands(cat)}`)
        .reduce((string, category) => string + "\n\n" + category);

    //Set the embed description
    _embed.setDescription(info);

    //Edit the message with the embed
    _msg.edit(_embed);
}

//Return specific command
async function get_command(client, message, input) {

    //Send a getting command message
    var _msg = await message.channel.send(`:printer: Getting the command..`);

    //Create embed message for command information
    var _embed = new RichEmbed()
    .setColor("#00a3e0")
    .setTitle(":page_with_curl: Command Information")

    //Get the command information
    const cmd = client.commands.get(input.toLowerCase()) || client.commands.get(client.aliases.get(input.toLowerCase()));
    
    let info = `No information found for command **${input.toLowerCase()}**!`;

    //Check for command
    if (!cmd) {

        //Return an error
        _msg.edit(_embed.setDescription(info));

    } else {

        //Return the command information
        if (cmd.name) info = `**Command Name**: ${cmd.name}`;
        if (cmd.description) info += `\n**Command Description**: ${cmd.description}`;
        if (cmd.usage) info += `\n**Command Usage**: ${cmd.usage}`;

        //Set the embed description
        _embed.setDescription(info);

        //Edit the message with the embed
        _msg.edit(_embed);

    }
}