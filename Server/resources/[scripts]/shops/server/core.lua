-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("shops", Hensa)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	["BuyMaterial"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["alcohol"] = 40,
			["acetone"] = 40,
			["saline"] = 25,
			["sulfuric"] = 30,
			["syringe"] = 3,
			["pistolbody"] = 425,
			["smgbody"] = 525,
			["riflebody"] = 625,
			["explosives"] = 75,
			["vote"] = 175,
			["chlorine"] = 55,
			["WEAPON_BRICK"] = 25,
			["WEAPON_NAIL_AMMO"] = 2,
			["whistle"] = 125,
			["sprays01"] = 525,
			["campfire"] = 675,
			["bucket"] = 25,
			["fertilizer"] = 285,
			["WEAPON_PENCIL"] = 15
		}
	},
	["SellMaterial"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["alcohol"] = 20,
			["acetone"] = 20,
			["saline"] = 13,
			["sulfuric"] = 15,
			["syringe"] = 2,
			["pistolbody"] = 225,
			["smgbody"] = 325,
			["riflebody"] = 425,
			["explosives"] = 55,
			["vote"] = 105,
			["chlorine"] = 35,
			["WEAPON_BRICK"] = 13,
			["WEAPON_NAIL_AMMO"] = 1,
			["whistle"] = 75,
			["sprays01"] = 355,
			["campfire"] = 375,
			["bucket"] = 15,
			["fertilizer"] = 185,
			["WEAPON_PENCIL"] = 5
		}
	},
	["Drinks"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["absolut"] = 15,
			["chandon"] = 15,
			["dewars"] = 15,
			["hennessy"] = 15,
			["cola"] = 15,
			["soda"] = 15,
			["fries"] = 15
		}
	},
	["Animals"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["cat"] = 7500,
			["hen"] = 7500,
			["husky"] = 7500,
			["pig"] = 7500,
			["poodle"] = 7500,
			["pug"] = 7500,
			["retriever"] = 7500,
			["rottweiler"] = 7500,
			["shepherd"] = 7500,
			["westy"] = 7500
		}
	},
	["Identity"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["identity"] = 4500,
			["cnh"] = 2200
		}
	},
	["Identity2"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["fidentity"] = 7500
		}
	},
	["Skinshop"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["rope"] = 875,
			["teddy"] = 75,
			["backpack"] = 2500,
			["WEAPON_SHOES"] = 25,
			["WEAPON_WALKINGSTICK"] = 115
		}
	},
	["Departament"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["hotdog"] = 15,
			["hamburger"] = 25,
			["cigarette"] = 10,
			["suitcase"] = 275,
			["protectorcase"] = 475,
			["lighter"] = 175,
			["sugar"] = 5,
			["ziplock"] = 5,
			["pokeball"] = 1000,
			["postit"] = 20,
			["notepad"] = 10,
			["cupholder"] = 3550,
			["emptybottle"] = 30,
			["rose"] = 25,
			["firecracker"] = 100,
			["chocolate"] = 15,
			["paper"] = 7,
			["silk"] = 5,
			["vape"] = 4750,
			["binoculars"] = 275
		}
	},
	["Eletronics"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["cellphone"] = 575,
			["radio"] = 975,
			["camera"] = 275,
			["notebook"] = 5775
		}
	},
	["Milk"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["milkbottle"] = 35
		}
	},
	["Mecanico"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["tyres"] = 375,
			["toolbox"] = 975,
			["advtoolbox"] = 1525,
			["WEAPON_CROWBAR"] = 725,
			["WEAPON_WRENCH"] = 725,
			["repairkit01"] = 975,
			["repairkit02"] = 1775,
			["repairkit03"] = 5725,
			["repairkit04"] = 9725,
			["graphite01"] = 7,
			["graphite02"] = 7,
			["graphite03"] = 7,
			["carjack"] = 375,
			["lockpick"] = 625,
			["lockpick2"] = 625,
			["adesive01"] = 175,
			["adesive02"] = 175,
			["adesive03"] = 175,
			["adesive04"] = 175,
			["adesive05"] = 175
		}
	},
	["Mecanico2"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["tyres"] = 185,
			["toolbox"] = 485,
			["advtoolbox"] = 765,
			["WEAPON_CROWBAR"] = 365,
			["WEAPON_WRENCH"] = 365,
			["repairkit01"] = 485,
			["repairkit02"] = 885,
			["repairkit03"] = 2865,
			["repairkit04"] = 4865,
			["graphite01"] = 3,
			["graphite02"] = 3,
			["graphite03"] = 3,
			["carjack"] = 187,
			["lockpick"] = 312,
			["lockpick2"] = 312
		}
	},
	["Oxy"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["oxy"] = 35
		}
	},
	["Pharmacy"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["medkit"] = 575,
			["bandage"] = 225,
			["gauze"] = 100,
			["analgesic"] = 125,
			["expectorant"] = 225
		}
	},
	["Paramedico"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["Permission"] = "Paramedico",
		["List"] = {
			["syringe"] = 2,
			["syringe01"] = 50,
			["syringe02"] = 50,
			["syringe03"] = 50,
			["syringe04"] = 50,
			["bandage"] = 115,
			["gauze"] = 100,
			["gdtkit"] = 20,
			["medkit"] = 575,
			["sinkalmy"] = 375,
			["analgesic"] = 125,
			["expectorant"] = 225,
			["ritmoneury"] = 475,
			["medicbag"] = 425
		}
	},
	["Ammunation"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["WEAPON_HATCHET"] = 975,
			["WEAPON_BAT"] = 975,
			["WEAPON_BATTLEAXE"] = 975,
			["WEAPON_GOLFCLUB"] = 975,
			["WEAPON_HAMMER"] = 975,
			["WEAPON_MACHETE"] = 975,
			["WEAPON_POOLCUE"] = 975,
			["WEAPON_STONE_HATCHET"] = 975,
			["WEAPON_KNUCKLE"] = 975,
			["WEAPON_KARAMBIT"] = 975,
			["WEAPON_KATANA"] = 975,
			["WEAPON_FLASHLIGHT"] = 975,
			["WEAPON_DILDOKNIFE"] = 365,
			["WEAPON_KYROSCHAIR"] = 655,
			["WEAPON_PICKAXE"] = 725,
			["GADGET_PARACHUTE"] = 225,
			["WEAPON_CROWBAR"] = 725,
			["WEAPON_WRENCH"] = 725
		}
	},
	["Premium"] = {
		["Mode"] = "Buy",
		["Type"] = "Premium",
		["List"] = {
			["gemstone"] = 1,
			["vote"] = 1,
			["premium"] = 20000,
			["premium2"] = 12000,
			["premium3"] = 6000,
			["premiumplate"] = 5000,
			["newchars"] = 7500,
			["namechange"] = 2000,
			["repairkit05"] = 2000,
			["backpackp"] = 2000,
			["backpackm"] = 3000,
			["backpackg"] = 4000,
			["fishingrodplus"] = 2500,
			["WEAPON_PICKAXE_PLUS"] = 2500,
			["WEAPON_THERMAL"] = 75,
			["chip"] = 500
		}
	},
	["Fishing"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["fishingrod"] = 725,
			["worm"] = 5
		}
	},
	["Fishing2"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["anchovy"] = 45,
			["catfish"] = 45,
			["herring"] = 50,
			["orangeroughy"] = 45,
			["salmon"] = 55,
			["sardine"] = 35,
			["smallshark"] = 100,
			["smalltrout"] = 40,
			["yellowperch"] = 45
		}
	},
	["Fruits"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["tomato"] = 10,
			["banana"] = 10,
			["guarana"] = 10,
			["acerola"] = 10,
			["passion"] = 10,
			["grape"] = 10,
			["tange"] = 10,
			["orange"] = 10,
			["apple"] = 10,
			["corn"] = 10,
			["strawberry"] = 10
		}
	},
	["Hunting"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["WEAPON_SWITCHBLADE"] = 725,
			["WEAPON_MUSKET_AMMO"] = 10,
			["ration"] = 125,
			["whistle"] = 125,
			["WEAPON_SAUER"] = 7225,
			["WEAPON_MUSKET"] = 3250
		}
	},
	["Hunting2"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["deer1star"] = 125,
			["deer2star"] = 175,
			["deer3star"] = 225,
			["coyote1star"] = 125,
			["coyote2star"] = 175,
			["coyote3star"] = 225,
			["boar1star"] = 125,
			["boar2star"] = 175,
			["boar3star"] = 225,
			["mtlion1star"] = 125,
			["mtlion2star"] = 175,
			["mtlion3star"] = 225
		}
	},
	["Hunting3"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["meat"] = 16,
			["animalpelt"] = 25,
			["animalfat"] = 10,
			["leather"] = 20
		}
	},
	["Recycle"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["notepad"] = 5,
			["plastic"] = 10,
			["glass"] = 10,
			["rubber"] = 10,
			["aluminum"] = 15,
			["copper"] = 15,
			["radio"] = 485,
			["titanium"] = 275,
			["rope"] = 435,
			["cellphone"] = 325,
			["binoculars"] = 135,
			["emptybottle"] = 15,
			["WEAPON_SWITCHBLADE"] = 215,
			["camera"] = 135,
			["recyclable"] = 5,
			["vape"] = 2375,
			["rose"] = 15,
			["lighter"] = 75,
			["newspaper"] = 12,
			["teddy"] = 35,
			["tyres"] = 100,
			["worm"] = 2,
			["firecracker"] = 50,
			["fishingrod"] = 365,
			["scuba"] = 485,
			["silvercoin"] = 10,
			["goldcoin"] = 20,
			["techtrash"] = 60,
			["tarp"] = 20,
			["sheetmetal"] = 20,
			["roadsigns"] = 20,
			["metalcan"] = 40,
			["plasticbottle"] = 20,
			["codeine"] = 15,
			["amphetamine"] = 20,
			["cotton"] = 20,
			["plaster"] = 15,
			["carjack"] = 285,
			["panties"] = 7,
			["alliancemale"] = 525,
			["alliancefemale"] = 525,
			["metalwire"] = 275
		}
	},
	["Miners"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["sapphire_pure"] = 80,
			["emerald_pure"] = 80,
			["ruby_pure"] = 80,
			["gold_pure"] = 70,
			["iron_pure"] = 50,
			["lead_pure"] = 50,
			["sulfur_pure"] = 50,
			["tin_pure"] = 50,
			["diamond_pure"] = 70,
			["copper_pure"] = 60
		}
	},
	["Coffee"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["coffee"] = 20
		}
	},
	["Soda"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["cola"] = 15,
			["soda"] = 15
		}
	},
	["Donut"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["donut"] = 15
		}
	},
	["Hamburger"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["hamburger"] = 25
		}
	},
	["Hotdog"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["hotdog"] = 15
		}
	},
	["Chihuahua"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["hotdog"] = 15,
			["hamburger"] = 25,
			["coffee"] = 20,
			["cola"] = 15,
			["soda"] = 15
		}
	},
	["Water"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["water"] = 30
		}
	},
	["Cigarette"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["cigarette"] = 10,
			["lighter"] = 175
		}
	},
	["Policia"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["Permission"] = "Policia",
		["List"] = {
			["vest"] = 100,
			["gsrkit"] = 10,
			["gdtkit"] = 10,
			["barrier"] = 25,
			["spike"] = 360,
			["handcuff"] = 125,
			["WEAPON_SMG"] = 1225,
			["WEAPON_PUMPSHOTGUN"] = 1225,
			["WEAPON_CARBINERIFLE"] = 1725,
			["WEAPON_STUNGUN"] = 725,
			["WEAPON_PISTOL"] = 5725,
			["WEAPON_COMBATPISTOL"] = 725,
			["WEAPON_HEAVYPISTOL"] = 925,
			["WEAPON_NIGHTSTICK"] = 375,
			["WEAPON_POLICE_AMMO"] = 2,
			["WEAPON_MOLOTOV"] = 75,
			["WEAPON_SMOKEGRENADE"] = 75,
			["ATTACH_FLASHLIGHT"] = 1750,
			["ATTACH_CROSSHAIR"] = 1750,
			["ATTACH_SILENCER"] = 1750,
			["ATTACH_MAGAZINE"] = 1750,
			["ATTACH_GRIP"] = 1750,
			["megaphone"] = 525,
			["lockpick2"] = 312,
			["vpn"] = 4225
		}
	},
	["Criminal"] = {
		["Mode"] = "Sell",
		["Type"] = "Illegal",
		["List"] = {
			["keyboard"] = 75,
			["mouse"] = 75,
			["playstation"] = 75,
			["xbox"] = 75,
			["dish"] = 75,
			["pan"] = 100,
			["fan"] = 75,
			["blender"] = 75,
			["switch"] = 45,
			["cup"] = 100,
			["lampshade"] = 75
		}
	},
	["Criminal2"] = {
		["Mode"] = "Sell",
		["Type"] = "Illegal",
		["List"] = {
			["watch"] = 75,
			["bracelet"] = 75,
			["spray01"] = 75,
			["spray02"] = 75,
			["spray03"] = 75,
			["spray04"] = 75,
			["slipper"] = 75,
			["rimel"] = 75,
			["brush"] = 75,
			["soap"] = 75
		}
	},
	["Criminal3"] = {
		["Mode"] = "Sell",
		["Type"] = "Illegal",
		["List"] = {
			["eraser"] = 75,
			["legos"] = 75,
			["ominitrix"] = 75,
			["dices"] = 45,
			["domino"] = 45,
			["floppy"] = 45,
			["horseshoe"] = 75,
			["deck"] = 75
		}
	},
	["Criminal4"] = {
		["Mode"] = "Sell",
		["Type"] = "Illegal",
		["List"] = {
			["goldbar"] = 525,
			["pliers"] = 55,
			["pager"] = 125,
			["card01"] = 325,
			["card02"] = 325,
			["card03"] = 375,
			["card04"] = 275,
			["card05"] = 425,
			["pendrive"] = 325
		}
	},
	["Criminal5"] = {
		["Mode"] = "Sell",
		["Type"] = "Illegal",
		["List"] = {
			["pistolbody"] = 425,
			["smgbody"] = 525,
			["riflebody"] = 625
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MALENAME
-----------------------------------------------------------------------------------------------------------------------------------------
local MaleName = { "James", "John", "Robert", "Michael", "William", "David", "Richard", "Charles", "Joseph", "Thomas", "Christopher", "Daniel", "Paul", "Mark", "Donald", "George", "Kenneth", "Steven", "Edward", "Brian", "Ronald", "Anthony", "Kevin", "Jason", "Matthew", "Gary", "Timothy", "Jose", "Larry", "Jeffrey", "Frank", "Scott", "Eric", "Stephen", "Andrew", "Raymond", "Gregory", "Joshua", "Jerry", "Dennis", "Walter", "Patrick", "Peter", "Harold", "Douglas", "Henry", "Carl", "Arthur", "Ryan", "Roger", "Joe", "Juan", "Jack", "Albert", "Jonathan", "Justin", "Terry", "Gerald", "Keith", "Samuel", "Willie", "Ralph", "Lawrence", "Nicholas", "Roy", "Benjamin", "Bruce", "Brandon", "Adam", "Harry", "Fred", "Wayne", "Billy", "Steve", "Louis", "Jeremy", "Aaron", "Randy", "Howard", "Eugene", "Carlos", "Russell", "Bobby", "Victor", "Martin", "Ernest", "Phillip", "Todd", "Jesse", "Craig", "Alan", "Shawn", "Clarence", "Sean", "Philip", "Chris", "Johnny", "Earl", "Jimmy", "Antonio" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- FEMALENAME
-----------------------------------------------------------------------------------------------------------------------------------------
local FemaleName = { "Mary", "Patricia", "Linda", "Barbara", "Elizabeth", "Jennifer", "Maria", "Susan", "Margaret", "Dorothy", "Lisa", "Nancy", "Karen", "Betty", "Helen", "Sandra", "Donna", "Carol", "Ruth", "Sharon", "Michelle", "Laura", "Sarah", "Kimberly", "Deborah", "Jessica", "Shirley", "Cynthia", "Angela", "Melissa", "Brenda", "Amy", "Anna", "Rebecca", "Virginia", "Kathleen", "Pamela", "Martha", "Debra", "Amanda", "Stephanie", "Carolyn", "Christine", "Marie", "Janet", "Catherine", "Frances", "Ann", "Joyce", "Diane", "Alice", "Julie", "Heather", "Teresa", "Doris", "Gloria", "Evelyn", "Jean", "Cheryl", "Mildred", "Katherine", "Joan", "Ashley", "Judith", "Rose", "Janice", "Kelly", "Nicole", "Judy", "Christina", "Kathy", "Theresa", "Beverly", "Denise", "Tammy", "Irene", "Jane", "Lori", "Rachel", "Marilyn", "Andrea", "Kathryn", "Louise", "Sara", "Anne", "Jacqueline", "Wanda", "Bonnie", "Julia", "Ruby", "Lois", "Tina", "Phyllis", "Norma", "Paula", "Diana", "Annie", "Lillian", "Emily", "Robin" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANDOMNAME
-----------------------------------------------------------------------------------------------------------------------------------------
local RandomName = { "Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson", "Clark", "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Young", "Hernandez", "King", "Wright", "Lopez", "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell", "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins", "Stewart", "Sanchez", "Morris", "Rogers", "Reed", "Cook", "Morgan", "Bell", "Murphy", "Bailey", "Rivera", "Cooper", "Richardson", "Cox", "Howard", "Ward", "Torres", "Peterson", "Gray", "Ramirez", "James", "Watson", "Brooks", "Kelly", "Sanders", "Price", "Bennett", "Wood", "Barnes", "Ross", "Henderson", "Coleman", "Jenkins", "Perry", "Powell", "Long", "Patterson", "Hughes", "Flores", "Washington", "Butler", "Simmons", "Foster", "Gonzales", "Bryant", "Alexander", "Russell", "Griffin", "Diaz", "Hayes" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Permission(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.GetTax(source) > NewBankMinTaxs then
			TriggerClientEvent("Notify",source,"amarelo","Você possúi muitos <b>Impostos Atrasados</b>.","Atenção",5000)
			return false
		end

		if List[Type] and List[Type]["Permission"] and not vRP.HasService(Passport,List[Type]["Permission"]) then
			return false
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Connecteds(Permission)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Service,Total = vRP.NumPermission(Permission)
		if Total == 0 then
			return true
		else
			TriggerClientEvent("Notify",source,"amarelo","Existem <b>"..Permission.."s</b> em serviço, você precisa procurar alguém para receber atendimento.","Atenção",5000)
		end

		return
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Request(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if List[Name] then
			local Shop = {}
			local Slots = 20
			for Index,v in pairs(List[Name]["List"]) do
				Shop[#Shop + 1] = { key = Index, price = parseInt(v), name = itemName(Index), index = itemIndex(Index), peso = itemWeight(Index) }
			end

			local Inventory = {}
			local Inv = vRP.Inventory(Passport)
			for Index,v in pairs(Inv) do
				v["amount"] = parseInt(v["amount"])
				v["peso"] = itemWeight(v["item"])
				v["index"] = itemIndex(v["item"])
				v["name"] = itemName(v["item"])
				v["key"] = v["item"]
				v["slot"] = Index

				v["desc"] = "<item>"..v["name"].."</item>"

				local Split = splitString(v["item"])
				local Description = itemDescription(v["item"])

				if Description then
					v["desc"] = v["desc"].."<br><description>"..Description.."</description>"
				else
					if Split[1] == "identity" or Split[1] == "fidentity" then
						local Number = parseInt(Split[2])
						local Identity = vRP.Identity(Number)

						if Split[1] == "fidentity" then
							Identity = vRP.FalseIdentity(Number)
						end

						if Identity then
							v["Port"] = "Não"
							v["Passport"] = Number
							v["Premium"] = "Inativo"
							v["Rolepass"] = "Inativo"
							v["Name"] = vRP.FullName(Number)
							v["Work"] = ClassWork(Identity["Work"])
							v["Blood"] = Sanguine(Identity["Blood"])

							if Identity["Gun"] == 1 then
								v["Port"] = "Sim"
							end

							if Number == Passport and Split[1] == "identity" then
								if Identity["Premium"] > os.time() then
									v["Premium"] = MinimalTimers(Identity["Premium"] - os.time())
								end

								if Identity["Rolepass"] > 0 then
									v["Rolepass"] = "Ativo"
								end
							end

							if Split[1] == "fidentity" then
								v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Tipo Sangüineo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.</description>"
							else
								v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Emprego: <green>"..v["Work"].."</green><br>Tipo Sangüineo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.<br>Passe Mensal: <green>"..v["Rolepass"].."</green>.<br>Premium: <green>"..v["Premium"].."</green>.</description>"
							end
						end
					end

					if Split[1] == "cnh" then
						local Number = parseInt(Split[2])
						local Identity = vRP.Identity(Number)
						if Identity then
							v["Passport"] = Number
							v["Driverlicense"] = "Inativa"
							v["Name"] = Identity["Name"].." "..Identity["Lastname"]

							if Number == Passport then
								if Identity["Driver"] == 1 then
									v["Driverlicense"] = "Ativa"
								elseif Identity["Driver"] == 2 then
									v["Driverlicense"] = "Apreendida"
								end
							end

							v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Habilitação: <green>"..v["Driverlicense"].."</green>.</description>"
						end
					end

					if Split[1] == "vehkey" then
						v["desc"] = v["desc"].."<br><description>Placa do Veículo: <green>"..Split[2].."</green>.</description>"
					end

					if Split[1] == "bankcard" then
						v["desc"] = v["desc"].."<br><description>Saldo bancário disponível: <green>$"..parseFormat(vRP.GetBank(source)).."</green>.</description>"
					end

					if Split[1] == "notepad" and Split[2] then
						v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
					end

					if Split[1] == "paper" and Split[2] then
						v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
					end

					if itemType(Split[1]) == "Armamento" and Split[3] then
						v["desc"] = v["desc"].."<br><description>Nome de registro: <green>"..vRP.FullName(Split[3]).."</green>.</description>"
					end

					if Split[1] == "evidence01" or Split[1] == "evidence02" or Split[1] == "evidence03" or Split[1] == "evidence04" and Split[2] then
						v["desc"] = v["desc"].."<br><description>Tipo sanguíneo encontrado: <green>"..Sanguine(vRP.Identity(Split[2])["Blood"]).."</green>.</description>"
					end

					if Split[1] == "weedclone" or Split[1] == "weedclone2" or Split[1] == "weedbud" or Split[1] == "joint" then
						local Item = "da clonagem"
						if Split[1] == "weedbud" then
							Item = "da folha"
						elseif Split[1] == "joint" then
							Item = "do baseado"
						end

						v["desc"] = v["desc"].."<br><description>A pureza "..Item.." se encontra em <green>"..(Split[2] or 0).."%</green>.</description>"
					end
				end

				local Max = itemMaxAmount(v["item"])
				if not Max then
					Max = "S/L"
				end

				v["desc"] = v["desc"].."<br><legenda>Economia: <r>"..itemEconomy(v["item"]).."</r> <s>|</s> Máximo: <r>"..Max.."</r></legenda>"

				if Split[2] then
					if itemCharges(v["item"]) then
						v["charges"] = parseInt(Split[2] * 33)
					end

					if itemDurability(v["item"]) then
						v["durability"] = parseInt(os.time() - Split[2])
						v["days"] = itemDurability(v["item"])
					end
				end

				Inventory[Index] = v
			end

			if parseInt(#Shop) > 20 then
				Slots = parseInt(#Shop)
			end

			return Shop,Inventory,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),Slots
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ShopType(Type)
	if List[Type] and List[Type]["Mode"] then
		return List[Type]["Mode"]
	end

	return "Buy"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.functionShops(Type,Item,Amount,Slot)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and List[Type] then
		if Amount > 1 and itemUnique(Item) then
			Amount = 1
		end

		local Inv = vRP.Inventory(Passport)
		if (Inv[Slot] and Inv[Slot]["item"] == Item) or not Inv[Slot] then
			if List[Type]["Mode"] == "Buy" then
				if vRP.MaxItens(Passport,Item,Amount) then
					TriggerClientEvent("Notify",source,"Aviso","Limite atingido.","amarelo",5000)
					vCLIENT.Update(source,"Request")

					return false
				end

				if (vRP.InventoryWeight(Passport) + itemWeight(Item) * Amount) <= vRP.GetWeight(Passport) then
					if List[Type]["Type"] == "Cash" then
						if List[Type]["List"][Item] then
							if vRP.PaymentFull(Passport,List[Type]["List"][Item] * Amount) then
								if itemType(Item) == "Armamento" then
									vRP.GiveItem(Passport,Item.."-"..os.time().."-"..Passport,1,false,Slot)

									if NewBankTaxs then
										exports["bank"]:AddTaxs(Passport,"Prefeitura",List[Type]["List"][Item] * Amount,"Registro de Armamento.")
									end
								elseif itemMode(Item) == "Chest" then
									vRP.GiveItem(Passport,Item.."-"..os.time().."-"..(math.random(1000,5000) + Passport),1,false,Slot)
								elseif Item == "identity" then
									vRP.GiveItem(Passport,Item.."-"..Passport,Amount,false,Slot)

									if NewBankTaxs then
										exports["bank"]:AddTaxs(Passport,"Prefeitura",List[Type]["List"][Item] * Amount,"Emissão de Identidade.")
									end
								elseif Item == "fidentity" then
									local Identity = vRP.Identity(Passport)
									if Identity then
										if Identity["Sex"] == "M" then
											vRP.Query("fidentity/NewIdentity",{ Name = MaleName[math.random(#MaleName)], Lastname = RandomName[math.random(#RandomName)], Blood = math.random(4) })
										else
											vRP.Query("fidentity/NewIdentity",{ Name = FemaleName[math.random(#FemaleName)], Lastname = RandomName[math.random(#RandomName)], Blood = math.random(4) })
										end

										local Consult = vRP.Query("fidentity/GetIdentity")
										if Consult[1] then
											vRP.GiveItem(Passport,Item.."-"..Consult[1]["id"],Amount,false,Slot)
										end
									end
								elseif Item == "cnh" then
									vRP.GiveItem(Passport,Item.."-"..Passport,Amount,false,Slot)

									if NewBankTaxs then
										exports["bank"]:AddTaxs(Passport,"Prefeitura",List[Type]["List"][Item] * Amount,"Emissão de Habilitação.")
									end
								else
									vRP.GenerateItem(Passport,Item,Amount,false,Slot)
								end

								TriggerClientEvent("sounds:Private",source,"cash",0.1)
							end
						end
					elseif List[Type]["Type"] == "Consume" then
						if vRP.TakeItem(Passport,List[Type]["Item"],parseInt(List[Type]["List"][Item] * Amount)) then
							vRP.GenerateItem(Passport,Item,Amount,false,Slot)
						else
							TriggerClientEvent("Notify",source,"amarelo","<b>"..itemName(List[Type]["Item"]).."</b> insuficiente.","Atenção",5000)
						end
					elseif List[Type]["Type"] == "Premium" then
						if vRP.PaymentGems(Passport,List[Type]["List"][Item] * Amount) then
							TriggerClientEvent("sounds:Private",source,"cash",0.1)

							if itemMode(Item) == "Chest" then
								vRP.GiveItem(Passport,Item.."-"..os.time().."-"..(math.random(1000,5000) + Passport),1,false,Slot)
							else
								vRP.GenerateItem(Passport,Item,Amount,false,Slot)
							end
						else
							TriggerClientEvent("Notify",source,"amarelo","<b>" .. itemName("gemstone") .. "</b> insuficientes.","Atenção",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
				end
			elseif List[Type]["Mode"] == "Sell" then
				local Split = splitString(Item)[1]

				if List[Type]["List"][Split] then
					local itemPrice = List[Type]["List"][Split]

					if itemPrice > 0 and vRP.CheckDamaged(Item) then
						TriggerClientEvent("Notify",source,"amarelo","Itens danificados não podem ser vendidos.","Atenção",5000)
						vCLIENT.Update(source,"Request")

						return false
					end

					if List[Type]["Type"] == "Cash" then
						if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
							if itemPrice > 0 then
								vRP.GenerateItem(Passport,"dollars",parseInt(itemPrice * Amount),false)
								TriggerClientEvent("sounds:Private",source,"cash",0.1)
							end
						end
					elseif List[Type]["Type"] == "Illegal" then
						if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
							if itemPrice > 0 then
								vRP.GenerateItem(Passport,"dollars2",parseInt(itemPrice * Amount),false)
								TriggerClientEvent("sounds:Private",source,"cash",0.1)
							end
						end
					elseif List[Type]["Type"] == "Consume" then
						if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
							if itemPrice > 0 then
								vRP.GenerateItem(Passport,List[Type]["Item"],parseInt(itemPrice * Amount),false)
							end
						end
					end
				end
			end
		end

		vCLIENT.Update(source,"Request")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
			vRP.GiveItem(Passport,Item,Amount,false,Target)
			vCLIENT.Update(source,"Request")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		local Inv = vRP.Inventory(Passport)
		if Inv[Slot] and Inv[Target] and Inv[Slot]["item"] == Inv[Target]["item"] then
			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				vRP.GiveItem(Passport,Item,Amount,false,Target)
			end
		else
			vRP.SwapSlot(Passport,Slot,Target)
		end

		vCLIENT.Update(source,"Request")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BUYOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:BuyOxigen")
AddEventHandler("shops:BuyOxigen",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source,"Loja de Oxigênio","Comprar a <b>"..itemName("scuba").."</b> pagando <b>$975</b>?") then
			if vRP.PaymentFull(Passport,975) then
				vRP.GenerateItem(Passport,"scuba",1,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BUYCYLINDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:BuyCylinder")
AddEventHandler("shops:BuyCylinder",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source,"Loja de Oxigênio","Comprar o <b>"..itemName("oxygencylinder").."</b> pagando <b>$2.550</b>?") then
			if vRP.PaymentFull(Passport,2550) then
				vRP.GenerateItem(Passport,"oxygencylinder",1,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BUYGASOLINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:BuyGasoline")
AddEventHandler("shops:BuyGasoline",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source,"Posto de Gasolina", "Comprar <b>1x "..itemName("WEAPON_PETROLCAN").."</b> com <b>4.500 Litros</b> pagando <b>$375 "..itemName("dollars").."</b>?") then
			if vRP.PaymentFull(Passport,375) then
				vRP.GenerateItem(Passport,"WEAPON_PETROLCAN",1,true)
				vRP.GenerateItem(Passport,"WEAPON_PETROLCAN_AMMO",4500,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SELLOIL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:SellOil")
AddEventHandler("shops:SellOil",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source,"Posto de Gasolina","Vender <b>1x "..itemName("oilgallon").."</b> por <b>$875 "..itemName("dollars").."</b>?") then
			if vRP.TakeItem(Passport,"oilgallon",1,true) then
				vRP.GenerateItem(Passport,"dollars",875,true)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem <b>1x "..itemName("oilgallon").."</b>.","Atenção",5000)
			end
		end
	end
end)