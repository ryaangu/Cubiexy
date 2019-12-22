//Command
module.exports = {
	name: "say",
	category: "moderation",
	description: "Say a message using the bot.",
	usage: "/say <message>",

	run: async (client, message, args) => {

		//Delete the message
		if (message.deletable)
		{
			message.delete();
		}
		
		//Check if member doesn't have permissions
		if (!message.member.hasPermission("MANAGE_MESSAGES")) {
            return message.reply("You can't delete messages!").then(m => m.delete(2000));
        }
		
		//Check if no message
		if (args.length < 0)
		{
			return message.reply("I can't say nothing!").then(m => m.delete(2000));
		}
		
		//Check for empty message
		if (args[0] == "")
		{
			return message.reply("I can't say nothing!").then(m => m.delete(2000));
		}
		
		//Send the message
		message.channel.send(args.join(" ")).catch(err => message.reply("I can't say nothing!").then(m => m.delete(2000)));
	}
}