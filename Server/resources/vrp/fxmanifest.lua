fx_version "bodacious"
game "gta5"
lua54 "yes"

version "6.0.0"
author "ImagicTheCat"

hensa_rewritten "yes"
creator "yes"

client_scripts {
	"lib/Utils.lua",

	"config/Global.lua",
	"config/Groups.lua",
	"config/Influences.lua",
	"config/Item.lua",
	"config/License.lua",
	"config/Native.lua",
	"config/Rewards.lua",
	"config/Vehicle.lua",

	"client/Local.lua",
	"client/Active.lua",

	"client/base.lua",
	"client/gui.lua",
	"client/hitmarker.lua",
	"client/iplloader.lua",
	"client/noclip.lua",
	"client/objects.lua",
	"client/playanim.lua",
	"client/player.lua",
	"client/vehicles.lua"
}

server_scripts {
	"lib/Utils.lua",

	"config/Global.lua",
	"config/Groups.lua",
	"config/Influences.lua",
	"config/Item.lua",
	"config/License.lua",
	"config/Native.lua",
	"config/Rewards.lua",
	"config/Vehicle.lua",

	"modules/vrp.lua",
	"modules/server.lua",
	"modules/prepare.lua",
	"modules/webhooks.lua"
}

files {
	"lib/*",
	"config/*",
	"config/**/*"
}