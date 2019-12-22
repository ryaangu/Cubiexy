//Command
module.exports = {
	name: "clear",
	category: "moderation",
	description: "Clears the chat.",
	usage: "/clear <delete_amount>",

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
		
		//Check if argument 0 is not a number
		if (isNaN(args[0])) {
            return message.reply("This is not a number!").then(m => m.delete(2000));
        }
		
		//Check if argument 0 is less than 0
		if (parseInt(args[0]) <= 0) {
            return message.reply("I can't delete 0 messages!").then(m => m.delete(2000));
        }
		
		//Get the delete amount
		var delete_amount;
		
		if (parseInt(args[0]) > 100)
			delete_amount = 100;
		else
			delete_amount = parseInt(args[0]);
		
		//Delete the messages
		message.channel.bulkDelete(delete_amount, true)
            .then(deleted => message.channel.send(`I deleted \`${deleted.size}\` messages.`).then(m => m.delete(2000)));
		
	}
}