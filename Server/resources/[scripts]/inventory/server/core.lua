-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("inventory",Hensa)
vPLAYER = Tunnel.getInterface("player")
vGARAGE = Tunnel.getInterface("garages")
vCLIENT = Tunnel.getInterface("inventory")
vSURVIVAL = Tunnel.getInterface("survival")
vKEYBOARD = Tunnel.getInterface("keyboard")
vPARAMEDIC = Tunnel.getInterface("paramedic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Drops = {}
Drugs = {}
Carry = {}
Delay = {}
Ammos = {}
Loots = {}
Boxes = {}
Active = {}
Trashs = {}
Armors = {}
Plates = {}
Trunks = {}
Heroin = {}
Codeine = {}
Healths = {}
Whistle = {}
Animals = {}
Attachs = {}
TowList = {}
Pumpjack = {}
Electric = {}
Scanners = {}
Property = {}
Temporary = {}
AtmTimers = {}
Dismantle = {}
Registers = {}
Amphetamine = {}
TheftTimers = {}
RobberyType = {}
Electricity = {}
VerifyObjects = {}
VerifyAnimals = {}
InventoryTrash = {}
BoxVehiclesServer = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
Buffs = {
	["Dexterity"] = {},
	["Luck"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
Objects = {
	-- ROBBERY CLOTHESHOP
	["121"] = { x = 70.27, y = -1389.11, z = 29.13, h = 90.28, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["122"] = { x = -706.01, y = -150.49, z = 37.17, h = 28.61, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["123"] = { x = -167.66, y = -301.67, z = 39.49, h = 161.34, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["124"] = { x = -821.69, y = -1067.22, z = 11.08, h = 31.23, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["125"] = { x = -1186.62, y = -772.55, z = 17.09, h = 215.93, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["126"] = { x = -1446.85, y = -240.38, z = 49.57, h = 316.88, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["127"] = { x = 5.53, y = 6506.07, z = 31.63, h = 222.68, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["128"] = { x = 1699.51, y = 4819.72, z = 41.82, h = 277.02, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["129"] = { x = 117.83, y = -223.56, z = 54.31, h = 70.89, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["130"] = { x = 621.58, y = 2765.81, z = 41.84, h = 275.02, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["131"] = { x = 1200.46, y = 2715.37, z = 37.98, h = 0.24, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["132"] = { x = -3178.48, y = 1044.46, z = 20.62, h = 66.61, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["133"] = { x = -1102.05, y = 2716.93, z = 18.86, h = 40.85, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["134"] = { x = 430.72, y = -810.01, z = 29.25, h = 270.35, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- ROBBERY WEAPONSSHOP
	["135"] = { x = 1688.78, y = 3759.13, z = 34.46, h = 47.5, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["136"] = { x = 256.35, y = -47.51, z = 69.7, h = 249.76, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["137"] = { x = 846.13, y = -1036.62, z = 27.95, h = 178.74, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["138"] = { x = -335.18, y = 6083.29, z = 31.21, h = 45.57, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["139"] = { x = -665.98, y = -932.24, z = 21.58, h = 358.38, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["140"] = { x = -1301.93, y = -391.36, z = 36.45, h = 255.85, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["141"] = { x = -1122.59, y = 2698.25, z = 18.31, h = 42.82, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["142"] = { x = 2571.67, y = 291.28, z = 108.49, h = 180.02, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["143"] = { x = 2571.66, y = 291.29, z = 108.49, h = 181.06, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["144"] = { x = 19.57, y = -1103.0, z = 29.55, h = 339.07, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["145"] = { x = 813.92, y = -2160.34, z = 29.37, h = 179.33, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- ROBBERY BARBERSHOP
	["146"] = { x = -807.9, y = -180.83, z = 37.32, h = 299.3, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["147"] = { x = 139.56, y = -1704.12, z = 29.05, h = 320.25, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["148"] = { x = -1278.11, y = -1116.66, z = 6.75, h = 270.07, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["149"] = { x = 1928.89, y = 3734.04, z = 32.6, h = 29.2, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["150"] = { x = 1217.05, y = -473.45, z = 65.96, h = 255.89, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["151"] = { x = -34.08, y = -157.01, z = 56.83, h = 159.63, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["152"] = { x = -274.5, y = 6225.27, z = 31.45, h = 225.27, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- ROBBERY TATTOOSHOP
	["153"] = { x = 1327.98, y = -1654.78, z = 52.03, h = 218.71, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["154"] = { x = -1149.04, y = -1428.64, z = 4.71, h = 215.2, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["155"] = { x = 322.01, y = 186.24, z = 103.34, h = 339.28, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["156"] = { x = -3175.64, y = 1075.54, z = 20.58, h = 65.96, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["157"] = { x = 1866.01, y = 3748.07, z = 32.79, h = 299.38, object = "p_v_43_safe_s", item = "", Distance = 50 },
	["158"] = { x = -295.51, y = 6199.21, z = 31.24, h = 133.05, object = "p_v_43_safe_s", item = "", Distance = 50 },

	-- OTHER OBJECTS
	["9998"] = { x = -584.12, y = -1062.95, z = 22.38, h = 33.14, object = "bkr_prop_fakeid_clipboard_01a", item = "", Distance = 15 },
	["9999"] = { x = -1188.9, y = -897.82, z = 13.95, h = 130.04, object = "bkr_prop_fakeid_clipboard_01a", item = "", Distance = 15 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
Products = {
	["paper"] = {
		{ ["timer"] = 20, ["need"] = { { ["item"] = "woodlog", ["amount"] = 3 } }, ["needAmount"] = 1, ["item"] = "paper", ["itemAmount"] = 1 }
	},
	["tablecoke"] = {
		{ ["timer"] = 20, ["need"] = {
				{ ["item"] = "sulfuric", ["amount"] = 1 },
				{ ["item"] = "cokebud",  ["amount"] = 1 }
			}, ["needAmount"] = 1, ["item"] = "cocaine", ["itemAmount"] = 3
		}
	},
	["tablemeth"] = {
		{ ["timer"] = 20, ["need"] = {
				{ ["item"] = "saline",  ["amount"] = 1 },
				{ ["item"] = "acetone", ["amount"] = 1 }
			}, ["needAmount"] = 1, ["item"] = "meth", ["itemAmount"] = 3
		}
	},
	["tableweed"] = {
		{ ["timer"] = 20, ["need"] = {
				{ ["item"] = "silk",    ["amount"] = 1 },
				{ ["item"] = "weedbud", ["amount"] = 1 }
			}, ["needAmount"] = 1, ["item"] = "joint", ["itemAmount"] = 1
		}
	},
	["milkBottle"] = {
		{ ["timer"] = 30, ["need"] = "emptybottle", ["needAmount"] = 1, ["item"] = "milkbottle", ["itemAmount"] = 1 }
	},
	["scanner"] = {
		{ ["timer"] = 30, ["item"] = "sheetmetal", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "roadsigns", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "syringe", ["itemAmount"] = 3 },
		{ ["timer"] = 30, ["item"] = "fishingrod", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "plate", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "aluminum", ["itemAmount"] = 3 },
		{ ["timer"] = 30, ["item"] = "copper", ["itemAmount"] = 3 },
		{ ["timer"] = 30, ["item"] = "lighter", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "battery", ["itemAmount"] = 1 },
		{ ["timer"] = 30, ["item"] = "metalcan", ["itemAmount"] = 1 }
	},
	["fishfillet"] = {
		{ ["timer"] = 10, ["need"] = "fishfillet", ["needAmount"] = 1, ["item"] = "cookedfishfillet", ["itemAmount"] = 1 }
	},
	["marshmallow"] = {
		{ ["timer"] = 10, ["need"] = "sugar", ["needAmount"] = 4, ["item"] = "marshmallow", ["itemAmount"] = 1 }
	},
	["animalmeat"] = {
		{ ["timer"] = 10, ["need"] = "meat", ["needAmount"] = 1, ["item"] = "cookedmeat", ["itemAmount"] = 1 }
	},
	["emptybottle"] = {
		{ ["timer"] = 10, ["need"] = "emptybottle", ["needAmount"] = 1, ["item"] = "water", ["itemAmount"] = 1 }
	},
	["packagebox"] = {
		{ ["timer"] = 5, ["item"] = "packagebox", ["itemAmount"] = 1 }
	},
	["laundry"] = {
		{ ["timer"] = 60, ["need"] = "dollars2", ["needAmount"] = 1000, ["item"] = "dollars", ["itemAmount"] = 1000 }
	},
	["foodjuice"] = {
		{ ["timer"] = 10, ["item"] = "foodjuice", ["itemAmount"] = 1 }
	},
	["foodburger"] = {
		{ ["timer"] = 10, ["item"] = "foodburger", ["itemAmount"] = 1 }
	},
	["foodbox"] = {
		{ ["timer"] = 10, ["need"] = {
			{ ["item"] = "foodburger", ["amount"] = 1 },
			{ ["item"] = "foodjuice", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "foodbox", ["itemAmount"] = 1 }
	},
	["foodboxtoy"] = {
		{ ["timer"] = 10, ["need"] = {
				{ ["item"] = "drugtoy", ["amount"] = 1 }
			}, ["needAmount"] = 1, ["item"] = "foodboxtoy", ["itemAmount"] = 1
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
StealPeds = {
	{ ["Item"] = "dollars2", ["Min"] = 150, ["Max"] = 225 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALITENS
-----------------------------------------------------------------------------------------------------------------------------------------
StealItens = {
	{ ["Item"] = "dollars2", ["Min"] = 150, ["Max"] = 225 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MICROSCOPE
-----------------------------------------------------------------------------------------------------------------------------------------
Microscope = {
	{ 482.95,-988.61,30.68 },
	{ 312.47,-562.1,43.29 },
	{ 368.33,-1592.01,25.44 },
	{ 1772.18,2577.82,45.73 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Inventory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if GetPlayerRoutingBucket(source) < 900000 then
			if vRP.CheckRolepass(source) then
				TriggerEvent("vRP:Rewards",source)
			end
		end

		local Inventory = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			if (parseInt(v["amount"]) <= 0 or not itemBody(v["item"])) then
				vRP.RemoveItem(Passport,v["item"],parseInt(v["amount"]),false)
			else
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

					if Split[1] == "medicpass" and Split[2] then
						v["desc"] = v["desc"].."<br><description>Documento de: <green>"..vRP.FullName(Split[2]).."</green>.</description>"
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
		end

		return Inventory,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEND
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Send(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and not exports["hud"]:Wanted(Passport) then
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			Active[Passport] = os.time() + 100

			local Inv = vRP.Inventory(Passport)
			if not Inv[Slot] or not Inv[Slot]["item"] then
				Active[Passport] = nil

				return
			end

			local Item = Inv[Slot]["item"]
			if vRP.CheckDamaged(Item) or itemBlock(Item) then
				Active[Passport] = nil

				return
			end

			local OtherPassport = vRP.Passport(ClosestPed)
			if not vRP.MaxItens(OtherPassport,Item,Amount) then
				if (vRP.InventoryWeight(OtherPassport) + itemWeight(Item) * Amount) <= vRP.GetWeight(OtherPassport) then
					Active[Passport] = os.time() + 3
					Player(source)["state"]["Cancel"] = true
					Player(source)["state"]["Buttons"] = true
					Player(ClosestPed)["state"]["Cancel"] = true
					Player(ClosestPed)["state"]["Buttons"] = true
					vRPC.CreateObjects(source,"mp_safehouselost@","package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							vRPC.Destroy(source)
							Active[Passport] = nil
							Player(source)["state"]["Cancel"] = false
							Player(source)["state"]["Buttons"] = false
							Player(ClosestPed)["state"]["Cancel"] = false
							Player(ClosestPed)["state"]["Buttons"] = false

							if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
								vRP.GiveItem(OtherPassport,Item,Amount,true)
								TriggerClientEvent("inventory:Update",source,"Backpack")
								TriggerClientEvent("inventory:Update",ClosestPed,"Backpack")
							end
						end

						Wait(100)
					until not Active[Passport]
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Limite atingido.","Aviso",5000)
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Destroy(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not exports["hud"]:Wanted(Passport) then
			if (not InventoryTrash[Passport] or os.time() > InventoryTrash[Passport]) then
				local Inventory = vRP.Inventory(Passport)
				if not Inventory[Slot] or not Inventory[Slot]["item"] then
					Active[Passport] = nil

					return
				end

				local Item = Inventory[Slot]["item"]
				if not itemBlock(Item) then
					TriggerClientEvent("inventory:Close", source)

					if vRP.Request(source, "Mochila", "Realmente deseja destruir <b>"..parseFormat(Amount).."x "..itemName(Item).."</b>?") then
						InventoryTrash[Passport] = os.time() + 30
						vRP.RemoveItem(Passport, Item, Amount, true)

						exports["vrp"]:Embed("Inventory","**Passaporte:** "..Passport.."\n**Destruiu:** "..itemName(Item).." **Quantidade:** "..parseFormat(Amount),0xa3c846)
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Este item é indestrutível.", "Aviso", 5000)
				end
			else
				local Timer = parseInt(InventoryTrash[Passport] - os.time())
				TriggerClientEvent("Notify", source, "azul", "Aguarde <b>"..Timer.."</b> segundos.", false, 5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você está sendo procurado e não pode destruir itens.", "Atenção", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Deliver(Work)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = os.time() + 100

		if Work == "Lumberman" then
			if not vRPC.LastVehicle(source,"ratloader") then
				TriggerClientEvent("Notify",source,"amarelo","Precisa utilizar o veículo do <b>Lenhador</b>.","Atenção",5000)
				Active[Passport] = nil

				return false
			end

			local LumbermanRandom = math.random(5)
			if vRP.TakeItem(Passport,"woodlog",LumbermanRandom,true,Slot) then
				local Experience = vRP.GetExperience(Passport,"Lumberman")
				local Level = ClassCategory(Experience)
				local Valuation = 150

				if Level == 2 or Level == 3 then
					Valuation = Valuation + 30
				elseif Level == 4 or Level == 5 then
					Valuation = Valuation + 35
				elseif Level == 6 or Level == 7 then
					Valuation = Valuation + 40
				elseif Level == 8 or Level == 9 then
					Valuation = Valuation + 45
				elseif Level == 10 then
					Valuation = Valuation + 50
				end

				local Members = exports["vrp"]:Party(Passport,source,10)
				if parseInt(#Members) >= 2 then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				vRP.PaymentService(Passport,Valuation,vRP.Identity(Passport)["Mode"],true)
				vRP.PutExperience(Passport,"Lumberman",1)
				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>"..LumbermanRandom.."x "..itemName("woodlog").."</b>.", "Atenção", 5000)
			end
		elseif Work == "Transporter" then
			if not vRPC.LastVehicle(source,"stockade") then
				TriggerClientEvent("Notify",source,"amarelo","Precisa utilizar o veículo do <b>Transportador</b>.","Atenção",5000)
				Active[Passport] = nil

				return false
			end

			local TransporterRandom = math.random(3)
			if vRP.TakeItem(Passport,"pouch",TransporterRandom,true,Slot) then
				local Experience = vRP.GetExperience(Passport,"Transporter")
				local Level = ClassCategory(Experience)
				local Valuation = 75

				if Level == 2 or Level == 3 then
					Valuation = Valuation + 20
				elseif Level == 4 or Level == 5 then
					Valuation = Valuation + 25
				elseif Level == 6 or Level == 7 then
					Valuation = Valuation + 30
				elseif Level == 8 or Level == 9 then
					Valuation = Valuation + 35
				elseif Level == 10 then
					Valuation = Valuation + 40
				end

				local Members = exports["vrp"]:Party(Passport,source,10)
				if parseInt(#Members) >= 2 then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				vRP.PaymentService(Passport,Valuation,vRP.Identity(Passport)["Mode"],true)
				vRP.PutExperience(Passport,"Transporter",1)
				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>"..TransporterRandom.."x "..itemName("pouch").."</b>.", "Atenção", 5000)
			end
		elseif Work == "Burgershot" then
			if vRP.TakeItem(Passport,"foodbox",1,true,Slot) then
				local Experience = vRP.GetExperience(Passport,"Delivery")
				local Level = ClassCategory(Experience)
				local Valuation = 140

				if Level == 2 or Level == 3 then
					Valuation = Valuation + 20
				elseif Level == 4 or Level == 5 then
					Valuation = Valuation + 30
				elseif Level == 6 or Level == 7 then
					Valuation = Valuation + 40
				elseif Level == 8 or Level == 9 then
					Valuation = Valuation + 50
				elseif Level == 10 then
					Valuation = Valuation + 60
				end

				local Members = exports["vrp"]:Party(Passport,source,10)
				if parseInt(#Members) >= 2 then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				vRP.PaymentService(Passport,Valuation,vRP.Identity(Passport)["Mode"],true)
				vRP.PutExperience(Passport,"Delivery",1)
				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..itemName("foodbox").."</b>.", "Atenção", 5000)
			end
		elseif Work == "Milkman" then
			local MilkmanRandom = math.random(2,4)
			if vRP.TakeItem(Passport,"milkbottle",MilkmanRandom,true,Slot) then
				local Experience = vRP.GetExperience(Passport,"Delivery")
				local Level = ClassCategory(Experience)
				local Valuation = 75

				if Level == 2 or Level == 3 then
					Valuation = Valuation + 20
				elseif Level == 4 or Level == 5 then
					Valuation = Valuation + 25
				elseif Level == 6 or Level == 7 then
					Valuation = Valuation + 30
				elseif Level == 8 or Level == 9 then
					Valuation = Valuation + 35
				elseif Level == 10 then
					Valuation = Valuation + 40
				end

				local Members = exports["vrp"]:Party(Passport,source,10)
				if parseInt(#Members) >= 2 then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				vRP.PaymentService(Passport,Valuation,vRP.Identity(Passport)["Mode"],true)
				vRP.PutExperience(Passport,"Delivery",1)
				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>"..MilkmanRandom.."x "..itemName("milkbottle").."</b>.", "Atenção", 5000)
			end
		elseif Work == "Ballas" then
			local ItemName = itemName(BallasItem)
			local ItemPrice = itemPrice(BallasItem)

			if vRP.TakeItem(Passport,BallasItem,1,true,Slot) then
				vRP.GangBank("Add", ItemPrice, "Ballas")
				TriggerClientEvent("Notify", source, "verde", "Adicionado <b>$"..parseFormat(ItemPrice).."</b> ao cofre dos <b>"..Work.."</b>.", "Sucesso", 5000)

				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..ItemName.."</b>.", "Atenção", 5000)
			end
		elseif Work == "Families" then
			local ItemName = itemName(FamiliesItem)
			local ItemPrice = itemPrice(FamiliesItem)

			if vRP.TakeItem(Passport,FamiliesItem,1,true,Slot) then
				vRP.GangBank("Add", ItemPrice, "Families")
				TriggerClientEvent("Notify", source, "verde", "Adicionado <b>$"..parseFormat(ItemPrice).."</b> ao cofre dos <b>"..Work.."</b>.", "Sucesso", 5000)

				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..ItemName.."</b>.", "Atenção", 5000)
			end
		elseif Work == "Vagos" then
			local ItemName = itemName(VagosItem)
			local ItemPrice = itemPrice(VagosItem)

			if vRP.TakeItem(Passport,VagosItem,1,true,Slot) then
				vRP.GangBank("Add", ItemPrice, "Vagos")
				TriggerClientEvent("Notify", source, "verde", "Adicionado <b>$"..parseFormat(ItemPrice).."</b> ao cofre dos <b>"..Work.."</b>.", "Sucesso", 5000)
				
				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..ItemName.."</b>.", "Atenção", 5000)
			end
		elseif Work == "Aztecas" then
			local ItemName = itemName(AztecasItem)
			local ItemPrice = itemPrice(AztecasItem)

			if vRP.TakeItem(Passport,AztecasItem,1,true,Slot) then
				vRP.GangBank("Add", ItemPrice, "Aztecas")
				TriggerClientEvent("Notify", source, "verde", "Adicionado <b>$"..parseFormat(ItemPrice).."</b> ao cofre dos <b>"..Work.."</b>.", "Sucesso", 5000)

				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..ItemName.."</b>.", "Atenção", 5000)
			end
		elseif Work == "Bloods" then
			local ItemName = itemName(BloodsItem)
			local ItemPrice = itemPrice(BloodsItem)

			if vRP.TakeItem(Passport,BloodsItem,1,true,Slot) then
				vRP.GangBank("Add", ItemPrice, "Bloods")
				TriggerClientEvent("Notify", source, "verde", "Adicionado <b>$"..parseFormat(ItemPrice).."</b> ao cofre dos <b>"..Work.."</b>.", "Sucesso", 5000)

				Active[Passport] = nil

				return true
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..ItemName.."</b>.", "Atenção", 5000)
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WATERS
-----------------------------------------------------------------------------------------------------------------------------------------
local Waters = {
	["soap"] = true,
	["fishingrod"] = true,
	["fishingrodplus"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Use(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if Amount <= 0 then Amount = 1 end

		local Inventory = vRP.Inventory(Passport)
		if not Inventory[Slot] or not Inventory[Slot]["item"] then
			return
		end

		local Split = splitString(Inventory[Slot]["item"], "-")
		local Full = Inventory[Slot]["item"]
		local Item = Split[1]

		if Player(source)["state"]["Handcuff"] and Item ~= "lockpick" then
			return
		end

		if itemDurability(Full) and vRP.CheckDamaged(Full) then
			TriggerClientEvent("Notify",source,"amarelo","<b>"..itemName(Item).."</b> danificado.","Atenção",5000)
			return
		end

		if Item ~= "rope" or Item ~= "soap" then
			if (Waters[Item] and not vCLIENT.Water(source)) then
				TriggerClientEvent("Notify", source, "amarelo", "Use <b>"..parseFormat(Amount).."x "..itemName(Item).."</b> na água.", "Atenção", 5000)
				return
			elseif (not Waters[Item] and vCLIENT.Water(source)) then
				return
			end
		end

		if itemType(Full) == "Armamento" and parseInt(Slot) <= 5 and not Player(source)["state"]["Safezone"] then
			if vRPC.InsideVehicle(source) and not itemVehicle(Full) then
				return
			end

			if vCLIENT.CheckArms(source) then
				TriggerClientEvent("Notify",source,"vermelho","Mão machucada.","Aviso",5000)
				return
			end

			if vCLIENT.ReturnWeapon(source) then
				local Check,AmmoClip,Weapon = vCLIENT.StoreWeapon(source)

				if Check then
					local Ammunation = itemAmmo(Weapon)
					if Ammunation then
						if AmmoClip > 0 then
							if not Ammos[Passport] then
								Ammos[Passport] = {}
							end

							Ammos[Passport][Ammunation] = AmmoClip
						else
							if Ammos[Passport] and Ammos[Passport][Ammunation] then
								Ammos[Passport][Ammunation] = nil
							end
						end
					end

					TriggerClientEvent("NotifyItens",source,{ "-",itemIndex(Weapon),1,itemName(Weapon) })
					exports["inventory"]:CleanWeapons(Passport,false)
				end
			else
				local Attach = {}
				local AmmoClip = 0
				local Ammunation = itemAmmo(Item)
				if Ammunation then
					if Ammos[Passport] and Ammos[Passport][Ammunation] then
						AmmoClip = Ammos[Passport][Ammunation]
					end
				end

				if vCLIENT.ExistAttachs(source,Item) then
					if Attachs[Passport] and Attachs[Passport][Item] then
						Attach = Attachs[Passport][Item]
					end
				end

				if vCLIENT.TakeWeapon(source,Item,AmmoClip,Attach) then
					TriggerClientEvent("NotifyItens",source,{ "+",itemIndex(Full),1,itemName(Full) })
				end
			end
		elseif itemType(Full) == "Munição" then
			local Check,AmmoClip,Weapon = vCLIENT.InfoWeapon(source,Item)

			if Check then
				if Weapon == "WEAPON_PETROLCAN" or Weapon == "WEAPON_FIREEXTINGUISHER" then
					if (AmmoClip + Amount) > 4500 then
						Amount = 4500 - AmmoClip
					end
				else
					if (AmmoClip + Amount) > 250 then
						Amount = 250 - AmmoClip
					end
				end

				if Item ~= itemAmmo(Weapon) or Amount <= 0 then
					return
				end

				if vRP.TakeItem(Passport,Full,Amount,false,Slot) then
					if not Ammos[Passport] then
						Ammos[Passport] = {}
					end

					Ammos[Passport][Item] = AmmoClip + Amount

					TriggerClientEvent("NotifyItens",source,{ "+",itemIndex(Full),Amount,itemName(Full) })
					TriggerClientEvent("inventory:Update",source,"Backpack")
					vCLIENT.Reloading(source,Weapon,Amount)
				end
			end
		elseif itemType(Full) == "Throwing" then
			if vCLIENT.ReturnWeapon(source) then
				local Check,AmmoClip,Weapon = vCLIENT.StoreWeapon(source)

				if Check then
					local Amunnation = itemAmmo(Weapon)
					if Amunnation then
						if AmmoClip > 0 then
							if not Ammos[Passport] then
								Ammos[Passport] = {}
							end

							Ammos[Passport][Amunnation] = AmmoClip
						else
							if Ammos[Passport] and Ammos[Passport][Amunnation] then
								Ammos[Passport][Amunnation] = nil
							end
						end
					end

					TriggerClientEvent("NotifyItens",source,{ "-",itemIndex(Weapon),1,itemName(Weapon) })
					exports["inventory"]:CleanWeapons(Passport,false)
				end
			else
				if vCLIENT.TakeWeapon(source,Item,1,nil,Full) then
					TriggerClientEvent("NotifyItens",source,{ "+",itemIndex(Full),1,itemName(Full) })
				end
			end
		elseif Item == "ATTACH_FLASHLIGHT" or Item == "ATTACH_CROSSHAIR" or Item == "ATTACH_SILENCER" or Item == "ATTACH_MAGAZINE" or Item == "ATTACH_GRIP" then
			local Weapon = vCLIENT.ReturnWeapon(source)
			if Weapon then
				if vCLIENT.CheckAttachs(source,Item,Weapon) then
					if not Attachs[Passport] then
						Attachs[Passport] = {}
					end

					if not Attachs[Passport][Weapon] then
						Attachs[Passport][Weapon] = {}
					end

					if not Attachs[Passport][Weapon][Item] then
						if vRP.TakeItem(Passport,Full,1,false,Slot) then
							TriggerClientEvent("NotifyItens",source,{ "+",itemIndex(Full),1,itemName(Full) })
							TriggerClientEvent("inventory:Update",source,"Backpack")
							Attachs[Passport][Weapon][Item] = true
							vCLIENT.Attachs(source,Item,Weapon)
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","O armamento já possui um componente equipado.","Atenção",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","O armamento já possui um componente equipado.","Atenção",5000)
				end
			end
		elseif Use[Item] then
			Use[Item](source,Passport,Amount,Slot,Full,Item,Split)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SAVETEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:saveTemporary",function(Passport)
	exports["inventory"]:CleanWeapons(Passport,false)

	if not Temporary[Passport] and Ammos[Passport] and Attachs[Passport] then
		Temporary[Passport] = {
			["Ammos"] = Ammos[Passport],
			["Attachs"] = Attachs[Passport]
		}

		Attachs[Passport] = {
			["WEAPON_COMBATPISTOL"] = {
				["ATTACH_FLASHLIGHT"] = true
			},
			["WEAPON_PISTOL_MK2"] = {
				["ATTACH_FLASHLIGHT"] = true,
				["ATTACH_CROSSHAIR"] = true
			}
		}

		Ammos[Passport] = {
			["WEAPON_PISTOL_AMMO"] = 250
		}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYTEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:applyTemporary", function(Passport)
	exports["inventory"]:CleanWeapons(Passport, true)

	if Temporary[Passport] and Ammos[Passport] and Attachs[Passport] then
		Attachs[Passport] = Temporary[Passport]["Attachs"]
		Ammos[Passport] = Temporary[Passport]["Ammos"]
		Temporary[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Cancel()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] ~= nil then
			Active[Passport] = nil

			vGARAGE.UpdateHotwired(source, false)
			Player(source)["state"]["Buttons"] = false
			TriggerClientEvent("Progress", source, "Cancelando", 1000)

			if VerifyObjects[Passport] then
				local Model = VerifyObjects[Passport][1]
				local Hash = VerifyObjects[Passport][2]

				if Trashs[Model] then
					if Trashs[Model][Hash] then
						Trashs[Model][Hash] = nil
					end
				end

				if Pumpjack[Model] then
					if Pumpjack[Model][Hash] then
						Pumpjack[Model][Hash] = nil
					end
				end

				VerifyObjects[Passport] = nil
			end

			if VerifyAnimals[Passport] then
				local Model = VerifyAnimals[Passport][1]

				if Animals[Model] then
					local netObjects = VerifyAnimals[Passport][2]

					if Animals[Model][netObjects] then
						Animals[Model][netObjects] = Animals[Model][netObjects] - 1
						VerifyAnimals[Passport] = nil
					end
				end
			end

			if Loots[Passport] then
				local myLoots = Loots[Passport]

				if Boxes[myLoots] then
					if Boxes[myLoots][Passport] then
						Boxes[myLoots][Passport] = nil
					end
				end

				Loots[Passport] = nil
			end
		end

		if Carry[Passport] then
			if vRP.Passport(Carry[Passport]) then
				TriggerClientEvent("inventory:Carry",Carry[Passport],nil,"Detach")
				Player(Carry[Passport])["state"]["Carry"] = false
				vRPC.Destroy(Carry[Passport])
			end
	
			Carry[Passport] = nil
		end

		if Scanners[Passport] then
			TriggerClientEvent("inventory:updateScanner", source, false)
			TriggerClientEvent("inventory:ScannerBlips", source)

			Player(source)["state"]["Buttons"] = false
			Player(source)["state"]["Scanner"] = false

			Scanners[Passport] = nil
		end

		if Player(source)["state"]["Camera"] then
			TriggerClientEvent("inventory:Camera", source)
		end

		if GetPlayerRoutingBucket(source) > 900000 then
			TriggerEvent("arena:Cancel", source, Passport)
		end

		vRPC.Destroy(source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.VerifyWeapon(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not vRP.ConsultItem(Passport,Item,1) then
		local Ammunation = itemAmmo(Item)
		if Ammunation and Ammos[Passport] and Ammos[Passport][Ammunation] then
			if Ammo and Ammo > 0 then
				Ammos[Passport][Ammunation] = Ammo
			end

			if Ammos[Passport][Ammunation] > 0 then
				vRP.GenerateItem(Passport,Ammunation,Ammos[Passport][Ammunation])
				Ammos[Passport][Ammunation] = nil
			end
		end

		if Attachs[Passport] and Attachs[Passport][Item] then
			for Component,_ in pairs(Attachs[Passport][Item]) do
				vRP.GenerateItem(Passport,Component,1)
			end

			Attachs[Passport][Item] = nil
		end

		TriggerClientEvent("inventory:Update",source,"Backpack")
		exports["inventory"]:CleanWeapons(Passport,false)

		return false
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKEXISTWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckExistWeapons(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item and not vRP.ConsultItem(Passport,Item,1) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETHROWING
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.RemoveThrowing(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item ~= nil then
		vRP.TakeItem(Passport,Item,1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVENTWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PreventWeapons(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Ammos[Passport] then
		local Ammunation = itemAmmo(Item)

		if Ammunation and Ammos[Passport][Ammunation] then
			if Ammo > 0 then
				Ammos[Passport][Ammunation] = Ammo
			else
				Ammos[Passport][Ammunation] = nil
				exports["inventory"]:CleanWeapons(Passport,false)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.VerifyObjects(Entity,Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if Service == "Parkimeter" then
			local ConsultNails = vRP.InventoryItemAmount(Passport, "WEAPON_NAIL_AMMO")
			if ConsultNails[1] <= 0 then
				TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..itemName("WEAPON_NAIL_AMMO").."</b>.","Atenção",5000)
				return
			end
		elseif Service == "Electric" then
			if not vCLIENT.CheckWeapon(source, "WEAPON_CROWBAR") then
				TriggerClientEvent("Notify",source,"amarelo","Você precisa colocar o <b>"..itemName("WEAPON_CROWBAR").."</b> em mãos.","Atenção",5000)
				return
			end
		elseif Service == "Pumpjack" then
			if not vCLIENT.CheckWeapon(source, "WEAPON_CROWBAR") then
				TriggerClientEvent("Notify",source,"amarelo","Você precisa colocar o <b>"..itemName("WEAPON_CROWBAR").."</b> em mãos.","Atenção",5000)
				return
			end
		elseif Service == "Gasoline" then
			if not vCLIENT.CheckWeapon(source, "WEAPON_PETROLCAN") then
				TriggerClientEvent("Notify",source,"amarelo","Você precisa colocar o <b>"..itemName("WEAPON_PETROLCAN").."</b> em mãos.","Atenção",5000)
				return
			end
		elseif vRP.GetWork(Passport) == "Garbageman" and Service == "Lixeiro" then
			if not vRPC.LastVehicle(source, "trash") then
				TriggerClientEvent("Notify",source,"amarelo","Você trabalha para a companhia de reciclagem, e para vasculhar as lixeiras você precisa estar com o veículo do emprego de <b>"..ClassWork("Garbageman").."</b>.","Atenção",5000)
				return
			end
		end

		if Entity[1] ~= nil and Entity[2] ~= nil and Entity[4] ~= nil then
			local Hash = Entity[1]
			local Model = Entity[2]
			local Coords = Entity[4]

			if not VerifyObjects[Passport] then
				if not Trashs[Model] then
					Trashs[Model] = {}
				end

				if not Pumpjack[Model] then
					Pumpjack[Model] = {}
				end

				if not Electric[Model] then
					Electric[Model] = {}
				end

				for k,v in pairs(Trashs[Model]) do
					if #(v["Coords"] - Coords) <= 0.75 and os.time() <= v["timer"] then
						local Cooldown = MinimalTimers(v["timer"] - os.time())
						TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
						return
					end
				end

				for k,v in pairs(Pumpjack[Model]) do
					if #(v["Coords"] - Coords) <= 0.75 and os.time() <= v["timer"] then
						local Cooldown = MinimalTimers(v["timer"] - os.time())
						TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
						return
					end
				end

				for k,v in pairs(Electric[Model]) do
					if #(v["Coords"] - Coords) <= 0.75 and os.time() <= v["timer"] then
						local Cooldown = MinimalTimers(v["timer"] - os.time())
						TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
						return
					end
				end

				if Service == "Parkimeter" then
					vRP.RemoveItem(Passport, "WEAPON_NAIL_AMMO", 1, true)
				end

				if Service == "CarWreck" then
					Active[Passport] = os.time() + 30
					TriggerClientEvent("Progress", source, "Vasculhando", 30000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
				elseif Service == "Pumpjack" then
					Active[Passport] = os.time() + 60
					TriggerClientEvent("vRP:Explosion", source, Coords)
					TriggerClientEvent("Progress", source, "Roubando", 60000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					local Service = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo de Petróleo", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 44 })
						end)
					end
				elseif Service == "Electric" then
					Active[Passport] = os.time() + 30
					TriggerClientEvent("Progress", source, "Roubando", 30000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
				elseif Service == "Gasoline" then
					Active[Passport] = os.time() + 60
					TriggerClientEvent("Progress", source, "Roubando", 60000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					SetTimeout(50000, function()
						vRPC.PlaySound(source, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS")

						local Service = vRP.NumPermission("Policia")
						for Passports, Sources in pairs(Service) do
							async(function()
								TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo de Gasolina", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 44 })
							end)
						end
					end)
				elseif Service == "Bricks" then
					Active[Passport] = os.time() + 30
					TriggerClientEvent("Progress", source, "Vasculhando", 30000)
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					local Service = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo de Materiais", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 44 })
						end)
					end
				else
					Active[Passport] = os.time() + 10
					TriggerClientEvent("Progress", source, "Vasculhando", 10000)
					vRPC.PlayAnim(source, false, { "amb@prop_human_bum_bin@base", "base" }, true)
				end

				VerifyObjects[Passport] = { Model, Hash }
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close", source)

				if Service == "Pumpjack" then
					Pumpjack[Model][Hash] = { ["Coords"] = Coords, ["timer"] = os.time() + 7200 }
				elseif Service == "Electric" then
					Electric[Model][Hash] = { ["Coords"] = Coords, ["timer"] = os.time() + 7200 }
				else
					Trashs[Model][Hash] = { ["Coords"] = Coords, ["timer"] = os.time() + 3600 }
				end

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.StopAnim(source, false)
						Player(source)["state"]["Buttons"] = false

						local itemSelect = { "", 1 }

						if Service == "Lixeiro" then
							local Experience = vRP.GetExperience(Passport, "Garbageman")
							local Level = ClassCategory(Experience)
							local Valuation = math.random(1,3)
							local DefaultLevel = 1

							if Level == 4 or Level == 5 then
								Valuation = Valuation + math.random(2)
							elseif Level == 6 or Level == 7 then
								Valuation = Valuation + math.random(3)
							elseif Level == 8 or Level == 9 or Level == 10 then
								Valuation = Valuation + math.random(4)
							end

							if vRP.GetWork(Passport) == "Garbageman" then
								local randItem = math.random(140)
								if parseInt(randItem) >= 101 and parseInt(randItem) <= 120 then
									itemSelect = { "titanium", Valuation }
									DefaultLevel = 2
								elseif parseInt(randItem) >= 81 and parseInt(randItem) <= 100 then
									itemSelect = { "metalcan", Valuation }
									DefaultLevel = 2
								elseif parseInt(randItem) >= 61 and parseInt(randItem) <= 80 then
									itemSelect = { "battery", Valuation }
									DefaultLevel = 2
								elseif parseInt(randItem) >= 41 and parseInt(randItem) <= 60 then
									itemSelect = { "elastic", Valuation }
									DefaultLevel = 2
								elseif parseInt(randItem) >= 21 and parseInt(randItem) <= 40 then
									itemSelect = { "plasticbottle", Valuation }
									DefaultLevel = 2
								elseif parseInt(randItem) <= 20 then
									itemSelect = { "glassbottle", Valuation }
									DefaultLevel = 2
								end
							else
								itemSelect = { "recyclable", Valuation }
								DefaultLevel = 1
							end

							vRP.PutExperience(Passport, "Garbageman", DefaultLevel)
						elseif Service == "Jornaleiro" then
							itemSelect = { "newspaper", math.random(3) }
						elseif Service == "Parkimeter" then
							local randPark = math.random(70)
							local randAmount = math.random(4, 8)
							if parseInt(randPark) >= 31 and parseInt(randPark) <= 60 then
								itemSelect = { "goldcoin", randAmount }
							elseif parseInt(randPark) <= 30 then
								itemSelect = { "silvercoin", randAmount }
							end
						elseif Service == "Electric" then
							local Players = vRPC.ClosestPeds(source, 15)
								for _,v in pairs(Players) do
								async(function()
									TriggerClientEvent("Notify",v,"azul","Uma <b>Caixa de Energia</b> próxima a você irá explodir em <b>10 Segundos</b>.",false,10000)
								end)
							end

							SetTimeout(10000, function()
								TriggerClientEvent("vRP:Explosion", source, Coords)
								exports["inventory"]:Drops(Passport, source, "metalwire", math.random(3, 6))
							end)
						elseif Service == "CarWreck" then
							itemSelect = { "scrap", math.random(6, 12) }
						elseif Service == "Pumpjack" then
							local randOil = math.random(15)
							if parseInt(randOil) >= 0 and parseInt(randOil) <= 10 then
								TriggerClientEvent("vRP:Explosion", source, Coords)
								itemSelect = { "oilbarrel", 1 }
							end
						elseif Service == "Gasoline" then
							local randGasoline = math.random(15)
							if parseInt(randGasoline) >= 0 and parseInt(randGasoline) <= 10 then
								itemSelect = { "WEAPON_PETROLCAN_AMMO", math.random(500, 1000) }
							end
						elseif Service == "Bricks" then
							local randBricks = math.random(15)
							if parseInt(randBricks) >= 0 and parseInt(randBricks) <= 10 then
								itemSelect = { "WEAPON_BRICK", math.random(3, 6) }
							end
						elseif Service == "Fruits" then
							local randFruits = math.random(40)
							if parseInt(randFruits) >= 31 and parseInt(randFruits) <= 40 then
								itemSelect = { "banana", math.random(3, 6) }
							elseif parseInt(randFruits) >= 21 and parseInt(randFruits) <= 30 then
								itemSelect = { "apple", math.random(3, 6) }
							elseif parseInt(randFruits) >= 11 and parseInt(randFruits) <= 20 then
								itemSelect = { "orange", math.random(3, 6) }
							elseif parseInt(randFruits) <= 10 then
								itemSelect = { "tange", math.random(3, 6) }
							end
						end

						if itemSelect[1] == "" then
							if Service == "Parkimeter" then
								TriggerEvent("Wanted", source, Passport, 300)

								local Players = vRPC.ClosestPeds(source, 15)
								for _,v in pairs(Players) do
									async(function()
										TriggerClientEvent("Notify",v,"azul","Um <b>Parquímetro</b> próximo a você irá explodir em <b>10 Segundos</b>.",false,10000)
									end)
								end

								SetTimeout(10000, function()
									TriggerClientEvent("vRP:Explosion", source, Coords)
								end)
							elseif Service == "Gasoline" then
								TriggerEvent("Wanted", source, Passport, 300)

								local Players = vRPC.ClosestPeds(source, 10)
								for _,v in pairs(Players) do
									async(function()
										TriggerClientEvent("Notify",v,"azul","Uma <b>Bomba de Gasolina</b> próxima a você irá explodir em <b>30 Segundos</b>.",false,30000)
									end)
								end

								SetTimeout(30000, function()
									TriggerClientEvent("vRP:Explosion", source, Coords)
								end)
							elseif Service == "Electric" then
								TriggerEvent("Wanted", source, Passport, 300)

								local Service = vRP.NumPermission("Policia")
								for Passports, Sources in pairs(Service) do
									async(function()
										TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo de Fios", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 44 })
									end)
								end
							elseif Service == "Pumpjack" then
								TriggerClientEvent("Notify",source,"vermelho","<b>Bomba de Vareta de Sucção</b> vazia.","Aviso",5000)
							elseif Service == "Gasoline" then
								TriggerClientEvent("Notify",source,"vermelho","<b>Bomba de Gasolina</b> vazia.","Aviso",5000)
							elseif Service == "Lixeiro" then
								local RandomCough = math.random(100)
								if RandomCough >= 95 then
									vRP.UpgradeCough(Passport, math.random(2))
								end

								TriggerClientEvent("Notify",source,"vermelho","Nada encontrado.","Aviso",5000)
							else
								TriggerClientEvent("Notify",source,"vermelho","Nada encontrado.","Aviso",5000)
							end

							vRP.UpgradeStress(Passport, 1)
						else
							if (vRP.InventoryWeight(Passport) + itemWeight(itemSelect[1]) * itemSelect[2]) <= vRP.GetWeight(Passport) then
								if (Service == "Pumpjack" or Service == "Parkimeter" or Service == "Gasoline") then
									vRP.GenerateItem(Passport, itemSelect[1], itemSelect[2], true)
									vRP.UpgradeStress(Passport, math.random(2, 4))
								else
									vRP.GenerateItem(Passport, itemSelect[1], itemSelect[2], true)
									vRP.UpgradeStress(Passport, 1)
								end
							else
								TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
								Trashs[Model][Hash] = nil
								Pumpjack[Model][Hash] = nil
							end
						end

						VerifyObjects[Passport] = nil
					end

					Wait(100)
				until not Active[Passport]
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CHANGEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:ChangePlate")
AddEventHandler("inventory:ChangePlate", function(Entity)
	local source = source
	local ConsultItem = {}
	local Plate = Entity[1]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Plates[Plate] then
			ConsultItem = vRP.InventoryItemAmount(Passport, "plate")
			if ConsultItem[1] <= 0 then
				TriggerClientEvent("Notify", source, "vermelho", "Precisa de <b>1x "..itemName("plate").."</b>.", "Atenção", 5000)
				return false
			end
		end

		local ConsultPliers = vRP.InventoryItemAmount(Passport, "pliers")
		if ConsultPliers[1] <= 0 then
			TriggerClientEvent("Notify", source, "vermelho", "Precisa de <b>1x "..itemName("pliers").."</b>.", "Atenção", 5000)
			return false
		end

		if Plates[Plate] ~= nil then
			if os.time() < Plates[Plate][1] then
				local plateTimers = parseInt(Plates[Plate][1] - os.time())
				if plateTimers ~= nil then
					TriggerClientEvent("Notify", source, "azul", "Aguarde "..CompleteTimers(plateTimers)..".", false, 5000)
				end

				return false
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress", source, "Trocando", 10000)
		vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source, false)
				Player(source)["state"]["Buttons"] = false

				if not Plates[Plate] then
					if vRP.TakeItem(Passport, ConsultItem[2], 1, true) then
						local NewPlate = vRP.GeneratePlate()
						TriggerEvent("plateEveryone", NewPlate)
						Plates[NewPlate] = { os.time() + 3600, Plate }

						local Network = NetworkGetEntityFromNetworkId(Entity[4])
						if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
							SetVehicleNumberPlateText(Network, NewPlate)
						end
					end
				else
					local Network = NetworkGetEntityFromNetworkId(Entity[4])
					if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
						SetVehicleNumberPlateText(Network, Plates[Plate][2])
					end

					if math.random(100) >= 50 then
						vRP.GenerateItem(Passport, "plate", 1, true)
					else
						TriggerClientEvent("Notify", source, "amarelo", "Após remove-la a mesma quebrou.", "Atenção", 5000)
					end

					TriggerEvent("plateReveryone", Plate)
					Plates[Plate] = nil
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.StealTrunk(Entity)
	local source = source
	local Plate = Entity[1]
	local Network = Entity[4]
	local vehModels = Entity[2]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not vCLIENT.CheckWeapon(source, "WEAPON_CROWBAR") then
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa colocar o <b>" .. itemName("WEAPON_CROWBAR") .. "</b> em mãos.", "Atenção", 5000)
			return
		end

		if not vRP.PassportPlate(Plate) then
			if not Trunks[Plate] then
				Trunks[Plate] = os.time()
			end

			if os.time() >= Trunks[Plate] then
				vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
				Active[Passport] = os.time() + 100

				if vRP.Task(source, 4, 10500) then
					Active[Passport] = os.time() + 20
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress", source, "Vasculhando", 20000)
					TriggerClientEvent("player:Residuals", source, "Resíduo de Ferro.")
					TriggerClientEvent("player:VehicleDoors", source, Network, "open")

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.StopAnim(source, false)
							Player(source)["state"]["Buttons"] = false
							TriggerClientEvent("player:VehicleDoors", source, Network, "close")

							if not Trunks[Plate] or os.time() >= Trunks[Plate] then
								local Rand = math.random(#StealItens)
								local Amount = math.random(StealItens[Rand]["Min"],StealItens[Rand]["Max"])

								if (vRP.InventoryWeight(Passport) + itemWeight(StealItens[Rand]["Item"]) * Amount) <= vRP.GetWeight(Passport) then
									vRP.GenerateItem(Passport, StealItens[Rand]["Item"], Amount, true)
									Trunks[Plate] = os.time() + 3600
									vRP.UpgradeStress(Passport, 2)
								else
									TriggerClientEvent("Notify", source, "Aviso", "Mochila cheia.", "amarelo", 5000)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				else
					TriggerClientEvent("inventory:vehicleAlarm", source, Network, Plate)
					vRPC.StopAnim(source, false)
					Active[Passport] = nil

					local Coords = vRP.GetEntityCoords(source)
					local Service = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(vehModels) .. " - " .. Plate, blipColor = 44 })
						end)
					end
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Veículo protegido pela seguradora.", "Atenção", 1000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Animals(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Entity[2] ~= nil and Entity[3] ~= nil then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa colocar o <b>" .. itemName("WEAPON_SWITCHBLADE") .. "</b> em mãos.", "Atenção", 5000)
				return
			end

			local Model = Entity[2]
			local netObjects = Entity[3]

			if not Animals[Model] then
				Animals[Model] = {}
			end

			if not Animals[Model][netObjects] then
				Animals[Model][netObjects] = 0
			end

			if not VerifyAnimals[Passport] and not Active[Passport] and Animals[Model][netObjects] < 5 then
				if (vRP.InventoryWeight(Passport) + 2.25) <= vRP.GetWeight(Passport) then
					if vRP.Task(source, 1, 10000) then
						Active[Passport] = os.time() + 10
						TriggerClientEvent("Progress", source, "Esfolando", 10000)

						if not vCLIENT.AnimalAnim(source) then
							vRPC.Destroy(source)
							vRPC.PlayAnim(source, false, { "amb@medic@standing@kneel@base","base" }, true)
							vRPC.PlayAnim(source, true, { "anim@gangops@facility@servers@bodysearch@","player_search" }, true)
						end

						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close", source)
						VerifyAnimals[Passport] = { Model, netObjects }
						Animals[Model][netObjects] = Animals[Model][netObjects] + 1

						repeat
							if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								VerifyAnimals[Passport] = nil
								Player(source)["state"]["Buttons"] = false

								if Animals[Model] then
									if Player(source)["state"]["Hunting"] then
										if Model == 1682622302 then
											coyoteList = { "coyote1star", "coyote2star", "coyote3star" }
											local coyoteRandom = math.random(#coyoteList)
											local coyoteSelects = coyoteList[coyoteRandom]
											vRP.GenerateItem(Passport, coyoteSelects, 1, true)
										elseif Model == 307287994 then
											mtlionList = { "mtlion1star", "mtlion2star", "mtlion3star" }
											local mtlionRandom = math.random(#mtlionList)
											local mtlionSelects = mtlionList[mtlionRandom]
											vRP.GenerateItem(Passport, mtlionSelects, 1, true)
										elseif Model == -832573324 then
											boarList = { "boar1star", "boar2star", "boar3star" }
											local boarRandom = math.random(#boarList)
											local boarSelects = boarList[boarRandom]
											vRP.GenerateItem(Passport, boarSelects, 1, true)
										elseif Model == -664053099 then
											deerList = { "deer1star", "deer2star", "deer3star" }
											local deerRandom = math.random(#deerList)
											local deerSelects = deerList[deerRandom]
											vRP.GenerateItem(Passport, deerSelects, 1, true)
										end
									else
										otherList = { "animalpelt","meat","animalfat","leather" }
										local otherRandom = math.random(#otherList)
										local otherSelects = otherList[otherRandom]
										vRP.GenerateItem(Passport, otherSelects, math.random(2,4), true)
									end

									vRPC.Destroy(source)
									Animals[Model][netObjects] = nil
									TriggerEvent("DeletePed", netObjects)
									Player(source)["state"]["Hunting"] = false
								end

								local Experience = vRP.GetExperience(Passport, "Hunter")
								local Category = ClassCategory(Experience)
								local Valuation = 100

								if Category == 1 then
									Valuation = Valuation + 10
								elseif Category == 2 then
									Valuation = Valuation + 20
								elseif Category == 3 then
									Valuation = Valuation + 30
								elseif Category == 4 then
									Valuation = Valuation + 40
								elseif Category == 5 then
									Valuation = Valuation + 50
								elseif Category == 6 then
									Valuation = Valuation + 60
								elseif Category == 7 then
									Valuation = Valuation + 70
								elseif Category == 8 then
									Valuation = Valuation + 80
								elseif Category == 9 then
									Valuation = Valuation + 90
								elseif Category == 10 then
									Valuation = Valuation + 100
								end

								if Buffs["Dexterity"][Passport] then
									if Buffs["Dexterity"][Passport] > os.time() then
										Valuation = Valuation + (Valuation * 0.1)
									end
								end

								vRP.PutExperience(Passport, "Hunter", 1)
								vRPC.StopAnim(source, false)
							end

							Wait(100)
						until not Active[Passport]
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
				end
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Aviso", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.StoreObjects(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Objects[Number] then
		if (vRP.InventoryWeight(Passport) + itemWeight(Objects[Number]["item"])) <= vRP.GetWeight(Passport) then
			vRP.GiveItem(Passport,Objects[Number]["item"],1,true)
			TriggerClientEvent("objects:Remover",-1,Number)
			Objects[Number] = nil
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.GenerateObjects(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Objects[Number] then
		if (vRP.InventoryWeight(Passport) + itemWeight(Objects[Number]["item"]) * 3) <= vRP.GetWeight(Passport) then
			vRP.GenerateItem(Passport,"oilgallon",3,true)
			TriggerClientEvent("objects:Remover",-1,Number)
			Objects[Number] = nil
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.MakeProducts(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		local Split = splitString(Table, "-")
		local Selected = Split[1]

		if Products[Selected] then
			if Selected == "foodjuice" or Selected == "foodburger" or Selected == "foodbox" then
				if not vRP.HasGroup(Passport,"Burgershot") then
					TriggerClientEvent("Notify",source,"amarelo","Você não tem permissões para isso.","Atenção",5000)
					return
				end
			end

			local Need = {}
			local Consult = {}
			local Number = math.random(#Products[Selected])

			if Products[Selected][Number]["item"] then
				if vRP.MaxItens(Passport, Products[Selected][Number]["item"], Products[Selected][Number]["itemAmount"]) then
					TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 3000)
					return
				end

				if (vRP.InventoryWeight(Passport) + itemWeight(Products[Selected][Number]["item"]) * Products[Selected][Number]["itemAmount"]) > vRP.GetWeight(Passport) then
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
					return
				end
			end

			if Products[Selected][Number]["need"] then
				local needItem = Products[Selected][Number]["need"]

				if type(needItem) == "table" then
					for k, v in pairs(needItem) do
						Consult = vRP.InventoryItemAmount(Passport, v["item"])
						if Consult[1] < v["amount"] then
							TriggerClientEvent("Notify", source, "amarelo", "Necessário possuir <b>" .. v["amount"] .. "x " .. itemName(v["item"]) .. "</b>.", "Atenção", 5000)
							return
						end

						Need[k] = { Consult[2], v["amount"] }
					end
				else
					needAmount = Products[Selected][Number]["needAmount"]
					Consult = vRP.InventoryItemAmount(Passport, needItem)
					if Consult[1] < needAmount then
						TriggerClientEvent("Notify", source, "amarelo", "Necessário possuir <b>" .. needAmount .. "x " .. itemName(needItem) .. "</b>.", "Atenção", 5000)
						return
					end

					if Selected == "laundry" then
						Consult = vRP.InventoryItemAmount(Passport, "chlorine")
						if Consult[1] < 1 then
							TriggerClientEvent("Notify", source, "amarelo", "Necessário possuir <b>1x " .. itemName("chlorine") .. "</b>.", "Atenção", 5000)
							return
						end
					end
				end
			end

			Player(source)["state"]["Buttons"] = true
			Active[Passport] = os.time() + Products[Selected][Number]["timer"]
			TriggerClientEvent("Progress", source, "Produzindo", Products[Selected][Number]["timer"] * 1000)
			
			if Selected == "foodjuice" then
				vRPC.PlayAnim(source, false, {"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}, true)
			elseif Selected == "foodburger" then
				vRPC.PlayAnim(source, false, {"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"}, true)
			elseif Selected == "foodbox" then
				vRPC.PlayAnim(source, false, {"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}, true)
			elseif Selected == "emptybottle" then
				vRPC.PlayAnim(source, false, {"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}, true)
			elseif Selected == "paper" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)
			elseif Selected == "milkBottle" then
				vRPC.PlayAnim(source, false, { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }, true)
			elseif Selected == "fishfillet" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)
			elseif Selected == "marshmallow" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)
			elseif Selected == "animalmeat" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)
			elseif Selected == "tablecoke" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)

				if vRP.Task(source,3,7500) then
					TriggerClientEvent("Notify", source, "verde", "Você acertou na mistura.", "Sucesso", 5000)
				else
					local Coords = vRP.GetEntityCoords(source)
					TriggerClientEvent("vRP:CoordExplosion", source, Coords["x"], Coords["y"], Coords["z"])
				end
			elseif Selected == "tablemeth" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)

				if vRP.Task(source,3,7500) then
					TriggerClientEvent("Notify", source, "verde", "Você acertou na mistura.", "Sucesso", 5000)
				else
					local Coords = vRP.GetEntityCoords(source)
					TriggerClientEvent("vRP:CoordExplosion", source, Coords["x"], Coords["y"], Coords["z"])
				end
			elseif Selected == "tableweed" then
				vRPC.PlayAnim(source, false, { "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter" }, true)

				if vRP.Task(source,3,7500) then
					TriggerClientEvent("Notify", source, "verde", "Você acertou na mistura.", "Sucesso", 5000)
				else
					local Coords = vRP.GetEntityCoords(source)
					TriggerClientEvent("vRP:CoordExplosion", source, Coords["x"], Coords["y"], Coords["z"])
				end
			else
				vRPC.PlayAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
			end

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Player(source)["state"]["Buttons"] = false
					vRPC.Destroy(source,"two")
					Active[Passport] = nil
					local Points = 0

					if Products[Selected][Number]["need"] then
						if type(Products[Selected][Number]["need"]) == "table" then
							for k, v in pairs(Need) do
								local Split = splitString(v[1], "-")
								if Split[1] == "weedbud" and Split[2] ~= nil then
									Points = Split[2]
								end

								vRP.RemoveItem(Passport, v[1], v[2], false)
							end
						else
							vRP.RemoveItem(Passport, Consult[2], needAmount, false)
						end
					end

					if Products[Selected][Number]["item"] then
						if Selected == "tableweed" then
							vRP.GenerateItem(Passport, Products[Selected][Number]["item"] .. "-" .. Points,
								Products[Selected][Number]["itemAmount"], true)
						else
							vRP.GenerateItem(Passport, Products[Selected][Number]["item"],
								Products[Selected][Number]["itemAmount"], true)

							if Selected == "milkBottle" then
								vRP.UpgradeStress(Passport, math.random(2))
							elseif Selected == "laundry" then
								TriggerEvent("Wanted",source,Passport,60)

								vRP.UpgradeStress(Passport, math.random(2,4))
								vRP.RemoveItem(Passport, "chlorine", 1, true)
								vRP.RemoveItem(Passport, "dollars2", 1000, true)
							end
						end
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Dismantle(Entity)
	local source = source
	local vehName = Entity[2]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = os.time() + 60
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Desmanchando", 60000)
		vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source)
				Player(source)["state"]["Buttons"] = false
				TriggerEvent("garages:dismantleVehicle", Entity[4], Entity[1])
				TriggerClientEvent("player:Residuals", source, "Resíduo de Metal.")
				TriggerClientEvent("player:Residuals", source, "Resíduo de Alumínio.")

				local Class = 1
				if Dismantle[Passport] then
					Class = ClassCategory(Dismantle[Passport])
				end

				local AmountItens = math.random(100, 150)
				local VehSelected = "suspension"
				local VehParts = math.random(4)
				local VehRandom = 1000

				if Class == 1 then
					VehRandom = math.random(4500)
					AmountItens = math.random(150, 200)
				elseif Class == 2 then
					VehRandom = math.random(4500)
					AmountItens = math.random(150, 200)
				elseif Class == 3 then
					VehRandom = math.random(4500)
					AmountItens = math.random(150, 200)
				elseif Class == 4 then
					VehRandom = math.random(3500)
					AmountItens = math.random(200, 250)
				elseif Class == 5 then
					VehRandom = math.random(3500)
					AmountItens = math.random(200, 250)
				elseif Class == 6 then
					VehRandom = math.random(3500)
					AmountItens = math.random(200, 250)
				elseif Class == 7 then
					VehRandom = math.random(2500)
					AmountItens = math.random(250, 300)
				elseif Class == 8 then
					VehRandom = math.random(2500)
					AmountItens = math.random(250, 300)
				elseif Class == 9 then
					VehRandom = math.random(2500)
					AmountItens = math.random(250, 300)
				elseif Class == 10 then
					VehRandom = math.random(1500)
					AmountItens = math.random(350, 400)
				end

				if VehParts <= 1 then
					VehSelected = "engine"
				elseif VehParts == 2 then
					VehSelected = "transmission"
				elseif VehParts == 3 then
					VehSelected = "brake"
				end

				if VehRandom <= 10 then
					vRP.GenerateItem(Passport, VehSelected .. "e", 1, true)
				elseif VehRandom >= 10 and VehRandom <= 30 then
					vRP.GenerateItem(Passport, VehSelected .. "d", 1, true)
				elseif VehRandom >= 31 and VehRandom <= 60 then
					vRP.GenerateItem(Passport, VehSelected .. "c", 1, true)
				elseif VehRandom >= 61 and VehRandom <= 100 then
					vRP.GenerateItem(Passport, VehSelected .. "b", 1, true)
				elseif VehRandom >= 101 and VehRandom <= 150 then
					vRP.GenerateItem(Passport, VehSelected .. "a", 1, true)
				end

				local Members = exports["vrp"]:Party(Passport, source, 20)
				if #Members > 1 then
					for _, v in pairs(Members) do
						vRP.GenerateItem(v["Passport"], "dollars", AmountItens * #Members, true)
						vRP.PutExperience(v["Passport"], "Dismantle", 2)
					end
				else
					vRP.GenerateItem(Passport, "dollars", AmountItens, true)
					vRP.PutExperience(Passport, "Dismantle", 1)
				end

				vRP.GenerateItem(Passport, "dismantle", 1, true)

				if math.random(1000) <= 100 then
					vRP.GenerateItem(Passport, "plate", 1, true)
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.RemoveTyres(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Entity[2] ~= "veto" and Entity[2] ~= "veto2" then
		if not vCLIENT.CheckWeapon(source,"WEAPON_WRENCH") then
			TriggerClientEvent("Notify",source,"Aviso","<b>Chave Inglesa</b> não encontrada.","amarelo",5000)

			return false
		end

		local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
		if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
			if vCLIENT.tyreHealth(source,Entity[4],Entity[5]) == 1000.0 then
				if vRP.MaxItens(Passport,"tyres",1) then
					TriggerClientEvent("Notify",source,"Aviso","Limite atingido.","amarelo",5000)

					return false
				end

				if vRP.Task(source,3,5000) then
					Active[Passport] = os.time() + 10
					TriggerClientEvent("Progress",source,"Removendo",10000)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil

							local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
							if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
								if vCLIENT.tyreHealth(source,Entity[4],Entity[5]) == 1000.0 then
									local Players = vRPC.Players(source)
									for _,v in pairs(Players) do
										async(function()
											TriggerClientEvent("inventory:explodeTyres",v,Entity[4],Entity[1],Entity[5])
										end)
									end

									vRP.GenerateItem(Passport,"tyres",1,true)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRINK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drink")
AddEventHandler("inventory:Drink",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		vRPC.AnimActive(source)

		if Buffs["Luck"][Passport] then
			if Buffs["Luck"][Passport] > os.time() then
				Active[Passport] = os.time() + 5
				TriggerClientEvent("Progress",source,"Bebendo",5000)
			end
		else
			Active[Passport] = os.time() + 10
			TriggerClientEvent("Progress",source,"Bebendo",10000)
		end

		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		vRPC.CreateObjects(source,"amb@world_human_drinking@coffee@male@idle_a","idle_c","prop_plastic_cup_02",49,28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil

				if Buffs["Luck"][Passport] then
					if Buffs["Luck"][Passport] > os.time() then
						vRP.UpgradeThirst(Passport, 30)
					end
				else
					vRP.UpgradeThirst(Passport, 15)
				end

				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.StealPeds()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Rand = math.random(#StealPeds)
		local Amount = math.random(StealPeds[Rand]["Min"],StealPeds[Rand]["Max"])

		if vRP.MaxItens(Passport,StealPeds[Rand]["Item"],Amount) then
			TriggerClientEvent("Notify",source,"vermelho","Limite atingido.","Aviso",5000)
			return true
		end

		if (vRP.InventoryWeight(Passport) + itemWeight(StealPeds[Rand]["Item"]) * Amount) <= vRP.GetWeight(Passport) then
			vRP.GenerateItem(Passport,StealPeds[Rand]["Item"],Amount,true)

			if math.random(100) >= 75 and vRP.DoesEntityExist(source) then
				TriggerEvent("Wanted",source,Passport,60)

				local Coords = vRP.GetEntityCoords(source)
				local Service = vRP.NumPermission("Policia")
				for Passports,Sources in pairs(Service) do
					async(function()
						vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",Sources,{ code = 32, title = "Assalto a mão armada", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", color = 16 })
					end)
				end
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:RollVehicle")
AddEventHandler("player:RollVehicle",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.ConsultItem(Passport,"carjack",1) then
			vRPC.AnimActive(source)
			Active[Passport] = os.time() + 60
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Desvirando",60000)
			vRPC.PlayAnim(source,false,{"mini@repair","fixing_a_player"},true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					vRPC.Destroy(source)
					Active[Passport] = nil
					Player(source)["state"]["Buttons"] = false

					local Players = vRPC.Players(source)
					for _,v in pairs(Players) do
						async(function()
							TriggerClientEvent("target:RollVehicle",v,Entity[4])
						end)
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..itemName("carjack").."</b>.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERSTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.RegistersTimers(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not vCLIENT.CheckWeapon(source,"WEAPON_CROWBAR") then
			TriggerClientEvent("Notify",source,"amarelo","Você precisa colocar o <b>"..itemName("WEAPON_CROWBAR").."</b> em mãos.","Atenção",5000)
			return false
		end

		if Registers[Number] then
			if GetGameTimer() < Registers[Number] then
				TriggerClientEvent("Notify",source,"vermelho","Sistema indisponível no momento.","Aviso",5000)
				return false
			else
				InitRegisters(Number, source)
				return true
			end
		else
			InitRegisters(Number, source)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITREGISTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function InitRegisters(Number,source)
	Registers[Number] = GetGameTimer() + (20 * 60000)

	if math.random(100) >= 75 then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)

		local Service = vRP.NumPermission("Policia")
		for Passports,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("NotifyPush", Sources,{ code = 31, title = "Caixa Registradora", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 16 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERSPAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.RegistersPay()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Rand = math.random(365,725)

		vRP.UpgradeStress(Passport,2)
		vRP.GenerateItem(Passport,"dollars2",parseInt(Rand),true)

		TriggerEvent("Wanted",source,Passport,300)
		TriggerClientEvent("player:Residuals",source,"Resíduo de Arrombamento.")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.MakePackage(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Pegando pacote", 10000)
		vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source)
				Player(source)["state"]["Buttons"] = false
				if vRP.MaxItens(Passport, Service, 1) then
					TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 5000)
				else
					vRP.GenerateItem(Passport, Service, 1, true)

					if vCLIENT.TakePackage(source) then
						vCLIENT.CheckPackage(source)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.DeliverPackage(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.TakeItem(Passport,Service,1,true) then
			vCLIENT.FinishPackage(source)

			local Experience = vRP.GetExperience(Passport,"Delivery")
			local Category = ClassCategory(Experience)
			local Valuation = 3500

			if Category == 1 then
				Valuation = Valuation + 10
			elseif Category == 2 then
				Valuation = Valuation + 20
			elseif Category == 3 then
				Valuation = Valuation + 30
			elseif Category == 4 then
				Valuation = Valuation + 40
			elseif Category == 5 then
				Valuation = Valuation + 50
			elseif Category == 6 then
				Valuation = Valuation + 60
			elseif Category == 7 then
				Valuation = Valuation + 70
			elseif Category == 8 then
				Valuation = Valuation + 80
			elseif Category == 9 then
				Valuation = Valuation + 90
			elseif Category == 10 then
				Valuation = Valuation + 100
			end

			if Buffs["Dexterity"][Passport] then
				if Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end
			end

			vRP.PaymentService(Passport,Valuation,vRP.Identity(Passport)["Mode"],true)
			TriggerClientEvent("inventory:Update",source,"Backpack")
			vRP.PutExperience(Passport,"Delivery",1)
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..itemName(Service).."</b>.","Atenção",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ShotsFired(Vehicle)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and GetPlayerRoutingBucket(source) < 900000 then
		if Vehicle then
			Vehicle = "Disparos de um veículo"
		else
			Vehicle = "Disparos com arma de fogo"
		end

		local Coords = vRP.GetEntityCoords(source)
		local Service = vRP.NumPermission("Policia")
		for Passports,Sources in pairs(Service) do
			async(function()
				vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("NotifyPush",Sources,{ code = 10, title = Vehicle, x = Coords["x"], y = Coords["y"], z = Coords["z"], color = 6 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Experience(Category)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return vRP.GetExperience(Passport,Category)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLETOW
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ToggleTow()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if TowList[Passport] then
			TowList[Passport] = nil
		else
			TowList[Passport] = source
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CALLTOW
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CallTow",function(source,vehName,Plate)
	local Ped = GetPlayerPed(source)
	if DoesEntityExist(Ped) then
		local Coords = GetEntityCoords(Ped)

		for k,v in pairs(TowList) do
			async(function()
				TriggerClientEvent("NotifyPush", v,{ code = 51, title = "Registro de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(vehName).." - "..Plate, blipColor = 33 })
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTTOW
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PaymentTow(Network,Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		TriggerEvent("garages:DeleteVehicle", Network, Plate)

		local AmountItens = math.random(5, 10)

		if (vRP.InventoryWeight(Passport) + AmountItens) <= vRP.GetWeight(Passport) then
			local VehParts = math.random(4)
			local VehSelected = "suspension"
			local Tow = vRP.GetExperience(Passport, "Tows")
			local Class = ClassCategory(Tow)
			local VehRandom = 1000

			if Class == 1 then
				VehRandom = math.random(4500)
			elseif Class == 2 then
				VehRandom = math.random(4500)
			elseif Class == 3 then
				VehRandom = math.random(4500)
			elseif Class == 4 then
				VehRandom = math.random(3500)
			elseif Class == 5 then
				VehRandom = math.random(3500)
			elseif Class == 6 then
				VehRandom = math.random(3500)
			elseif Class == 7 then
				VehRandom = math.random(2500)
			elseif Class == 8 then
				VehRandom = math.random(2500)
			elseif Class == 9 then
				VehRandom = math.random(2500)
			elseif Class == 10 then
				VehRandom = math.random(1500)
			end

			if VehParts <= 1 then
				VehSelected = "engine"
			elseif VehParts == 2 then
				VehSelected = "transmission"
			elseif VehParts == 3 then
				VehSelected = "brake"
			end

			if VehRandom <= 10 then
				vRP.GenerateItem(Passport, VehSelected .. "e", 1, true)
			elseif VehRandom >= 10 and VehRandom <= 30 then
				vRP.GenerateItem(Passport, VehSelected .. "d", 1, true)
			elseif VehRandom >= 31 and VehRandom <= 60 then
				vRP.GenerateItem(Passport, VehSelected .. "c", 1, true)
			elseif VehRandom >= 61 and VehRandom <= 100 then
				vRP.GenerateItem(Passport, VehSelected .. "b", 1, true)
			elseif VehRandom >= 101 and VehRandom <= 150 then
				vRP.GenerateItem(Passport, VehSelected .. "a", 1, true)
			end

			vRP.GenerateItem(Passport, "plastic", AmountItens, true)
			vRP.GenerateItem(Passport, "glass", AmountItens, true)
			vRP.GenerateItem(Passport, "rubber", AmountItens, true)
			vRP.GenerateItem(Passport, "copper", AmountItens, true)
			vRP.GenerateItem(Passport, "aluminum", AmountItens, true)

			vRP.PutExperience(Passport, "Tows", math.random(2, 3))
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SERVERTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:ServerTow")
AddEventHandler("inventory:ServerTow",function(Vehicle,Vehicle02,Mode)
	local source = source
	local Players = vRPC.Players(source)
	for _,v in pairs(Players) do
		async(function()
			TriggerClientEvent("inventory:ClientTow",v,Vehicle,Vehicle02,Mode)
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SENDLETTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:SendLetter")
AddEventHandler("inventory:SendLetter",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.ConsultItem(Passport,"paper",1) then
			local Keyboard = vKEYBOARD.Secondary(source,"Passaporte:","Mensagem:")
			if Keyboard then
				if vRP.TakeItem(Passport,"paper",1,true) then
					local Time = os.time()

					vRP.SetServerData("paper-"..Time,Keyboard[2])
					vRP.GenerateItem(Keyboard[1],"paper-"..Time,1,true)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..itemName("paper").."</b>.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWORK
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckWork(Work)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.GetWork(Passport) == Work then
			return true
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa ter a sua <b>Carteira de Trabalho</b> assinada no emprego de <b>"..ClassWork(Work).."</b> para conseguir trabalhar aqui.", "Atenção", 5000)
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBUS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PaymentBus(Selected)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and BusLocations[Selected] then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not Selected or not vRPC.LastVehicle(source,"bus") or #(Coords - BusLocations[Selected]) > 25 then
			exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Motorista",3092790)
		end

		local Experience = vRP.GetExperience(Passport,"Driver")
		local Level = ClassCategory(Experience)
		local Valuation = 115

		if Level == 2 or Level == 3 or Level == 5 then
			Valuation = Valuation + 20
		elseif Level == 6 or Level == 7 or Level == 8 then
			Valuation = Valuation + 40
		elseif Level == 9 or Level == 10 then
			Valuation = Valuation + 60
		end

		local Buffs = exports["inventory"]:Buffs("Dexterity",Passport)
		if Buffs and Buffs > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		local Members = exports["vrp"]:Party(Passport,source,10)
		if parseInt(#Members) >= 2 then
			Valuation = Valuation + (Valuation * 0.1)
		end

		vRP.PaymentService(Passport,Valuation,vRP.Identity(Passport)["Mode"],true)
		vRP.PutExperience(Passport,"Driver",1)

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPROPERTY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckProperty(Number)
	local source = source
	if not Delay[Number] or Delay[Number] <= os.time() then
		Delay[Number] = os.time() + (15 * 60)
		return true
	else
		TriggerClientEvent("Notify", source, "azul", "Aguarde "..CompleteTimers(tonumber(Delay[Number]) - tonumber(os.time()))..".", false, 5000)
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PaymentHouse(ServicesDone)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Completed = true
		for k,v in pairs(ServicesDone) do
			if not v then
				Completed = false
				break
			end
		end

		if Completed then
			local Experience = vRP.GetExperience(Passport,"Cleaner")
			local Level = ClassCategory(Experience)
			local Valuation = 75

			if Level == 2 or Level == 3 then
				Valuation = Valuation + 30
			elseif Level == 4 or Level == 5 then
				Valuation = Valuation + 35
			elseif Level == 6 or Level == 7 then
				Valuation = Valuation + 40
			elseif Level == 8 or Level == 9 then
				Valuation = Valuation + 45
			elseif Level == 10 then
				Valuation = Valuation + 50
			end

			vRP.PaymentService(Passport,Valuation * #ServicesDone, vRP.Identity(Passport)["Mode"], true)
			vRP.UpgradeStress(Passport, #ServicesDone)
			vRP.PutExperience(Passport, "Cleaner", 1)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVESERVICESPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.DriveServicesPermission(Mode, Status)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Status then
			Player(source)["state"][Mode] = true
		else
			Player(source)["state"][Mode] = false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTDRIVESERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PaymentDriveServices()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Valuation = 225

		local Buffs = exports["inventory"]:Buffs("Dexterity",Passport)
		if Buffs and Buffs > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		vRP.PaymentService(Passport,Valuation,vRP.Identity(Passport)["Mode"],true)
		vRP.UpgradeStress(Passport,2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTTAXI
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PaymentTaxi()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Experience = vRP.GetExperience(Passport,"Taxi")
		local Level = ClassCategory(Experience)
		local Valuation = 115

		if Level == 2 or Level == 3 or Level == 5 then
			Valuation = Valuation + 20
		elseif Level == 6 or Level == 7 or Level == 8 then
			Valuation = Valuation + 40
		elseif Level == 9 or Level == 10 then
			Valuation = Valuation + 60
		end

		local Buffs = exports["inventory"]:Buffs("Dexterity",Passport)
		if Buffs and Buffs > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		vRP.PaymentService(Passport,Valuation,vRP.Identity(Passport)["Mode"],true)
		vRP.PutExperience(Passport,"Taxi",1)
		vRP.UpgradeStress(Passport,2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PutPackage(Plate)
	if BoxVehiclesServer[Plate] == nil then
		BoxVehiclesServer[Plate] = 1
	else
		if BoxVehiclesServer[Plate] < MaximumPackages then
			BoxVehiclesServer[Plate] = BoxVehiclesServer[Plate] + 1
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você excedeu o limite de caixas.", "Atenção", 5000)
			return false
		end
	end

	TriggerClientEvent("inventory:PostOpUpdatePackage", -1, BoxVehiclesServer)
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTPOSTOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PaymentPostOp()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not Selected or not vRPC.LastVehicle(source,"boxville4") then
			exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Correios",3092790)
		end

		local Experience = vRP.GetExperience(Passport,"PostOp")
		local Level = ClassCategory(Experience)
		local Valuation = 175

		if Level == 2 or Level == 3 or Level == 5 then
			Valuation = Valuation + 75
		elseif Level == 6 or Level == 7 or Level == 8 then
			Valuation = Valuation + 135
		elseif Level == 9 or Level == 10 then
			Valuation = Valuation + 195
		end

		local Buffs = exports["inventory"]:Buffs("Dexterity",Passport)
		if Buffs and Buffs > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		local Members = exports["vrp"]:Party(Passport,source,10)
		if parseInt(#Members) >= 2 then
			Valuation = Valuation + (Valuation * 0.1)
		end

		vRP.PaymentService(Passport,Valuation,vRP.Identity(Passport)["Mode"],true)
		vRP.PutExperience(Passport,"PostOp",1)
		vRP.UpgradeStress(Passport,2)

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("postop:RemovePackage")
AddEventHandler("postop:RemovePackage",function(Plate)
	if BoxVehiclesServer[Plate] then
		BoxVehiclesServer[Plate] = BoxVehiclesServer[Plate] - 1

		if BoxVehiclesServer[Plate] <= 0 then
			BoxVehiclesServer[Plate] = nil
		end

		TriggerClientEvent("inventory:PostOpUpdatePackage", -1, BoxVehiclesServer)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CAMERAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Cameras")
AddEventHandler("inventory:Cameras", function()
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasPermission(Passport, "Policia") then
			TriggerClientEvent("inventory:CameraNumber", source)
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões para isso.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BUFFSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:BuffServer",function(source,Passport,Name,Amount)
	if not Buffs[Name][Passport] then
		Buffs[Name][Passport] = 0
	end

	if os.time() >= Buffs[Name][Passport] then
		Buffs[Name][Passport] = os.time() + Amount
	else
		Buffs[Name][Passport] = Buffs[Name][Passport] + Amount

		if (Buffs[Name][Passport] - os.time()) >= 3600 then
			Buffs[Name][Passport] = os.time() + 3600
		end
	end

	TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Buffs",function(Mode,Passport)
	return Buffs[Mode][Passport]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer",function(Silenced)
	local List = vRP.Players()
	for Passport,_ in pairs(List) do
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Attachs", Information = json.encode(Attachs[Passport]) })
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Ammos", Information = json.encode(Ammos[Passport]) })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Ammos[Passport] or Attachs[Passport] then
		if Temporary[Passport] then
			Ammos[Passport] = Temporary[Passport]["Ammos"]
			Attachs[Passport] = Temporary[Passport]["Attachs"]
			Temporary[Passport] = nil
		end

		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Attachs", Information = json.encode(Attachs[Passport]) })
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Ammos", Information = json.encode(Ammos[Passport]) })

		Attachs[Passport] = nil
		Ammos[Passport] = nil
	end

	if Active[Passport] then
		Active[Passport] = nil
	end

	if TowList[Passport] then
		TowList[Passport] = nil
	end

	if VerifyObjects[Passport] then
		VerifyObjects[Passport] = nil
	end

	if VerifyAnimals[Passport] then
		VerifyAnimals[Passport] = nil
	end

	if Loots[Passport] then
		Loots[Passport] = nil
	end

	if Healths[Passport] then
		Healths[Passport] = nil
	end

	if Armors[Passport] then
		Armors[Passport] = nil
	end

	if Scanners[Passport] then
		Scanners[Passport] = nil
	end

	if Carry[Passport] then
		if vRP.Passport(Carry[Passport]) then
			TriggerClientEvent("inventory:Carry",Carry[Passport],nil,"Detach")
			Player(Carry[Passport])["state"]["Carry"] = false
			vRPC.Destroy(Carry[Passport])
		end

		Carry[Passport] = nil
	end

	if Drugs[Passport] then
		Drugs[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	Ammos[Passport] = vRP.UserData(Passport,"Ammos")
	Attachs[Passport] = vRP.UserData(Passport,"Attachs")

	TriggerClientEvent("objects:Table",source,Objects)
	TriggerClientEvent("inventory:Drops",source,Drops)

	for Name,_ in pairs(Buffs) do
		if Buffs[Name] and Buffs[Name][Passport] and os.time() < Buffs[Name][Passport] then
			TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
		end
	end

	TriggerClientEvent("inventory:PostOpUpdatePackage",source,BoxVehiclesServer)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("CleanWeapons",function(Passport,Clean)
	local source = vRP.Source(Passport)
	if source then
		local Ped = GetPlayerPed(source)
		local Weapon = GetSelectedPedWeapon(Ped)

		RemoveWeaponFromPed(Ped,Weapon)
		RemoveAllPedWeapons(Ped,false)
		SetPedAmmo(Ped,Weapon,0)

		if Clean then
			Attachs[Passport] = {}
			Ammos[Passport] = {}
		end
	end
end)