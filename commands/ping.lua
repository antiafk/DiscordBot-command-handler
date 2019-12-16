local command = {
	name = "ping",
	description = "Ping command"
}

command.messageCreate = function(client, message, args)
	local m = message:reply("🏓 **Ping:** *pinging...*")
	local ping = math.floor((m.createdAt - message.createdAt) * 1000)
	m:setContent("🏓 **Ping:** " .. ping .. " ms")
end

return command
