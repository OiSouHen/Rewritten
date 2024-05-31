-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLESLIST
-----------------------------------------------------------------------------------------------------------------------------------------
Stockades = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Cooldown = os.time()
local StockadeItem = "dollars2"
local StockadeValue = math.random(6500, 8000)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Stockade")
AddEventHandler("inventory:Stockade",function(Vehicle)
	local source = source
	local Plate = Vehicle[1]
	local Passport = vRP.Passport(source)
	local Service,Total = vRP.NumPermission("Policia")
	if not Active[Passport] then
		if not vRP.PassportPlate(Plate) then
			if Total >= 4 then
				if (vRP.InventoryWeight(Passport) + itemWeight(StockadeItem) * StockadeValue) <= vRP.GetWeight(Passport) then
					vRPC.PlayAnim(source,false,{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer" },true)
					
					if vRP.Task(source, 10, 10000) then
						if not Stockades[Plate] then
							Stockades[Plate] = 10
							Cooldown = os.time() + 3600

							local Coords = vRP.GetEntityCoords(source)
							local Service = vRP.NumPermission("Policia")
							for Passports,Sources in pairs(Service) do
								async(function()
									TriggerClientEvent("sounds:Private",Sources,"crime",0.5)
									TriggerClientEvent("NotifyPush",Sources,{ code = 31, title = "Roubo a Carro Forte", x = Coords["x"], y = Coords["y"], z = Coords["z"], color = 44, red = true })
								end)
							end
						end

						if Stockades[Plate] <= 0 then
							TriggerClientEvent("Notify",source,"amarelo","Compartimento vazio.","Atenção",5000)
							return false
						end

						if not vCLIENT.CheckWeapon(source,"WEAPON_CROWBAR") then
							TriggerClientEvent("Notify",source,"amarelo","Você precisa colocar o <b>"..itemName("WEAPON_CROWBAR").."</b> em mãos.","Atenção",5000)
							return false
						end

						Active[Passport] = os.time() + 20
						Stockades[Plate] = Stockades[Plate] - 1
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("Progress",source,"Roubando",20000)
						vRPC.PlayAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)

						repeat
							if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								vRPC.StopAnim(source, false)
								Player(source)["state"]["Buttons"] = false
								vRP.GenerateItem(Passport, StockadeItem, StockadeValue, true)
							end

							Wait(100)
						until not Active[Passport]
					else
						vRPC.StopAnim(source, false)
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", "Atenção", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Veículo protegido pela seguradora.", "Atenção", 5000)
		end
	end
end)