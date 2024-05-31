-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Cooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
local Robberys = {
	["weaponshop"] = {
		["Cops"] = 5,
		["Radio"] = 101,
		["Duration"] = 300,
		["Name"] = "Loja de Armas",
		["Cooldown"] = 5400,
		["Mode"] = "shops",
		["Payment"] = {
			["Item"] = "dollars2",
			["Min"] = 50000,
			["Max"] = 75000
		}
	},
	["tattooshop"] = {
		["Cops"] = 5,
		["Radio"] = 201,
		["Duration"] = 300,
		["Name"] = "Loja de Tatuagem",
		["Cooldown"] = 5400,
		["Mode"] = "shops",
		["Payment"] = {
			["Item"] = "dollars2",
			["Min"] = 50000,
			["Max"] = 75000
		}
	},
	["fleecas"] = {
		["Cops"] = 10,
		["Radio"] = 301,
		["Duration"] = 600,
		["Name"] = "Banco Fleeca",
		["Cooldown"] = 21600,
		["Mode"] = "banks",
		["Payment"] = {
			["Item"] = "dollars2",
			["Min"] = 125000,
			["Max"] = 150000
		}
	},
	["departmentshop"] = {
		["Cops"] = 7,
		["Radio"] = 401,
		["Duration"] = 300,
		["Name"] = "Loja de Departamento",
		["Cooldown"] = 5400,
		["Mode"] = "shops",
		["Payment"] = {
			["Item"] = "dollars2",
			["Min"] = 75000,
			["Max"] = 100000
		}
	},
	["clotheshop"] = {
		["Cops"] = 5,
		["Radio"] = 501,
		["Duration"] = 300,
		["Name"] = "Loja de Roupas",
		["Cooldown"] = 5400,
		["Mode"] = "shops",
		["Payment"] = {
			["Item"] = "dollars2",
			["Min"] = 50000,
			["Max"] = 75000
		}
	},
	["barbershop"] = {
		["Cops"] = 6,
		["Radio"] = 601,
		["Duration"] = 300,
		["Name"] = "Barbearia",
		["Cooldown"] = 5400,
		["Mode"] = "shops",
		["Payment"] = {
			["Item"] = "dollars2",
			["Min"] = 25000,
			["Max"] = 30000
		}
	},
	["banks"] = {
		["Cops"] = 10,
		["Radio"] = 701,
		["Duration"] = 600,
		["Name"] = "Banco",
		["Cooldown"] = 21600,
		["Mode"] = "banks",
		["Payment"] = {
			["Item"] = "dollars2",
			["Min"] = 225000,
			["Max"] = 250000
		}
	},
	["jewelry"] = {
		["Cops"] = 8,
		["Radio"] = 801,
		["Duration"] = 600,
		["Name"] = "Joalheria",
		["Cooldown"] = 21600,
		["Mode"] = "banks",
		["Payment"] = {
			["Item"] = "dollars2",
			["Min"] = 100000,
			["Max"] = 125000
		}
	},
	["eletronics"] = {
		["Cops"] = 5,
		["Duration"] = 30,
		["Name"] = "Caixa Eletrônico",
		["Cooldown"] = 900,
		["Mode"] = "eletronic",
		["Payment"] = {
			["Item"] = "dollars2",
			["Min"] = 4725,
			["Max"] = 5725
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Robberys")
AddEventHandler("inventory:Robberys",function(Crime)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Robberys[Crime] then
		local Mode = Robberys[Crime]["Mode"]

		if not Cooldown[Mode] or os.time() > Cooldown[Mode] then
			local Service,Total = vRP.NumPermission("Policia")
			if Total >= Robberys[Crime]["Cops"] then
				if vRP.Device(source, 60) then
					Cooldown[Mode] = os.time() + Robberys[Crime]["Cooldown"]

					if Robberys[Crime]["Radio"] then
						TriggerClientEvent("Notify", source, "default", "Rádio da Negociação: <b>"..Robberys[Crime]["Radio"].."</b>", false, 10000)
					end

					local Coords = vRP.GetEntityCoords(source)
					for Passports,Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("sounds:Private",Sources,"crime",0.5)

							if Robberys[Crime]["Radio"] then
								TriggerClientEvent("NotifyPush",Sources,{ code = 31, title = "Roubo a "..Robberys[Crime]["Name"], x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Rádio da Negociação: "..Robberys[Crime]["Radio"], color = 22 })
							else
								TriggerClientEvent("NotifyPush",Sources,{ code = 31, title = "Roubo a "..Robberys[Crime]["Name"], x = Coords["x"], y = Coords["y"], z = Coords["z"], color = 22 })
							end
						end)
					end

					vRPC.AnimActive(source)
					Player(source)["state"]["Buttons"] = true
					Active[Passport] = os.time() + Robberys[Crime]["Duration"]
					TriggerEvent("Wanted",source,Passport,Robberys[Crime]["Duration"] * 3)
					vRPC.PlayAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)
					TriggerClientEvent("Progress",source,"Roubando",Robberys[Crime]["Duration"] * 1000)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							vRPC.Destroy(source)
							Active[Passport] = nil
							Player(source)["state"]["Buttons"] = false
							vRP.GenerateItem(Passport,Robberys[Crime]["Payment"]["Item"],math.random(Robberys[Crime]["Payment"]["Min"],Robberys[Crime]["Payment"]["Max"]),true)
						end

						Wait(100)
					until not Active[Passport]
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", "Atenção", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>"..Cooldown[Mode] - os.time().."</b> segundos.", false, 5000)
		end
	end
end)