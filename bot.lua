local discordia = require('discordia')
local client = discordia.Client()
discordia.extensions()

local ownerId
local fs = require('fs')
local prefix = "b."

table.getLen = function(t)
	local c = 0
	for k, v in next, t do
		c = c + 1
	end
	return c
end

--[[
				Modules
########################################

]]
local modules = {}
modules.commands = {}

function loadModule(name)
	local path = "./commands/"
	local success, err = pcall(function()
		modules.commands[name] = require(path .. name)
	end)

	if success then
		print("Module loaded: " .. name)
	else
		print("Module not loaded: " .. name)
		print(err .. "\n")
	end

	table.sort(modules.commands)
end

function unloadModule(name)
	modules.commands[name] = nil
end

for k, _ in fs.scandirSync("./commands") do
	loadModule(k:gsub(".lua", ""))
end

--[[
				Events
########################################

]]

client:on('ready', function()
	print("\nLogged in as " .. client.user.tag)
	print("Running with " .. table.getLen(modules.commands) .. " commands")
	client:setGame("Running")
	ownerId = client.owner.id
end)

client:on('messageCreate', function(message)
	local args = message.content:split(" ")

	local cmd = args[1]:gsub(prefix, "")
	if modules.commands[cmd] then
		modules.commands[cmd].messageCreate(client, message, args, modules)
	end
end)

client:run('Bot TOKEN')