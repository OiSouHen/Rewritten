fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@PolyZone/client.lua",
	"@vrp/lib/Utils.lua",
	"client/*"
}

shared_scripts {
	"shared/*"
}

files {
	"web/*.html",
	"web/*.css",
	"web/*.js"
}