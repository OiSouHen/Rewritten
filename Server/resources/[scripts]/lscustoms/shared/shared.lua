-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
Payments = {
	cosmetics = 1250,
	respray = 1250,
	engines = { 999999, 999999, 999999, 999999, 999999, 999999 },
	brakes = { 999999, 999999, 999999, 999999, 999999, 999999 },
	transmission = { 999999, 999999, 999999, 999999, 999999, 999999 },
	suspension = { 999999, 999999, 999999, 999999, 999999, 999999 },
	shield = { 999999, 999999, 999999, 999999, 999999, 999999 },
	turbo = 7250,
	wheels = 1250,
	customwheels = 1250,
	wheelsmoke = 775,
	windowtint = 775,
	neonside = 775,
	neoncolours = 1250,
	headlights = 775,
	xenoncolours = 1250,
	policelivery = 125,
	plateindex = 775
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Locations = {
	["Mechanic01"] = {
		["Permission"] = "Mecanico",
		["Position"] = vec3(-339.15,-136.66,39.01),
		["Heading"] = 87.88
	},
	["Mechanic02"] = {
		["Permission"] = "Mecanico",
		["Position"] = vec3(-1155.12,-2005.7,13.18),
		["Heading"] = 334.49
	},
	["Mechanic03"] = {
		["Permission"] = "Mecanico",
		["Position"] = vec3(1174.98,2640.4,37.74),
		["Heading"] = 1.0
	},
	["Mechanic04"] = {
		["Permission"] = "Mecanico",
		["Position"] = vec3(110.63,6626.54,31.78),
		["Heading"] = 224.94
	},
	["Mechanic05"] = {
		["Permission"] = "Mecanico",
		["Position"] = vec3(-222.63,-1330.03,30.57),
		["Heading"] = 272.13
	},
	["Mechanic06"] = {
		["Permission"] = "Mecanico",
		["Position"] = vec3(731.7,-1088.84,21.84),
		["Heading"] = 87.88
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLECUSTOMISATION
-----------------------------------------------------------------------------------------------------------------------------------------
vehicleCustomisation = {
	{
		category = "Spoiler",
		id = 0
	},{
		category = "Front Bumper",
		id = 1
	},{
		category = "Rear Bumper",
		id = 2
	},{
		category = "Side Skirt",
		id = 3
	},{
		category = "Exhaust",
		id = 4
	},{
		category = "Roll Cage",
		id = 5
	},{
		category = "Grille",
		id = 6
	},{
		category = "Hood",
		id = 7
	},{
		category = "Left Fender",
		id = 8
	},{
		category = "Right Fender",
		id = 9
	},{
		category = "Roof",
		id = 10
	},{
		category = "Vanity Plates",
		id = 25
	},{
		category = "Trim A",
		id = 27
	},{
		category = "Ornaments",
		id = 28
	},{
		category = "Dashboard",
		id = 29
	},{
		category = "Dial",
		id = 30
	},{
		category = "Door Speaker",
		id = 31
	},{
		category = "Seats",
		id = 32
	},{
		category = "Steering Wheel",
		id = 33
	},{
		category = "Shifter Leaver",
		id = 34
	},{
		category = "Plaque",
		id = 35
	},{
		category = "Speaker",
		id = 36
	},{
		category = "Trunk",
		id = 37
	},{
		category = "Hydraulic",
		id = 38
	},{
		category = "Engine Block",
		id = 39
	},{
		category = "Air Filter",
		id = 40
	},{
		category = "Strut",
		id = 41
	},{
		category = "Arch Cover",
		id = 42
	},{
		category = "Aerial",
		id = 43
	},{
		category = "Trim B",
		id = 44
	},{
		category = "Fuel Tank",
		id = 45
	},{
		category = "Window",
		id = 46
	},{
		category = "Livery",
		id = 48
	},{
		id = 14,
		category = "Horns",
		hornNames = {
			{ name = "Truck Horn", id = 0 },
			{ name = "Cop Horn", id = 1 },
			{ name = "Clown Horn", id = 2 },
			{ name = "Musical Horn 1", id = 3 },
			{ name = "Musical Horn 2", id = 4 },
			{ name = "Musical Horn 3", id = 5 },
			{ name = "Musical Horn 4", id = 6 },
			{ name = "Musical Horn 5", id = 7 },
			{ name = "Sad Trombone", id = 8 },
			{ name = "Classical Horn 1", id = 9 },
			{ name = "Classical Horn 2", id = 10 },
			{ name = "Classical Horn 3", id = 11 },
			{ name = "Classical Horn 4", id = 12 },
			{ name = "Classical Horn 5", id = 13 },
			{ name = "Classical Horn 6", id = 14 },
			{ name = "Classical Horn 7", id = 15 },
			{ name = "Scale - Do", id = 16 },
			{ name = "Scale - Re", id = 17 },
			{ name = "Scale - Mi", id = 18 },
			{ name = "Scale - Fa", id = 19 },
			{ name = "Scale - Sol", id = 20 },
			{ name = "Scale - La", id = 21 },
			{ name = "Scale - Ti", id = 22 },
			{ name = "Scale - Do", id = 23 },
			{ name = "Jazz Horn 1", id = 24 },
			{ name = "Jazz Horn 2", id = 25 },
			{ name = "Jazz Horn 3", id = 26 },
			{ name = "Jazz Horn Loop", id = 27 },
			{ name = "Star Spangled Banner 1", id = 28 },
			{ name = "Star Spangled Banner 2", id = 29 },
			{ name = "Star Spangled Banner 3", id = 30 },
			{ name = "Star Spangled Banner 4", id = 31 },
			{ name = "Classical Horn 8 Loop", id = 32 },
			{ name = "Classical Horn 9 Loop", id = 33 },
			{ name = "Classical Horn 10 Loop", id = 34 },
			{ name = "Classical Horn 8", id = 35 },
			{ name = "Classical Horn 9", id = 36 },
			{ name = "Classical Horn 10", id = 37 },
			{ name = "Funeral Loop", id = 38 },
			{ name = "Funeral", id = 39 },
			{ name = "Spooky Loop", id = 40 },
			{ name = "Spooky", id = 41 },
			{ name = "San Andreas Loop", id = 42 },
			{ name = "San Andreas", id = 43 },
			{ name = "Liberty City Loop", id = 44 },
			{ name = "Liberty City", id = 45 },
			{ name = "Festive 1 Loop", id = 46 },
			{ name = "Festive 1", id = 47 },
			{ name = "Festive 2 Loop", id = 48 },
			{ name = "Festive 2", id = 49 },
			{ name = "Festive 3 Loop", id = 50 },
			{ name = "Festive 3", id = 51 }
		}
	},{
		category = "Engine Upgrade",
		type = "engines",
		id = 11
	},{
		category = "Brake Upgrade",
		type = "brakes",
		id = 12
	},{
		category = "Transmission Upgrade",
		type = "transmission",
		id = 13
	},{
		category = "Suspension Upgrade",
		type = "suspension",
		id = 15
	},{
		category = "Shielding Upgrade",
		type = "shield",
		id = 16
	},{
		category = "Turbo Upgrade",
		id = 18
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEWINDOWTINTOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vehicleWindowTintOptions = {
	{
		name = "None",
		id = 0
	},{
		name = "Pure Black",
		id = 1    
	},{
		name = "Darksmoke",
		id = 2
	},{
		name = "Lightsmoke",
		id = 3
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEWHEELOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vehicleWheelOptions = {
	{
		category = "Custom Tyres",
		id = -1,
		wheelID = 23
	},{
		category = "Tyre Smoke",
		id = 20,
		wheelID = 23
	},{
		category = "Sport",
		id = 0,
		wheelID = 23
	},{
		category = "Muscle",
		id = 1,
		wheelID = 23
	},{
		category = "Lowrider",
		id = 2,
		wheelID = 23
	},{
		category = "Suv",
		id = 3,
		wheelID = 23
	},{
		category = "Offroad",
		id = 4,
		wheelID = 23
	},{
		category = "Tuner",
		id = 5,
		wheelID = 23
	},{
		category = "Super",
		id = 6,
		wheelID = 23
	},{
		category = "Highend",
		id = 7,
		wheelID = 23
	},{
		category = "Originals",
		id = 8,
		wheelID = 23
	},{
		category = "Bespokes",
		id = 9,
		wheelID = 23
	},{
		category = "Streets",
		id = 11,
		wheelID = 23
	},{
		category = "Trackers",
		id = 12,
		wheelID = 23
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYRESMOKEOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vehicleTyreSmokeOptions = {
	{ name = "White Smoke", r = 254, g = 254, b = 254 },
	{ name = "Black Smoke", r = 1, g = 1, b = 1 },
	{ name = "Blue Smoke", r = 0, g = 150, b = 255 },
	{ name = "Yellow Smoke", r = 255, g = 255, b = 50 },
	{ name = "Orange Smoke", r = 255, g = 153, b = 51 },
	{ name = "Red Smoke", r = 255, g = 10, b = 10 },
	{ name = "Green Smoke", r = 10, g = 255, b = 10 },
	{ name = "Purple Smoke", r = 153, g = 10, b = 153 },
	{ name = "Pink Smoke", r = 255, g = 102, b = 178 },
	{ name = "Gray Smoke", r = 128, g = 128, b = 128 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLERESPRAYCATEGORIES
-----------------------------------------------------------------------------------------------------------------------------------------
vehicleResprayCategories = {
	{
		category = "Primary Colour",
		id = 0
	},{
		category = "Secondary Colour",
		id = 1
	},{
		category = "Pearlescent Colour",
		id = 2
	},{
		category = "Wheel Colour",
		id = 3
	},{
		category = "Dashboard Colour",
		id = 4
	},{
		category = "Interior Colour",
		id = 5
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLERESPRAYOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vehicleResprayOptions = {
	{
		id = 1,
		category = "Metallic",
		colours = {
			{ name = "Black", id = 0 },
			{ name = "Carbon Black", id = 147 },
			{ name = "Graphite", id = 1 },
			{ name = "Anhracite Black", id = 11 },
			{ name = "Black Steel", id = 11 },
			{ name = "Dark Steel", id = 3 },
			{ name = "Silver", id = 4 },
			{ name = "Bluish Silver", id = 5 },
			{ name = "Rolled Steel", id = 6 },
			{ name = "Shadow Silver", id = 7 },
			{ name = "Stone Silver", id = 8 },
			{ name = "Midnight Silver", id = 9 },
			{ name = "Cast Iron Silver", id = 10 },
			{ name = "Red", id = 27 },
			{ name = "Torino Red", id = 28 },
			{ name = "Formula Red", id = 29 },
			{ name = "Lava Red", id = 150 },
			{ name = "Blaze Red", id = 30 },
			{ name = "Grace Red", id = 31 },
			{ name = "Garnet Red", id = 32 },
			{ name = "Sunset Red", id = 33 },
			{ name = "Cabernet Red", id = 34 },
			{ name = "Wine Red", id = 143 },
			{ name = "Candy Red", id = 35 },
			{ name = "Hot Pink", id = 135 },
			{ name = "Pfsiter Pink", id = 137 },
			{ name = "Salmon Pink", id = 136 },
			{ name = "Sunrise Orange", id = 36 },
			{ name = "Orange", id = 38 },
			{ name = "Bright Orange", id = 138 },
			{ name = "Gold", id = 99 },
			{ name = "Bronze", id = 90 },
			{ name = "Yellow", id = 88 },
			{ name = "Race Yellow", id = 89 },
			{ name = "Dew Yellow", id = 91 },
			{ name = "Dark Green", id = 49 },
			{ name = "Racing Green", id = 50 },
			{ name = "Sea Green", id = 51 },
			{ name = "Olive Green", id = 52 },
			{ name = "Bright Green", id = 53 },
			{ name = "Gasoline Green", id = 54 },
			{ name = "Lime Green", id = 92 },
			{ name = "Midnight Blue", id = 141 },
			{ name = "Galaxy Blue", id = 61 },
			{ name = "Dark Blue", id = 62 },
			{ name = "Saxon Blue", id = 63 },
			{ name = "Blue", id = 64 },
			{ name = "Mariner Blue", id = 65 },
			{ name = "Harbor Blue", id = 66 },
			{ name = "Diamond Blue", id = 67 },
			{ name = "Surf Blue", id = 68 },
			{ name = "Nautical Blue", id = 69 },
			{ name = "Racing Blue", id = 73 },
			{ name = "Ultra Blue", id = 70 },
			{ name = "Light Blue", id = 74 },
			{ name = "Chocolate Brown", id = 96 },
			{ name = "Bison Brown", id = 101 },
			{ name = "Creeen Brown", id = 95 },
			{ name = "Feltzer Brown", id = 94 },
			{ name = "Maple Brown", id = 97 },
			{ name = "Beechwood Brown", id = 103 },
			{ name = "Sienna Brown", id = 104 },
			{ name = "Saddle Brown", id = 98 },
			{ name = "Moss Brown", id = 100 },
			{ name = "Woodbeech Brown", id = 102 },
			{ name = "Straw Brown", id = 99 },
			{ name = "Sandy Brown", id = 105 },
			{ name = "Bleached Brown", id = 106 },
			{ name = "Schafter Purple", id = 71 },
			{ name = "Spinnaker Purple", id = 72 },
			{ name = "Midnight Purple", id = 142 },
			{ name = "Bright Purple", id = 145 },
			{ name = "Cream", id = 107 },
			{ name = "Ice White", id = 111 },
			{ name = "Frost White", id = 112 }
		}
	},{
		id = 2,
		category = "Matte",
		colours = {
			{ name = "Black", id = 12 },
			{ name = "Gray", id = 13 },
			{ name = "Light Gray", id = 14 },
			{ name = "Ice White", id = 131 },
			{ name = "Blue", id = 83 },
			{ name = "Dark Blue", id = 82 },
			{ name = "Midnight Blue", id = 84 },
			{ name = "Midnight Purple", id = 149 },
			{ name = "Schafter Purple", id = 148 },
			{ name = "Red", id = 39 },
			{ name = "Dark Red", id = 40 },
			{ name = "Orange", id = 41 },
			{ name = "Yellow", id = 42 },
			{ name = "Lime Green", id = 55 },
			{ name = "Green", id = 128 },
			{ name = "Forest Green", id = 151 },
			{ name = "Foliage Green", id = 155 },
			{ name = "Olive Darb", id = 152 },
			{ name = "Dark Earth", id = 153 },
			{ name = "Desert Tan", id = 154 }
		}
	},{
		id = 3,
		category = "Metals",
		colours = {
			{ name = "Brushed Steel", id = 117 },
			{ name = "Brushed Black Steel", id = 118 },
			{ name = "Brushed Aluminium", id = 119 },
			{ name = "Pure Gold", id = 158 },
			{ name = "Brushed Gold", id = 159 },
			{ name = "Chrome", id = 120 },
			{ name = "Vice City", id = 161 },
			{ name = "Red/Rainbow Flip", id = 162 },
			{ name = "Magenta/Orange Flip", id = 163 },
			{ name = "Kamen Rider", id = 164 },
			{ name = "Blue/Pink Flip", id = 165 },
			{ name = "Turquoise/Purple Flip", id = 166 },
			{ name = "Chromatic Aberration", id = 167 },
			{ name = "Anodized Lime Pearl", id = 168 },
			{ name = "Oil Spill Prismatic Pearl", id = 169 },
			{ name = "It's Christmas!", id = 170 },
			{ name = "Maisonette 9 Throwback", id = 171 },
			{ name = "Green/Turquoise Flip", id = 172 },
			{ name = "White Prismatic Pearl", id = 173 },
			{ name = "Magenta/Green Flip", id = 174 },
			{ name = "Night & Day", id = 175 },
			{ name = "Temperature", id = 176 },
			{ name = "Black Holographic Pearl", id = 177 },
			{ name = "Fubuki-jo Specials: Temperature", id = 178 },
			{ name = "Bubblegum", id = 179 },
			{ name = "Fubuki-jo Specials: Kamen Rider", id = 180 },
			{ name = "Copper/Purple Flip", id = 181 },
			{ name = "Oil Slick Pearl", id = 182 },
			{ name = "Blue Prismatic Pearl", id = 183 },
			{ name = "Fubuki-jo Specials: Synthwave Night", id = 184 },
			{ name = "Baby Blue Pearl", id = 185 },
			{ name = "Anodized Copper Pearl", id = 186 },
			{ name = "Fubuki-jo Specials: HSW Badge", id = 187 },
			{ name = "Green Prismatic Pearl", id = 188 },
			{ name = "Orange/Purple Flip", id = 189 },
			{ name = "Green/Blue Flip", id = 190 },
			{ name = "Green/Brown Flip", id = 191 },
			{ name = "Anodized Red Pearl", id = 192 },
			{ name = "Blue/Green Flip", id = 193 },
			{ name = "Light Purple Pearl", id = 194 },
			{ name = "Anodized Gold Pearl", id = 195 },
			{ name = "Purple/Green Flip", id = 196 },
			{ name = "Burgundy/Green Flip", id = 197 },
			{ name = "Blue/Rainbow Flip", id = 198 },
			{ name = "Dark Green Pearl", id = 199 },
			{ name = "Monochrome", id = 200 },
			{ name = "White Holographic Pearl", id = 201 },
			{ name = "Dark Blue Pearl", id = 202 },
			{ name = "Fubuki-jo Specials: Fubuki Castle", id = 203 },
			{ name = "Black Prismatic Pearl", id = 204 },
			{ name = "The Verlierer", id = 205 },
			{ name = "Orange/Blue Flip", id = 206 },
			{ name = "Graphite Prismatic Pearl", id = 207 },
			{ name = "Dark Teal Pearl", id = 208 },
			{ name = "Cyan/Purple Flip", id = 209 },
			{ name = "Fubuki-jo Specials: It's Christmas!", id = 210 },
			{ name = "Fubuki-jo Specials: Bubblegum", id = 211 },
			{ name = "Dark Purple Pearl", id = 212 },
			{ name = "Light Pink Pearl", id = 213 },
			{ name = "Fubuki-jo Specials: Anod. Lightning", id = 214 },
			{ name = "Sunset", id = 215 },
			{ name = "Turquoise/Red Flip", id = 216 },
			{ name = "Fubuki-jo Specials: Sunset", id = 217 },
			{ name = "Purple Prismatic Pearl", id = 218 },
			{ name = "Light Green Pearl", id = 219 },
			{ name = "Fubuki-jo Specials: The Verlierer", id = 220 },
			{ name = "Fubuki-jo Specials: Sprunk Extreme", id = 221 },
			{ name = "Cute Pink Pearl", id = 222 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENEONOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vehicleNeonOptions = {
	category = "Neons",
	neonTypes = {
		{ name = "Front Neon", id = 2 },
		{ name = "Rear Neon", id = 3 },
		{ name = "Left Neon", id = 0 },
		{ name = "Right Neon", id = 1 }
	},
	neonColours = {
		{ name = "White", r = 222, g = 222, b = 255 },
		{ name = "Blue", r = 2, g = 21, b = 255 },
		{ name = "Electric Blue", r = 3, g = 83, b = 255 },
		{ name = "Mint Green", r = 0, g = 255, b = 140 },
		{ name = "Lime Green", r = 94, g = 255, b = 1 },
		{ name = "Yellow", r = 255, g = 255, b = 0 },
		{ name = "Golden Shower", r = 255, g = 150, b = 0 },
		{ name = "Orange", r = 255, g = 62, b = 0 },
		{ name = "Red", r = 255, g = 1, b = 1 },
		{ name = "Pony Pink", r = 255, g = 50, b = 100 },
		{ name = "Hot Pink", r = 255, g = 5, b = 190 },
		{ name = "Purple", r = 35, g = 1, b = 255 },
		{ name = "Blacklight", r = 15, g = 3, b = 255 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEXENONOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vehicleXenonOptions = {
	xenonColours = {
		{ name = "Padrão", id = 255 },
		{ name = "White", id = 0 },
		{ name = "Blue", id = 1 },
		{ name = "Electric Blue", id = 2 },
		{ name = "Mint Green", id = 3 },
		{ name = "Lime Green", id = 4 },
		{ name = "Yellow", id = 5 },
		{ name = "Golden Shower", id = 6 },
		{ name = "Orange", id = 7 },
		{ name = "Red", id = 8 },
		{ name = "Pony Pink", id = 9 },
		{ name = "Hot Pink", id = 10 },
		{ name = "Purple", id = 11 },
		{ name = "Blacklight", id = 12 }
	}
}