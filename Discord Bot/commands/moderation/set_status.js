//Command
module.exports = {
	name: "set_status",
	category: "moderation",
	description: "Set the bot status.",
	usage: "/set_status <status>, <name>, <type>",

	run: async (client, message, args) => {
		
		//Check if member doesn't have permissions
		if (!message.member.hasPermission("MANAGE_MESSAGES")) {
            return message.reply("You can't set my status!").then(m => m.delete(2000));
        }
		
		//Check for arguments
		if (args.length > 0)
		{
			//Split the arguments
			var _args = args.join(" ").split(", ");
			
			//Set the bot status
			client.user.setPresence({
				status: _args[0],
				game: {
					name: _args[1],
					type: _args[2]
				}
			});
			
			//Reply to the message
			return message.reply("Status set!");
		}
	}
}