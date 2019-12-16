-- Optional but recommended.
-- Information about command. Is good for help commands for example.
local command = {
	name = "Name of command",
	description = "Description of command"
}

command.messageCreate = function(client, message, args)
	-- Whats happens when the command is called
end

return command
