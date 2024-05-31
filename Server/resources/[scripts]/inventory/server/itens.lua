-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
Use = {
	["woodenbarrel"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_CROWBAR") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque o <b>"..itemName("WEAPON_CROWBAR").."</b> em mãos.","Atenção",5000)
			return
		end

		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			local Danger = math.random(100)
			if Danger >= 90 then
				vRP.UpgradeCough(Passport, math.random(50))
				TriggerClientEvent("Notify", source, "amarelo", "Você abriu <b>1x "..itemName(Item).."</b> contaminado.", "Atenção", 5000)
			else
				local Rand = math.random(#DiverList)
				local Amount = math.random(DiverList[Rand]["Min"],DiverList[Rand]["Max"])
				vRP.GenerateItem(Passport,DiverList[Rand]["Item"],Amount,true)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		end
	end,

	["woodenchest"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque a <b>"..itemName("WEAPON_SWITCHBLADE").."</b> em mãos.","Atenção",5000)
			return
		end

		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			local Rand = math.random(#PounderList)
			local Amount = math.random(PounderList[Rand]["Min"],PounderList[Rand]["Max"])
			vRP.GenerateItem(Passport,PounderList[Rand]["Item"],Amount,true)
			TriggerClientEvent("inventory:Update",source,"Backpack")

			local Coords = vRP.GetEntityCoords(source)
			local Service = vRP.NumPermission("Policia")
			for Passports,Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("sounds:Private",Sources,"crime",0.5)
					TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Manejo de Drogas", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", color = 16 })
				end)
			end
		end
	end,

	["adesive01"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate = vRPC.VehicleList(source, 4)
			if Vehicle then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 100
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				if vRP.Task(source, 4, 20500) then
					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Players = vRPC.Players(source)
						for _, v in pairs(Players) do
							async(function()
								TriggerClientEvent("inventory:paintVehicle", v, Network, Plate, 150)
							end)
						end
					end
				end

				Player(source)["state"]["Buttons"] = false
				vRPC.StopAnim(source, false)
				Active[Passport] = nil
			end
		end
	end,

	["adesive02"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate = vRPC.VehicleList(source, 4)
			if Vehicle then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 100
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				if vRP.Task(source, 4, 20500) then
					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Players = vRPC.Players(source)
						for _, v in pairs(Players) do
							async(function()
								TriggerClientEvent("inventory:paintVehicle", v, Network, Plate, 55)
							end)
						end
					end
				end

				Player(source)["state"]["Buttons"] = false
				vRPC.StopAnim(source, false)
				Active[Passport] = nil
			end
		end
	end,

	["adesive03"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate = vRPC.VehicleList(source, 4)
			if Vehicle then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 100
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				if vRP.Task(source, 4, 20500) then
					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Players = vRPC.Players(source)
						for _, v in pairs(Players) do
							async(function()
								TriggerClientEvent("inventory:paintVehicle", v, Network, Plate, 63)
							end)
						end
					end
				end

				Player(source)["state"]["Buttons"] = false
				vRPC.StopAnim(source, false)
				Active[Passport] = nil
			end
		end
	end,

	["adesive04"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate = vRPC.VehicleList(source, 4)
			if Vehicle then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 100
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				if vRP.Task(source, 4, 20500) then
					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Players = vRPC.Players(source)
						for _, v in pairs(Players) do
							async(function()
								TriggerClientEvent("inventory:paintVehicle", v, Network, Plate, 88)
							end)
						end
					end
				end

				Player(source)["state"]["Buttons"] = false
				vRPC.StopAnim(source, false)
				Active[Passport] = nil
			end
		end
	end,

	["adesive05"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate = vRPC.VehicleList(source, 4)
			if Vehicle then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 100
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				if vRP.Task(source, 4, 20500) then
					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Players = vRPC.Players(source)
						for _, v in pairs(Players) do
							async(function()
								TriggerClientEvent("inventory:paintVehicle", v, Network, Plate, 109)
							end)
						end
					end
				end

				Player(source)["state"]["Buttons"] = false
				vRPC.StopAnim(source, false)
				Active[Passport] = nil
			end
		end
	end,

	["ziplock"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.ConsultItem(Passport, "cocaine", 1) or vRP.ConsultItem(Passport, "meth", 1) or vRP.ConsultItem(Passport, "weedbud", 1) then
			Active[Passport] = os.time() + 5
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Embalando", 5000)
			vRPC.PlayAnim(source, true, { "amb@world_human_clipboard@male@idle_a", "idle_c" }, true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.StopAnim(source, false)
					Player(source)["state"]["Buttons"] = false

					local PackDrugs = {
						{ "cocaine", "cokesack" },
						{ "meth",    "methsack" },
						{ "weedbud", "weedsack" }
					}

					for k, v in pairs(PackDrugs) do
						if vRP.TakeItem(Passport, v[1], 1, false) then
							vRP.RemoveItem(Passport, "ziplock", 1, false)
							vRP.GenerateItem(Passport, v[2], 1, true)
							break
						end
					end

					vRP.UpgradeStress(Passport, math.random(5))
				end

				Wait(100)
			until not Active[Passport]
		else
			TriggerClientEvent("Notify", source, "vermelho", "Você não possúi drogas na mochila.", "Aviso", 5000)
		end
	end,

	["cat"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_cat_01")
		vRPC.PlayAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,

	["hen"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_hen")
		vRPC.PlayAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,

	["husky"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_husky")
		vRPC.PlayAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,

	["pig"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_pig")
		vRPC.PlayAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,

	["poodle"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_poodle")
		vRPC.PlayAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,

	["pug"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_pug")
		vRPC.PlayAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,

	["retriever"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_retriever")
		vRPC.PlayAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,

	["rottweiler"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_rottweiler")
		vRPC.PlayAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,

	["shepherd"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_shepherd")
		vRPC.PlayAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,

	["westy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_westy")
		vRPC.PlayAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,

	["vpn"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			if vRP.ConsultItem(Passport, "radio", 1) then
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Ativando", 5000)
				vRPC.CreateObjects(source, "amb@code_human_in_bus_passenger_idles@female@tablet@base", "base", "prop_cs_tablet", 49, 28422)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.Destroy(source, "one")
						Player(source)["state"]["Buttons"] = false

						local Coords = GetEntityCoords(GetPlayerPed(source))
						for _, Players in pairs(GetPlayers()) do
							if Players ~= source then
								local Distance = #(Coords - GetEntityCoords(GetPlayerPed(Players)))
								if Distance <= 50 then
									local radioChannel = Player(Players)["state"]["radioChannel"]
									if radioChannel ~= 0 then
										TriggerClientEvent("inventory:Listen", source, radioChannel)
										return true
									end
								end
							end
						end
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>1x " .. itemName("radio") .. "</b>.", "Atenção", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa sair do veículo.", "Atenção", 5000)
		end
	end,

	["graphite01"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Handcuff"] then
			local Vehicle, Network, PlayerAround = vRPC.VehicleAround(source)
			if Vehicle and not vRPC.InsideVehicle(source) then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Instalando", 10000)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						vRPC.StopAnim(source)
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							TriggerEvent("engine:ApplyBrakes", Item, Network, Amount, PlayerAround)
						end
					end

					Wait(100)
				until not Active[Passport]
			end
		end
	end,

	["graphite02"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Handcuff"] then
			local Vehicle, Network, PlayerAround = vRPC.VehicleAround(source)
			if Vehicle and not vRPC.InsideVehicle(source) then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Instalando", 5000)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						vRPC.StopAnim(source)
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							TriggerEvent("engine:ApplyBrakes", Item, Network, Amount, PlayerAround)
						end
					end

					Wait(100)
				until not Active[Passport]
			end
		end
	end,

	["graphite03"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Handcuff"] then
			local Vehicle, Network, PlayerAround = vRPC.VehicleAround(source)
			if Vehicle and not vRPC.InsideVehicle(source) then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Instalando", 5000)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						vRPC.StopAnim(source)
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							TriggerEvent("engine:ApplyBrakes", Item, Network, Amount, PlayerAround)
						end
					end

					Wait(100)
				until not Active[Passport]
			end
		end
	end,

	["energetic"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 15
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Bebendo", 15000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "prop_energy_drink", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("Energetic", source, 30, 1.20)
					vRP.UpgradeThirst(Passport, 10)
					vRP.UpgradeStress(Passport, 5)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cocaine"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Cheirando", 5000)
		vRPC.PlayAnim(source, true, { "anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.ChemicalTimer(Passport, 10)
					TriggerClientEvent("Cocaine", source)
					TriggerClientEvent("Energetic", source, 15, 1.20)

					local Ped = GetPlayerPed(source)
					local Coords = GetEntityCoords(Ped)
					for k, v in pairs(DrugsInfluences) do
						local Distance = #(Coords - vec3(v[1], v[2], v[3]))
						if Distance <= v[4] then
							TriggerClientEvent("Energetic", source, 30, 1.20)
							TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 300)
							TriggerClientEvent("Notify", source, "verde", "Você recebeu um <b>Bônus</b> pela <b>Área</b>.", "Sucesso", 5000)
						end
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["meth"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Armors[Passport] then
			if os.time() < Armors[Passport] then
				local armorTimers = parseInt(Armors[Passport] - os.time())
				TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. armorTimers .. "</b> segundos.", false, 5000)
				return
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Inalando", 10000)
		vRPC.PlayAnim(source, true, { "anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local RandomCough = math.random(100)
					if RandomCough >= 50 then
						vRP.UpgradeCough(Passport, math.random(2))
					end

					TriggerClientEvent("Methamphetamine", source)
					Armors[Passport] = os.time() + 60
					vRP.ChemicalTimer(Passport, 10)
					vRPC.UpgradeHealth(source, 15)

					local Ped = GetPlayerPed(source)
					local Coords = GetEntityCoords(Ped)
					for k, v in pairs(DrugsInfluences) do
						local Distance = #(Coords - vec3(v[1], v[2], v[3]))
						if Distance <= v[4] then
							vRPC.UpgradeHealth(source, 30)
							TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 300)
							TriggerClientEvent("Notify", source, "verde", "Você recebeu um <b>Bônus</b> pela <b>Área</b>.", "Sucesso", 5000)
						end
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["metadone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Armors[Passport] then
			if os.time() < Armors[Passport] then
				local armorTimers = parseInt(Armors[Passport] - os.time())
				TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. armorTimers .. "</b> segundos.", false, 5000)
				return
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Inalando", 10000)
		vRPC.PlayAnim(source, true, { "anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("Metadone", source)
					Armors[Passport] = os.time() + 60
					vRP.ChemicalTimer(Passport, 10)
					vRP.SetArmour(source, 10)

					local Ped = GetPlayerPed(source)
					local Coords = GetEntityCoords(Ped)
					for k, v in pairs(DrugsInfluences) do
						local Distance = #(Coords - vec3(v[1], v[2], v[3]))
						if Distance <= v[4] then
							vRP.SetArmour(source, 20)
							TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 300)
							TriggerClientEvent("Notify", source, "verde", "Você recebeu um <b>Bônus</b> pela <b>Área</b>.", "Sucesso", 5000)
						end
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["heroin"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Heroin[Passport] then
			if os.time() < Heroin[Passport] then
				local HeroinTimers = parseInt(Heroin[Passport] - os.time())
				TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. HeroinTimers .. "</b> segundos.", false, 5000)
				return
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Inalando", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_int_uppersmoke", "mp_player_int_smoke" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					Heroin[Passport] = os.time() + 60
					vRP.UpgradeThirst(Passport, 100)
					vRP.UpgradeHunger(Passport, 100)
					vRP.ChemicalTimer(Passport, 10)
					vRPC.UpgradeHealth(source, 50)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["backpack"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Name = "Comum"
		local Consult = vRP.GetServerData("Backpacks:"..Passport)
		if not Consult[Name] then
			if vRP.TakeItem(Passport,Full,1,false,Slot) then
				Consult[Name] = { ["id"] = 1, ["weight"] = 100, ["type"] = "backpack" }
				vRP.SetServerData("Backpacks:"..Passport, Consult)

				vRP.SetWeight(Passport, 100)
				TriggerClientEvent("inventory:Update", source, "Backpack")
				TriggerClientEvent("Notify", source, "verde", "<b>"..itemName(Item).."</b> usada.", "Sucesso", 5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Mochila já possuída.","Atenção",5000)
		end
	end,

	["suitcase"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split and Split[3] then
			TriggerClientEvent("chest:Open", source, "suitcase:"..Split[3], "Item")
			TriggerClientEvent("inventory:Close", source)
		end
	end,

	["protectorcase"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split and Split[3] then
			TriggerClientEvent("chest:Open", source, "protectorcase:"..Split[3], "Item")
			TriggerClientEvent("inventory:Close", source)
		end
	end,

	["cupholder"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split and Split[3] then
			TriggerClientEvent("chest:Open", source, "cupholder:"..Split[3], "Item")
			TriggerClientEvent("inventory:Close", source)
		end
	end,

	["backpackp"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split and Split[3] then
			TriggerClientEvent("chest:Open", source, "backpackp:"..Split[3], "Item")
			TriggerClientEvent("inventory:Close",source)
		end
	end,

	["backpackm"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split and Split[3] then
			TriggerClientEvent("chest:Open", source, "backpackm:"..Split[3], "Item")
			TriggerClientEvent("inventory:Close",source)
		end
	end,

	["backpackg"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split and Split[3] then
			TriggerClientEvent("chest:Open", source, "backpackg:"..Split[3], "Item")
			TriggerClientEvent("inventory:Close",source)
		end
	end,

	["pokeball"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Jogando", 1750)
		vRPC.PlayAnim(source, true, { "anim@mp_player_intcelebrationmale@wank", "wank" }, true)

		Wait(1750)

		vRPC.Destroy(source)
		Active[Passport] = nil
		Player(source)["state"]["Buttons"] = false

		if vRP.TakeItem(Passport, Full, 1, false, Slot) then
			local Randomize = math.random(151)
			local NameItem = NumberPokemon(Randomize)

			vRP.GenerateItem(Passport, "pokemon"..NameItem, 1)

			local Players = vRPC.Players(source)
			for _,v in pairs(Players) do
				async(function()
					TriggerClientEvent("showme:pressMe", v, source, "<img src='nui://vrp/config/inventory/pokemon"..NameItem..".png'>", 5, true)
				end)
			end
		end
	end,

	["bandage"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			if vRP.GetHealth(source) > 100 and vRP.GetHealth(source) < 200 then
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Passando", 5000)
				vRPC.PlayAnim(source, true, { "amb@world_human_clipboard@male@idle_a", "idle_c" }, true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.StopAnim(source, false)
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							TriggerClientEvent("sounds:Private", source, "bandage", 0.5)
							Healths[Passport] = os.time() + 30
							vRP.UpgradeStress(Passport, 2)
							vRPC.UpgradeHealth(source, 15)
						end
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify", source, "amarelo", "Não pode utilizar de vida cheia ou nocauteado.", "Atenção", 5000)
			end
		else
			local Timer = parseInt(Healths[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",false,5000)
		end
	end,

	["codeine"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Codeine[Passport] or os.time() > Codeine[Passport]) then
			if vRP.GetHealth(source) > 100 and vRP.GetHealth(source) < 200 then
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Passando", 5000)
				vRPC.PlayAnim(source, true, { "amb@world_human_clipboard@male@idle_a", "idle_c" }, true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.StopAnim(source, false)
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							Codeine[Passport] = os.time() + 30
							vRP.UpgradeStress(Passport, 2)
							vRPC.UpgradeHealth(source, 30)
						end
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify", source, "amarelo", "Não pode utilizar de vida cheia ou nocauteado.", "Atenção", 5000)
			end
		else
			local Timer = parseInt(Codeine[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",false,5000)
		end
	end,

	["sulfuric"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 3
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 3000)
		vRPC.PlayAnim(source, true, { "mp_suicide", "pill" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source, false)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRPC.DowngradeHealth(source, 100)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["amphetamine"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Amphetamine[Passport] or os.time() > Amphetamine[Passport]) then
			Active[Passport] = os.time() + 3
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Tomando", 3000)
			vRPC.PlayAnim(source, true, { "mp_suicide", "pill" }, true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.StopAnim(source, false)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						Amphetamine[Passport] = os.time() + 15
						vRP.DowngradeCough(Passport, 100)
						vRP.DowngradeStress(Passport, 50)
						vRPC.UpgradeHealth(source, 5)
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			local Timer = parseInt(Amphetamine[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",false,5000)
		end
	end,

	["analgesic"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			if vRP.GetHealth(source) > 100 and vRP.GetHealth(source) < 200 then
				Active[Passport] = os.time() + 3
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Tomando", 3000)
				vRPC.PlayAnim(source, true, { "mp_suicide", "pill" }, true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.StopAnim(source, false)
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							Healths[Passport] = os.time() + 15
							vRP.UpgradeStress(Passport, 1)
							vRPC.UpgradeHealth(source, 8)
						end
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify", source, "amarelo", "Não pode utilizar de vida cheia ou nocauteado.", "Atenção", 5000)
			end
		else
			local Timer = parseInt(Healths[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",false,5000)
		end
	end,

	["expectorant"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			Active[Passport] = os.time() + 3
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Tomando", 3000)
			vRPC.PlayAnim(source, true, { "mp_suicide", "pill" }, true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.StopAnim(source, false)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						Healths[Passport] = os.time() + 15
						vRP.DowngradeCough(Passport, 100)
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			local Timer = parseInt(Healths[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",false,5000)
		end
	end,

	["oxy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			if vRP.GetHealth(source) > 100 and vRP.GetHealth(source) < 200 then
				Active[Passport] = os.time() + 3
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Tomando", 3000)
				vRPC.PlayAnim(source, true, { "mp_suicide", "pill" }, true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.StopAnim(source, false)
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							Healths[Passport] = os.time() + 15

							vRPC.UpgradeHealth(source, 10)
							vRP.UpgradeStress(Passport, math.random(2, 4))
						end
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify", source, "amarelo", "Não pode utilizar de vida cheia ou nocauteado.", "Atenção", 5000)
			end
		else
			local Timer = parseInt(Healths[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",false,5000)
		end
	end,

	["vehkey"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Vehicle, Network, Plate = vRPC.VehicleList(source, 5)
		if Vehicle then
			if Plate == Split[2] then
				TriggerEvent("garages:LockVehicle", source, Network)
			end
		end
	end,

	["newchars"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			vRP.UpgradeChars(source)
			TriggerClientEvent("inventory:Update",source,"Backpack")
			TriggerClientEvent("Notify", source, "verde", "Personagem liberado.", "Sucesso", 5000)
		end
	end,

	["gemstone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport, Full, Amount, false, Slot) then
			TriggerClientEvent("inventory:Update",source,"Backpack")
			vRP.UpgradeGemstone(Passport, Amount)
		end
	end,

	["namechange"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)

		local Keyboard = vKEYBOARD.Secondary(source, "Nome:", "Sobrenome:")
		if Keyboard then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				TriggerClientEvent("Notify", source, "verde", "Passaporte atualizado.", "Sucesso", 5000)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				vRP.UpgradeNames(Passport, Keyboard[1], Keyboard[2])
			end
		end
	end,

	["chip"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)

		local Keyboard = vKEYBOARD.Secondary(source, "Três primeiros digitos:", "Três ultimos digitos:")
		if Keyboard then
			local Fir = sanitizeString(Keyboard[1], "0123456789", true)
			local Sec = sanitizeString(Keyboard[2], "0123456789", true)
			if string.len(Fir) == 3 and string.len(Sec) == 3 then
				if not vRP.UserPhone(Keyboard[1] .. "-" .. Keyboard[2]) then
					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						TriggerClientEvent("Notify", source, "verde", "Telefone atualizado.", "Sucesso", 5000)
						TriggerClientEvent("inventory:Update",source,"Backpack")
						vRP.UpgradePhone(Passport, Keyboard[1] .. "-" .. Keyboard[2])
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "O número escolhido já possui um proprietário.", "Atenção", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "O número telefônico deve conter 6 dígitos e somente números.", "Aviso", 5000)
			end
		end
	end,

	["dices"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Jogando", 1750)
		vRPC.PlayAnim(source, true, { "anim@mp_player_intcelebrationmale@wank", "wank" }, true)

		Wait(1750)

		Active[Passport] = nil
		vRPC.StopAnim(source, false)
		Player(source)["state"]["Buttons"] = false

		local Dice = math.random(6)
		local Players = vRPC.Players(source)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("showme:pressMe", v, source, "<img src='images/"..Dice..".png'>", 10, true)
			end)
		end
	end,

	["deck"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)

		local Card = math.random(13)
		local Cards = { "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K" }

		local Naipe = math.random(4)
		local Naipes = { "<black>♣</black>", "<red>♠</red>", "<black>♦</black>", "<red>♥</red>" }

		local Players = vRPC.ClosestPeds(source, 5)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("chat:ClientMessage", v, vRP.FullName(Passport), "Tirou "..Cards[Card]..Naipes[Naipe].." do baralho", itemName("deck"))
			end)
		end
	end,

	["silvercoin"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Jogando", 1750)
		vRPC.PlayAnim(source, true, { "anim@mp_player_intcelebrationmale@wank", "wank" }, true)

		Wait(1750)

		Active[Passport] = nil
		vRPC.StopAnim(source, false)
		Player(source)["state"]["Buttons"] = false

		local Coins = math.random(2)
		local Sides = { "Cara", "Coroa" }
		local Players = vRPC.ClosestPeds(source, 5)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("chat:ClientMessage", v, vRP.FullName(Passport), Sides[Coins], itemName("silvercoin"))
			end)
		end
	end,

	["goldcoin"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Jogando", 1750)
		vRPC.PlayAnim(source, true, { "anim@mp_player_intcelebrationmale@wank", "wank" }, true)

		Wait(1750)

		Active[Passport] = nil
		vRPC.StopAnim(source, false)
		Player(source)["state"]["Buttons"] = false

		local Coins = math.random(2)
		local Sides = { "Cara", "Coroa" }

		local Players = vRPC.ClosestPeds(source, 5)
		for _, v in pairs(Players) do
			async(function()
				TriggerClientEvent("chat:ClientMessage", v, vRP.FullName(Passport), Sides[Coins], itemName("goldcoin"))
			end)
		end
	end,

	["soap"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vPLAYER.checkSoap(source) ~= nil then
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Usando", 10000)
			vRPC.PlayAnim(source, false, { "amb@world_human_bum_wash@male@high@base", "base" }, true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.Destroy(source)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						TriggerClientEvent("player:Residuals", source)
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end,

	["lean"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 3
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 3000)
		vRPC.PlayAnim(source, true, { "mp_suicide", "pill" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local RandomCough = math.random(100)
					if RandomCough >= 50 then
						vRP.UpgradeCough(Passport, math.random(2))
					end

					TriggerClientEvent("CleanEffectDrugs", source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["joint"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.ConsultItem(Passport, "lighter", 1) then
			Active[Passport] = os.time() + 30
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Fumando", 30000)
			vRPC.CreateObjects(source, "amb@world_human_aa_smoke@male@idle_a", "idle_c", "prop_cs_ciggy_01", 49, 28422)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.Destroy(source)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Points = 0
						if Split[2] ~= nil then
							Points = parseInt(Split[2])
						end

						local RandomCough = math.random(100)
						if RandomCough >= 50 then
							vRP.UpgradeCough(Passport, math.random(2))
						end

						vRP.WeedTimer(Passport, 5)

						vRP.DowngradeHunger(Passport, 5 + (0.1 * Points))
						vRP.DowngradeThirst(Passport, 5 + (0.1 * Points))
						vRP.DowngradeStress(Passport, 10 + (0.1 * Points))

						local Ped = GetPlayerPed(source)
						local Coords = GetEntityCoords(Ped)
						for k, v in pairs(DrugsInfluences) do
							local Distance = #(Coords - vec3(v[1], v[2], v[3]))
							if Distance <= v[4] then
								vRP.WeedTimer(Passport, 5)
								vRP.DowngradeStress(Passport, 10 + (0.1 * Points))
								TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 300)
								TriggerClientEvent("Notify", source, "verde", "Você recebeu um <b>Bônus</b> pela <b>Área</b>.", "Sucesso", 5000)
							end
						end

						TriggerClientEvent("Joint", source)
						vPLAYER.movementClip(source, "move_m@shadyped@a")
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>1x " .. itemName("lighter") .. "</b>.", "Atenção", 5000)
		end
	end,

	["crack"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.ConsultItem(Passport, "lighter", 1) then
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Fumando", 10000)
			vRPC.CreateObjects(source, "amb@world_human_aa_smoke@male@idle_a", "idle_c", "prop_cs_ciggy_01", 49, 28422)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.Destroy(source)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Points = 0
						if Split[2] ~= nil then
							Points = parseInt(Split[2])
						end

						local RandomCough = math.random(100)
						if RandomCough >= 50 then
							vRP.UpgradeCough(Passport, math.random(2))
						end

						TriggerClientEvent("Energetic", source, 30, 1.20)
						vRP.DowngradeStress(Passport, 10 + (0.1 * Points))

						local Ped = GetPlayerPed(source)
						local Coords = GetEntityCoords(Ped)
						for k, v in pairs(DrugsInfluences) do
							local Distance = #(Coords - vec3(v[1], v[2], v[3]))
							if Distance <= v[4] then
								TriggerClientEvent("Energetic", source, 60, 1.40)
								vRP.DowngradeStress(Passport, 10 + (0.1 * Points))
								TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 300)
								TriggerClientEvent("Notify", source, "verde", "Você recebeu um <b>Bônus</b> pela <b>Área</b>.", "Sucesso", 5000)
							end
						end

						TriggerClientEvent("Crack", source)
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>1x " .. itemName("lighter") .. "</b>.", "Atenção", 5000)
		end
	end,

	["cigarette"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.ConsultItem(Passport, "lighter", 1) then
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Fumando", 10000)
			vRPC.CreateObjects(source, "amb@world_human_aa_smoke@male@idle_a", "idle_c", "prop_cs_ciggy_01", 49, 28422)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.Destroy(source)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vRP.DowngradeStress(Passport, 5)
						vRP.UpgradeCough(Passport, 2)

						local Ped = GetPlayerPed(source)
						local Coords = GetEntityCoords(Ped)
						for k, v in pairs(DrugsInfluences) do
							local Distance = #(Coords - vec3(v[1], v[2], v[3]))
							if Distance <= v[4] then
								vRP.DowngradeStress(Passport, 5)
								TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 300)
								TriggerClientEvent("Notify", source, "verde", "Você recebeu um <b>Bônus</b> pela <b>Área</b>.", "Sucesso", 5000)
							end
						end
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>1x " .. itemName("lighter") .. "</b>.", "Atenção", 5000)
		end
	end,

	["vape"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 15
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Fumando", 15000)
		vRPC.CreateObjects(source, "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "ba_prop_battle_vape_01", 49, 18905, 0.08, -0.00, 0.03, -150.0, 90.0, -10.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRP.DowngradeStress(Passport, 20)
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false
			end

			Wait(100)
		until not Active[Passport]
	end,

	["medkit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			if vRP.GetHealth(source) > 100 and vRP.GetHealth(source) < 200 then
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Passando", 10000)
				vRPC.PlayAnim(source, true, { "amb@world_human_clipboard@male@idle_a", "idle_c" }, true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.StopAnim(source, false)
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							Healths[Passport] = os.time() + 60
							vRPC.UpgradeHealth(source, 40)
						end
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify", source, "amarelo", "Não pode utilizar de vida cheia ou nocauteado.", "Atenção", 5000)
			end
		else
			local Timer = parseInt(Healths[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",false,5000)
		end
	end,

	["gauze"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vPARAMEDIC.Bleeding(source) > 0 then
			Active[Passport] = os.time() + 3
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Passando", 3000)
			vRPC.PlayAnim(source, true, { "amb@world_human_clipboard@male@idle_a", "idle_c" }, true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.StopAnim(source, false)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vPARAMEDIC.Bandage(source)
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			TriggerClientEvent("Notify", source, "default", "Nenhum ferimento encontrado.", false, 5000)
		end
	end,

	["binoculars"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Ped = GetPlayerPed(source)
		if GetSelectedPedWeapon(Ped) ~= GetHashKey("WEAPON_UNARMED") then
			return
		end

		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("inventory:Camera", source, true)
	end,

	["camera"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Ped = GetPlayerPed(source)
		if GetSelectedPedWeapon(Ped) ~= GetHashKey("WEAPON_UNARMED") then
			return
		end

		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("freecam:Active", source)
	end,

	["evidence01"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		for k, v in pairs(Microscope) do
			local Distance = #(Coords - vec3(v[1], v[2], v[3]))
			if Distance <= 1 then
				TriggerClientEvent("Notify", source, "amarelo", "Evidência de <b>"..vRP.FullName(Split[2]).."</b>.", "Atenção", 10000)
				break
			end
		end
	end,

	["evidence02"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		for k, v in pairs(Microscope) do
			local Distance = #(Coords - vec3(v[1], v[2], v[3]))
			if Distance <= 1 then
				TriggerClientEvent("Notify", source, "amarelo", "Evidência de <b>"..vRP.FullName(Split[2]).."</b>.", "Atenção", 10000)
				break
			end
		end
	end,

	["evidence03"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		for k, v in pairs(Microscope) do
			local Distance = #(Coords - vec3(v[1], v[2], v[3]))
			if Distance <= 1 then
				TriggerClientEvent("Notify", source, "amarelo", "Evidência de <b>"..vRP.FullName(Split[2]).."</b>.", "Atenção", 10000)
				break
			end
		end
	end,

	["evidence04"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		for k, v in pairs(Microscope) do
			local Distance = #(Coords - vec3(v[1], v[2], v[3]))
			if Distance <= 1 then
				TriggerClientEvent("Notify", source, "amarelo", "Evidência de <b>"..vRP.FullName(Split[2]).."</b>.", "Atenção", 10000)
				break
			end
		end
	end,

	["teddy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		vRPC.CreateObjects(source, "impexp_int-0", "mp_m_waremech_01_dual-0", "v_ilev_mr_rasberryclean", 49, 24817, -0.20, 0.46, -0.016, -180.0, -90.0, 0.0)
	end,

	["rose"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		vRPC.CreateObjects(source, "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "prop_single_rose", 49, 18905, 0.13, 0.15, 0.0, -100.0, 0.0, -20.0)
	end,

	["watch"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Notify", source, "default", "Agora são: <b>" .. parseInt(GlobalState["Hours"]) .. ":" .. parseInt(GlobalState["Minutes"]) .. "</b>.", false, 5000)
	end,

	["firecracker"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) and not vCLIENT.checkCracker(source) then
			Active[Passport] = os.time() + 3
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Acendendo", 3000)
			vRPC.PlayAnim(source, false, { "anim@mp_fireworks", "place_firework_3_box" }, true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.StopAnim(source, false)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						TriggerClientEvent("inventory:Firecracker", source)
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end,

	["ration"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		for k,v in pairs(HunterInfluences) do
			local Coords = vRP.GetEntityCoords(source)
			local Distance = #(Coords - vec3(v[1], v[2], v[3]))
			if Distance <= v[4] then
				if vRP.GetWork(Passport) == "Hunter" then
					if not vRPC.InsideVehicle(source) and not vCLIENT.CheckRation(source) then
						Active[Passport] = os.time() + 5
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("Progress", source, "Chamando animal", 5000)
						vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

						repeat
							if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								vRPC.StopAnim(source, false)
								Player(source)["state"]["Buttons"] = false

								if vRP.TakeItem(Passport,Full,1,true,Slot) then
									Player(source)["state"]["Hunting"] = true
									TriggerClientEvent("inventory:Ration", source, Coords)
								end
							end

							Wait(100)
						until not Active[Passport]
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Você não tem permissões.", "Atenção", 5000)
				end
			end
		end
	end,

	["adrenaline"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source, 2)
		if ClosestPed then
			if vCLIENT.Clandestine(source) then
				if vRP.GetHealth(ClosestPed) <= 101 then
					Active[Passport] = os.time() + 15
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("Progress", source, "Usando", 15000)
					vRPC.PlayAnim(source, false, { "mini@cpr@char_a@cpr_str", "cpr_pumpchest" }, true)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.StopAnim(source, false)
							Player(source)["state"]["Buttons"] = false

							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								vRP.UpgradeStress(Passport, 5)
								vRP.Revive(ClosestPed, 120)
							end
						end

						Wait(100)
					until not Active[Passport]
				else
					TriggerClientEvent("Notify", source, "amarelo", "Você não pode usar em pessoas vivas.", "Atenção", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você não pode usar isto aqui.", "Atenção", 5000)
			end
		end
	end,

	["gsrkit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source, 2)
		if ClosestPed then
			Active[Passport] = os.time() + 5
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Usando", 5000)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Informations = vPLAYER.checkSoap(ClosestPed)
						if Informations then
							local Number = 0
							local Message = ""

							for Value, v in pairs(Informations) do
								Number = Number + 1
								Message = Message .. "<b>" .. Number .. "</b>: " .. Value .. "<br>"
							end

							TriggerClientEvent("Notify", source, "default", Message, "Kit Residual", 10000)
						else
							TriggerClientEvent("Notify", source, "default", "Nenhum resultado encontrado.", "Kit Residual", 5000)
						end
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end,

	["gdtkit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source, 2)
		if ClosestPed then
			local OtherPassport = vRP.Passport(ClosestPed)
			local Identity = vRP.Identity(OtherPassport)
			if OtherPassport and Identity then
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Usando", 5000)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							local weed = vRP.WeedReturn(OtherPassport)
							local chemical = vRP.ChemicalReturn(OtherPassport)
							local alcohol = vRP.AlcoholReturn(OtherPassport)

							local chemStr = ""
							local alcoholStr = ""
							local weedStr = ""

							if chemical == 0 then
								chemStr = "Nenhum"
							elseif chemical == 1 then
								chemStr = "Baixo"
							elseif chemical == 2 then
								chemStr = "Médio"
							elseif chemical >= 3 then
								chemStr = "Alto"
							end

							if alcohol == 0 then
								alcoholStr = "Nenhum"
							elseif alcohol == 1 then
								alcoholStr = "Baixo"
							elseif alcohol == 2 then
								alcoholStr = "Médio"
							elseif alcohol >= 3 then
								alcoholStr = "Alto"
							end

							if weed == 0 then
								weedStr = "Nenhum"
							elseif weed == 1 then
								weedStr = "Baixo"
							elseif weed == 2 then
								weedStr = "Médio"
							elseif weed >= 3 then
								weedStr = "Alto"
							end

							TriggerClientEvent("Notify", source, "default", "<b>Químicos:</b> " .. chemStr .. "<br><b>Álcool:</b> " .. alcoholStr .. "<br><b>Drogas:</b> " .. weedStr, "Kit Residual", 10000)
						end
					end

					Wait(100)
				until not Active[Passport]
			end
		end
	end,

	["nitro"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate = vRPC.VehicleList(source, 4)
			if Vehicle then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress", source, "Trocando", 10000)
				TriggerClientEvent("player:VehicleHood", source, Network, "open")
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.StopAnim(source, false)
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							local Nitro = GlobalState["Nitro"]
							Nitro[Plate] = 2000
							GlobalState:set("Nitro", Nitro, true)
						end
					end

					Wait(100)
				until not Active[Passport]

				TriggerClientEvent("player:VehicleHood", source, Network, "close")
			end
		end
	end,

	["vest"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Armors[Passport] then
			if os.time() < Armors[Passport] then
				local armorTimers = parseInt(Armors[Passport] - os.time())
				TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. armorTimers .. "</b> segundos.", false, 5000)
				return
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Vestindo", 10000)
		vRPC.PlayAnim(source, true, { "clothingtie", "try_tie_negative_a" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source, false)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					Armors[Passport] = os.time() + 1800
					vRP.SetArmour(source, 100)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["GADGET_PARACHUTE"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 3
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Usando", 3000)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vCLIENT.Parachute(source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["advtoolbox"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate = vRPC.VehicleList(source, 4)
			if Vehicle then
				vRPC.AnimActive(source)
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				local Players = vRPC.Players(source)
				for _, v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood", v, Network, "open")
					end)
				end

				if vRP.Task(source, 5, 10000) then
					Active[Passport] = os.time() + 15
					TriggerClientEvent("Progress", source, "Reparando", 15000)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil

							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								local Players = vRPC.Players(source)
								for _, v in pairs(Players) do
									async(function()
										TriggerClientEvent("inventory:repairVehicle", v, Network, Plate)
									end)
								end

								local Number = parseInt(Split[2]) - 1

								if Number >= 1 then
									vRP.GiveItem(Passport, "advtoolbox-" .. Number, 1, false)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				end

				local Players = vRPC.Players(source)
				for _, v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood", v, Network, "close")
					end)
				end

				Player(source)["state"]["Buttons"] = false
				Active[Passport] = nil
				vRPC.Destroy(source)
			end
		end
	end,

	["enginea"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["11"] then
							Datatable["mods"]["11"] = -1
						end

						if Datatable["mods"]["11"] == -1 then
							if Datatable["mods"]["11"] >= vCLIENT.CheckMods(source, Vehicle, 11) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite do <b>Motor</b> atingido.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["11"] = Datatable["mods"]["11"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 11, Datatable["mods"]["11"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo do <b>Motor</b> incorreto.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["engineb"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["11"] then
							Datatable["mods"]["11"] = -1
						end

						if Datatable["mods"]["11"] == 0 then
							if Datatable["mods"]["11"] >= vCLIENT.CheckMods(source, Vehicle, 11) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite do <b>Motor</b> atingido.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["11"] = Datatable["mods"]["11"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 11, Datatable["mods"]["11"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo do <b>Motor</b> incorreto.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["enginec"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["11"] then
							Datatable["mods"]["11"] = -1
						end

						if Datatable["mods"]["11"] == 1 then
							if Datatable["mods"]["11"] >= vCLIENT.CheckMods(source, Vehicle, 11) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite do <b>Motor</b> atingido.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["11"] = Datatable["mods"]["11"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 11, Datatable["mods"]["11"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo do <b>Motor</b> incorreto.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["engined"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["11"] then
							Datatable["mods"]["11"] = -1
						end

						if Datatable["mods"]["11"] == 2 then
							if Datatable["mods"]["11"] >= vCLIENT.CheckMods(source, Vehicle, 11) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite do <b>Motor</b> atingido.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["11"] = Datatable["mods"]["11"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 11, Datatable["mods"]["11"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo do <b>Motor</b> incorreto.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["enginee"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["11"] then
							Datatable["mods"]["11"] = -1
						end

						if Datatable["mods"]["11"] == 3 then
							if Datatable["mods"]["11"] >= vCLIENT.CheckMods(source, Vehicle, 11) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite do <b>Motor</b> atingido.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["11"] = Datatable["mods"]["11"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 11, Datatable["mods"]["11"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo do <b>Motor</b> incorreto.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["brakea"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["12"] then
							Datatable["mods"]["12"] = -1
						end

						if Datatable["mods"]["12"] == -1 then
							if Datatable["mods"]["12"] >= vCLIENT.CheckMods(source, Vehicle, 12) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite do <b>Freio</b> atingido.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["12"] = Datatable["mods"]["12"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 12, Datatable["mods"]["12"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo do <b>Freio</b> incorreto.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["brakeb"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["12"] then
							Datatable["mods"]["12"] = -1
						end

						if Datatable["mods"]["12"] == 0 then
							if Datatable["mods"]["12"] >= vCLIENT.CheckMods(source, Vehicle, 12) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite do <b>Freio</b> atingido.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["12"] = Datatable["mods"]["12"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 12, Datatable["mods"]["12"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo do <b>Freio</b> incorreto.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["brakec"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["12"] then
							Datatable["mods"]["12"] = -1
						end

						if Datatable["mods"]["12"] == 1 then
							if Datatable["mods"]["12"] >= vCLIENT.CheckMods(source, Vehicle, 12) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite do <b>Freio</b> atingido.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["12"] = Datatable["mods"]["12"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 12, Datatable["mods"]["12"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo do <b>Freio</b> incorreto.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["braked"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["12"] then
							Datatable["mods"]["12"] = -1
						end

						if Datatable["mods"]["12"] == 2 then
							if Datatable["mods"]["12"] >= vCLIENT.CheckMods(source, Vehicle, 12) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite do <b>Freio</b> atingido.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["12"] = Datatable["mods"]["12"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 12, Datatable["mods"]["12"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo do <b>Freio</b> incorreto.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["brakee"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["12"] then
							Datatable["mods"]["12"] = -1
						end

						if Datatable["mods"]["12"] == 3 then
							if Datatable["mods"]["12"] >= vCLIENT.CheckMods(source, Vehicle, 12) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite do <b>Freio</b> atingido.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["12"] = Datatable["mods"]["12"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 12, Datatable["mods"]["12"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo do <b>Freio</b> incorreto.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["transmissiona"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["13"] then
							Datatable["mods"]["13"] = -1
						end

						if Datatable["mods"]["13"] == -1 then
							if Datatable["mods"]["13"] >= vCLIENT.CheckMods(source, Vehicle, 13) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite da <b>Transmissão</b> atingida.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["13"] = Datatable["mods"]["13"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 13, Datatable["mods"]["13"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo da <b>Transmissão</b> incorreta.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["transmissionb"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["13"] then
							Datatable["mods"]["13"] = -1
						end

						if Datatable["mods"]["13"] == 0 then
							if Datatable["mods"]["13"] >= vCLIENT.CheckMods(source, Vehicle, 13) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite da <b>Transmissão</b> atingida.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["13"] = Datatable["mods"]["13"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 13, Datatable["mods"]["13"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo da <b>Transmissão</b> incorreta.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["transmissionc"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["13"] then
							Datatable["mods"]["13"] = -1
						end

						if Datatable["mods"]["13"] == 1 then
							if Datatable["mods"]["13"] >= vCLIENT.CheckMods(source, Vehicle, 13) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite da <b>Transmissão</b> atingida.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["13"] = Datatable["mods"]["13"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 13, Datatable["mods"]["13"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo da <b>Transmissão</b> incorreta.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["transmissiond"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["13"] then
							Datatable["mods"]["13"] = -1
						end

						if Datatable["mods"]["13"] == 2 then
							if Datatable["mods"]["13"] >= vCLIENT.CheckMods(source, Vehicle, 13) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite da <b>Transmissão</b> atingida.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["13"] = Datatable["mods"]["13"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 13, Datatable["mods"]["13"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo da <b>Transmissão</b> incorreta.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["transmissione"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				local PassportPlate = vRP.PassportPlate(Plate)
				if PassportPlate then
					local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
					if parseInt(#Datatable) > 0 then
						Datatable = json.decode(Datatable[1]["Information"])

						if not Datatable["mods"]["13"] then
							Datatable["mods"]["13"] = -1
						end

						if Datatable["mods"]["13"] == 3 then
							if Datatable["mods"]["13"] >= vCLIENT.CheckMods(source, Vehicle, 13) then
								TriggerClientEvent("Notify", source, "amarelo", "Limite da <b>Transmissão</b> atingida.", "Atenção", 5000)
							else
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 1000
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("player:VehicleHood", source, Network, "open")
								vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

								if vRP.Task(source, 8, 20500) then
									Active[Passport] = os.time() + 120
									TriggerClientEvent("Progress", source, "Aplicando", 120000)

									repeat
										if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil
											vRPC.Destroy(source)
											Player(source)["state"]["Buttons"] = false

											if vRP.TakeItem(Passport,Full,1,true,Slot) then
												Datatable["mods"]["13"] = Datatable["mods"]["13"] + 1
												vCLIENT.ActiveMods(source, Network, Plate, 13, Datatable["mods"]["13"])
												vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
											end
										end

										Wait(100)
									until not Active[Passport]
								end

								TriggerClientEvent("player:VehicleHood", source, Network, "close")
								Player(source)["state"]["Buttons"] = false
								vRPC.StopAnim(source, false)
								Active[Passport] = nil
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "Modelo da <b>Transmissão</b> incorreta.", "Aviso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
					end
				end
			end
		end
	end,

	["suspensiona"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				if vCLIENT.CheckCar(source, Vehicle) then
					local PassportPlate = vRP.PassportPlate(Plate)
					if PassportPlate then
						local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
						if parseInt(#Datatable) > 0 then
							Datatable = json.decode(Datatable[1]["Information"])

							if not Datatable["mods"]["15"] then
								Datatable["mods"]["15"] = -1
							end

							if Datatable["mods"]["15"] == -1 then
								if Datatable["mods"]["15"] >= vCLIENT.CheckMods(source, Vehicle, 15) then
									TriggerClientEvent("Notify", source, "amarelo", "Limite da <b>Suspensão</b> atingida.", "Atenção", 5000)
								else
									vRPC.AnimActive(source)
									Active[Passport] = os.time() + 1000
									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close",source)
									TriggerClientEvent("player:VehicleHood", source, Network, "open")
									vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

									if vRP.Task(source, 8, 20500) then
										Active[Passport] = os.time() + 120
										TriggerClientEvent("Progress", source, "Aplicando", 120000)

										repeat
											if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
												Active[Passport] = nil
												vRPC.Destroy(source)
												Player(source)["state"]["Buttons"] = false

												if vRP.TakeItem(Passport,Full,1,true,Slot) then
													Datatable["mods"]["15"] = Datatable["mods"]["15"] + 1
													vCLIENT.ActiveMods(source, Network, Plate, 15, Datatable["mods"]["15"])
													vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
												end
											end

											Wait(100)
										until not Active[Passport]
									end

									TriggerClientEvent("player:VehicleHood", source, Network, "close")
									Player(source)["state"]["Buttons"] = false
									vRPC.StopAnim(source, false)
									Active[Passport] = nil
								end
							else
								TriggerClientEvent("Notify", source, "vermelho", "Modelo da <b>Suspensão</b> incorreta.", "Aviso", 5000)
							end
						else
							TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
						end
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "O veículo <b>" .. VehicleName(vehName) .. "</b> não possui suspensão.", "Atenção", 5000)
				end
			end
		end
	end,

	["suspensionb"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				if vCLIENT.CheckCar(source, Vehicle) then
					local PassportPlate = vRP.PassportPlate(Plate)
					if PassportPlate then
						local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
						if parseInt(#Datatable) > 0 then
							Datatable = json.decode(Datatable[1]["Information"])

							if not Datatable["mods"]["15"] then
								Datatable["mods"]["15"] = -1
							end

							if Datatable["mods"]["15"] == 0 then
								if Datatable["mods"]["15"] >= vCLIENT.CheckMods(source, Vehicle, 15) then
									TriggerClientEvent("Notify", source, "amarelo", "Limite da <b>Suspensão</b> atingida.", "Atenção", 5000)
								else
									vRPC.AnimActive(source)
									Active[Passport] = os.time() + 1000
									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close",source)
									TriggerClientEvent("player:VehicleHood", source, Network, "open")
									vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

									if vRP.Task(source, 8, 20500) then
										Active[Passport] = os.time() + 120
										TriggerClientEvent("Progress", source, "Aplicando", 120000)

										repeat
											if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
												Active[Passport] = nil
												vRPC.Destroy(source)
												Player(source)["state"]["Buttons"] = false

												if vRP.TakeItem(Passport,Full,1,true,Slot) then
													Datatable["mods"]["15"] = Datatable["mods"]["15"] + 1
													vCLIENT.ActiveMods(source, Network, Plate, 15, Datatable["mods"]["15"])
													vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
												end
											end

											Wait(100)
										until not Active[Passport]
									end

									TriggerClientEvent("player:VehicleHood", source, Network, "close")
									Player(source)["state"]["Buttons"] = false
									vRPC.StopAnim(source, false)
									Active[Passport] = nil
								end
							else
								TriggerClientEvent("Notify", source, "vermelho", "Modelo da <b>Suspensão</b> incorreta.", "Aviso", 5000)
							end
						else
							TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
						end
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "O veículo <b>" .. VehicleName(vehName) .. "</b> não possui suspensão.", "Atenção", 5000)
				end
			end
		end
	end,

	["suspensionc"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				if vCLIENT.CheckCar(source, Vehicle) then
					local PassportPlate = vRP.PassportPlate(Plate)
					if PassportPlate then
						local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
						if parseInt(#Datatable) > 0 then
							Datatable = json.decode(Datatable[1]["Information"])

							if not Datatable["mods"]["15"] then
								Datatable["mods"]["15"] = -1
							end

							if Datatable["mods"]["15"] == 1 then
								if Datatable["mods"]["15"] >= vCLIENT.CheckMods(source, Vehicle, 15) then
									TriggerClientEvent("Notify", source, "amarelo", "Limite da <b>Suspensão</b> atingida.", "Atenção", 5000)
								else
									vRPC.AnimActive(source)
									Active[Passport] = os.time() + 1000
									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close",source)
									TriggerClientEvent("player:VehicleHood", source, Network, "open")
									vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

									if vRP.Task(source, 8, 20500) then
										Active[Passport] = os.time() + 120
										TriggerClientEvent("Progress", source, "Aplicando", 120000)

										repeat
											if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
												Active[Passport] = nil
												vRPC.Destroy(source)
												Player(source)["state"]["Buttons"] = false

												if vRP.TakeItem(Passport,Full,1,true,Slot) then
													Datatable["mods"]["15"] = Datatable["mods"]["15"] + 1
													vCLIENT.ActiveMods(source, Network, Plate, 15, Datatable["mods"]["15"])
													vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
												end
											end

											Wait(100)
										until not Active[Passport]
									end

									TriggerClientEvent("player:VehicleHood", source, Network, "close")
									Player(source)["state"]["Buttons"] = false
									vRPC.StopAnim(source, false)
									Active[Passport] = nil
								end
							else
								TriggerClientEvent("Notify", source, "vermelho", "Modelo da <b>Suspensão</b> incorreta.", "Aviso", 5000)
							end
						else
							TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
						end
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "O veículo <b>" .. VehicleName(vehName) .. "</b> não possui suspensão.", "Atenção", 5000)
				end
			end
		end
	end,

	["suspensiond"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				if vCLIENT.CheckCar(source, Vehicle) then
					local PassportPlate = vRP.PassportPlate(Plate)
					if PassportPlate then
						local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
						if parseInt(#Datatable) > 0 then
							Datatable = json.decode(Datatable[1]["Information"])

							if not Datatable["mods"]["15"] then
								Datatable["mods"]["15"] = -1
							end

							if Datatable["mods"]["15"] == 2 then
								if Datatable["mods"]["15"] >= vCLIENT.CheckMods(source, Vehicle, 15) then
									TriggerClientEvent("Notify", source, "amarelo", "Limite da <b>Suspensão</b> atingida.", "Atenção", 5000)
								else
									vRPC.AnimActive(source)
									Active[Passport] = os.time() + 1000
									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close",source)
									TriggerClientEvent("player:VehicleHood", source, Network, "open")
									vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

									if vRP.Task(source, 8, 20500) then
										Active[Passport] = os.time() + 120
										TriggerClientEvent("Progress", source, "Aplicando", 120000)

										repeat
											if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
												Active[Passport] = nil
												vRPC.Destroy(source)
												Player(source)["state"]["Buttons"] = false

												if vRP.TakeItem(Passport,Full,1,true,Slot) then
													Datatable["mods"]["15"] = Datatable["mods"]["15"] + 1
													vCLIENT.ActiveMods(source, Network, Plate, 15, Datatable["mods"]["15"])
													vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
												end
											end

											Wait(100)
										until not Active[Passport]
									end

									TriggerClientEvent("player:VehicleHood", source, Network, "close")
									Player(source)["state"]["Buttons"] = false
									vRPC.StopAnim(source, false)
									Active[Passport] = nil
								end
							else
								TriggerClientEvent("Notify", source, "vermelho", "Modelo da <b>Suspensão</b> incorreta.", "Aviso", 5000)
							end
						else
							TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
						end
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "O veículo <b>" .. VehicleName(vehName) .. "</b> não possui suspensão.", "Atenção", 5000)
				end
			end
		end
	end,

	["suspensione"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate, vehName = vRPC.VehicleList(source, 4)
			if Vehicle then
				if vCLIENT.CheckCar(source, Vehicle) then
					local PassportPlate = vRP.PassportPlate(Plate)
					if PassportPlate then
						local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..PassportPlate["Passport"]..":"..vehName })
						if parseInt(#Datatable) > 0 then
							Datatable = json.decode(Datatable[1]["Information"])

							if not Datatable["mods"]["15"] then
								Datatable["mods"]["15"] = -1
							end

							if Datatable["mods"]["15"] == 3 then
								if Datatable["mods"]["15"] >= vCLIENT.CheckMods(source, Vehicle, 15) then
									TriggerClientEvent("Notify", source, "amarelo", "Limite da <b>Suspensão</b> atingida.", "Atenção", 5000)
								else
									vRPC.AnimActive(source)
									Active[Passport] = os.time() + 1000
									Player(source)["state"]["Buttons"] = true
									TriggerClientEvent("inventory:Close",source)
									TriggerClientEvent("player:VehicleHood", source, Network, "open")
									vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

									if vRP.Task(source, 8, 20500) then
										Active[Passport] = os.time() + 120
										TriggerClientEvent("Progress", source, "Aplicando", 120000)

										repeat
											if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
												Active[Passport] = nil
												vRPC.Destroy(source)
												Player(source)["state"]["Buttons"] = false

												if vRP.TakeItem(Passport,Full,1,true,Slot) then
													Datatable["mods"]["15"] = Datatable["mods"]["15"] + 1
													vCLIENT.ActiveMods(source, Network, Plate, 15, Datatable["mods"]["15"])
													vRP.Query("entitydata/SetData",{ Name = "Mods:" .. PassportPlate["Passport"] .. ":" .. vehName, Information = json.encode(Datatable) })
												end
											end

											Wait(100)
										until not Active[Passport]
									end

									TriggerClientEvent("player:VehicleHood", source, Network, "close")
									Player(source)["state"]["Buttons"] = false
									vRPC.StopAnim(source, false)
									Active[Passport] = nil
								end
							else
								TriggerClientEvent("Notify", source, "vermelho", "Modelo da <b>Suspensão</b> incorreta.", "Aviso", 5000)
							end
						else
							TriggerClientEvent("Notify", source, "amarelo", "Dirija-se até uma mecânica e efetue uma revisão.", "Atenção", 5000)
						end
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "O veículo <b>" .. VehicleName(vehName) .. "</b> não possui suspensão.", "Atenção", 5000)
				end
			end
		end
	end,

	["toolbox"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle, Network, Plate = vRPC.VehicleList(source, 4)
			if Vehicle then
				vRPC.AnimActive(source)
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				local Players = vRPC.Players(source)
				for _, v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood", v, Network, "open")
					end)
				end

				if vRP.Task(source, 5, 10000) then
					Active[Passport] = os.time() + 15
					TriggerClientEvent("Progress", source, "Reparando", 15000)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil

							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								local Players = vRPC.Players(source)
								for _, v in pairs(Players) do
									async(function()
										TriggerClientEvent("inventory:repairVehicle", v, Network, Plate)
									end)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				end

				local Players = vRPC.Players(source)
				for _, v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood", v, Network, "close")
					end)
				end

				Player(source)["state"]["Buttons"] = false
				Active[Passport] = nil
				vRPC.Destroy(source)
			end
		end
	end,

	["drift"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRP.InsideVehicle(source) then
			local Vehicle, Network, Plate, Model, Class = vRPC.VehicleList(source, 4)
			if Vehicle and (Class <= 7 or Class == 9) then
				vRPC.AnimActive(source)
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				local Players = vRPC.Players(source)
				for _, v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood", v, Network, "open")
					end)
				end

				if vRP.Task(source, 5, 50000) then
					Active[Passport] = os.time() + 15
					TriggerClientEvent("Progress", source, "Instalando", 15000)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil

							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								local Networked = NetworkGetEntityFromNetworkId(Network)
								Entity(Networked)["state"]:set("Drift", true, true)

								if vRP.PassportPlate(Plate) then
									vRP.Query("vehicles/Drift", { Plate = Plate })
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				end

				local Players = vRPC.Players(source)
				for _, v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood", v, Network, "close")
					end)
				end

				Player(source)["state"]["Buttons"] = false
				Active[Passport] = nil
				vRPC.Destroy(source)
			end
		end
	end,

	["lockpick"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Handcuff"] then
			local Vehicle, Network, Plate, Model, Class = vRPC.VehicleList(source, 4)
			if Vehicle then
				if not (Class == 15 or Class == 16 or Class == 19) then
					local Brokenpick = 950

					local function triggerVehicleAlarm(Network, Plate, Model)
						local Networked = NetworkGetEntityFromNetworkId(Network)
						Entity(Networked)["state"]:set("Lockpick", true, true)
						TriggerClientEvent("inventory:vehicleAlarm", source, Network, Plate)

						if math.random(100) >= 25 then
							TriggerClientEvent("Notify", source, "policia", "A <b>polícia</b> foi acionada.", "Serviço Emergencial", 5000)

							TriggerEvent("Wanted", source, Passport, 300)

							local Coords = vRP.GetEntityCoords(source)
							local Service = vRP.NumPermission("Policia")
							for Passports, Sources in pairs(Service) do
								async(function()
									vRPC.PlaySound(Sources, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
									TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(Model).." - "..Plate, color = 44 })
								end)
							end
						end
					end

					if vRPC.InsideVehicle(source) then
						vRPC.AnimActive(source)
						vGARAGE.StartHotwired(source)
						Active[Passport] = os.time() + 100
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close", source)

						if vRP.Screwdriver(source) then
							Brokenpick = 900

							local Networked = NetworkGetEntityFromNetworkId(Network)
							if not vRP.PassportPlate(Plate) then
								Entity(Networked)["state"]:set("Fuel", 100, true)
								Entity(Networked)["state"]:set("Nitro", 0, true)
								SetVehicleDoorsLocked(Networked, 1)
							else
								SetVehicleDoorsLocked(Networked, 1)
							end

							triggerVehicleAlarm(Network, Plate, Model)
						end

						if math.random(1000) >= Brokenpick then
							if vRP.TakeItem(Passport, Full, 1, false) then
								vRP.GiveItem(Passport, "lockpick-0", 1, false)
								TriggerClientEvent("NotifyItens", source, {"-", "lockpick", 1, "Lockpick de Alumínio"})
							end
						end

						Player(source)["state"]["Buttons"] = false
						vGARAGE.StopHotwired(source, vehicle)
						Active[Passport] = nil
					else
						vRPC.AnimActive(source)
						Active[Passport] = os.time() + 100
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close", source)
						vRPC.PlayAnim(source, false, {"missfbi_s4mop", "clean_mop_back_player"}, true)

						if string.sub(Plate, 1, 4) == "DISM" then
							if vRP.Task(source, 10, 7500) then
								Brokenpick = 900

								Active[Passport] = os.time() + 15
								TriggerClientEvent("inventory:Dismapatch", source)
								TriggerClientEvent("Progress", source, "Roubando", 15000)
								TriggerClientEvent("Notify", source, "amarelo", "A <b>vizinhança</b> foi notificada.", "Atenção", 5000)

								triggerVehicleAlarm(Network, Plate, Model)

								repeat
									if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
										Active[Passport] = nil
										TriggerEvent("plateEveryone", Plate)
										TriggerClientEvent("target:Dismantles", source)
										TriggerClientEvent("inventory:vehicleAlarm", source, Network, Plate)
										local Networked = NetworkGetEntityFromNetworkId(Network)
										Entity(Networked)["state"]:set("Lockpick", true, true)
										SetVehicleDoorsLocked(Networked, 1)
									end
									Wait(100)
								until not Active[Passport]
							end
						else
							if vRP.Screwdriver(source) then
								Brokenpick = 900

								local Networked = NetworkGetEntityFromNetworkId(Network)
								if not vRP.PassportPlate(Plate) then
									Entity(Networked)["state"]:set("Fuel", 100, true)
									Entity(Networked)["state"]:set("Nitro", 0, true)
									SetVehicleDoorsLocked(Networked, 1)
								else
									SetVehicleDoorsLocked(Networked, 1)
								end

								triggerVehicleAlarm(Network, Plate, Model)
							end
						end

						if math.random(1000) >= Brokenpick then
							if vRP.TakeItem(Passport, Full, 1, false) then
								vRP.GiveItem(Passport, "lockpick-0", 1, false)
								TriggerClientEvent("NotifyItens", source, {"-", "lockpick", 1, "Lockpick de Alumínio"})
							end
						end

						Player(source)["state"]["Buttons"] = false
						vRPC.Destroy(source)
						Active[Passport] = nil
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Este veículo é protegido.", "Atenção", 5000)
				end
			end
		end
	end,

	["lockpick2"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Handcuff"] then
			local Coords = vRP.GetEntityCoords(source)
			local Name = exports["propertys"]:Proximity(Coords)

			if Name then
				TriggerClientEvent("inventory:Close", source)

				if vRP.HasService(Passport, "Policia") or vRP.Lock(source, Item, 3, 5) then
					if not Property[Name] then
						local Consult = vRP.Query("propertys/Exist",{ Name = Name })
						if Consult[1] then
							Property[Name] = Consult[1]["Interior"]
						else
							local Interiors = exports["propertys"]:Interiors()
							Property[Name] = Interiors[math.random(#Interiors)]
						end
					end

					local Members = exports["vrp"]:Party(Passport, source, 5)
					if #Members >= 1 then
						for _, v in pairs(Members) do
							if vRP.Passport(v["Source"]) then
								TriggerClientEvent("propertys:Enter", vRP.Source(v["Passport"]), Name, Property[Name])
							end
						end
					else
						TriggerClientEvent("propertys:Enter", source, Name, Property[Name])
					end
				else
					vRP.UpgradeStress(Passport, math.random(2))
					TriggerClientEvent("propertys:Properpatch", source)
					TriggerClientEvent("Notify", source, "amarelo", "A <b>vizinhança</b> foi notificada.", "Atenção", 5000)

					if math.random(100) >= 25 then
						TriggerClientEvent("Notify", source, "policia", "A <b>polícia</b> foi acionada.", "Serviço Emergencial", 5000)

						TriggerEvent("Wanted", source, Passport, 300)

						local Service = vRP.NumPermission("Policia")
						for Passports, Sources in pairs(Service) do
							async(function()
								vRPC.PlaySound(Sources, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
								TriggerClientEvent("NotifyPush", Sources, { code = 31, title = "Roubo a Propriedade", x = Coords["x"], y = Coords["y"], z = Coords["z"], color = 44 })
							end)
						end
					end
				end

				if math.random(1000) >= 900 then
					if vRP.TakeItem(Passport, Full, 1, false) then
						vRP.GiveItem(Passport, "lockpick2-0", 1, false)
						TriggerClientEvent("NotifyItens", source, {"-", "lockpick2", 1, "Lockpick de Cobre"})
					end
				end
			end
		end
	end,

	["blocksignal"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Handcuff"] then
			local Vehicle, Network, Plate = vRPC.VehicleList(source, 4)
			if Vehicle and vRPC.InsideVehicle(source) then
				if not exports["garages"]:Signal(Plate) then
					vRPC.AnimActive(source)
					vGARAGE.StartHotwired(source)
					Active[Passport] = os.time() + 100
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)

					if vRP.Task(source, 3, 10000) then
						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							TriggerClientEvent("Notify", source, "verde", "<b>Bloqueador de Sinal</b> instalado.", "Sucesso", 5000)
							TriggerEvent("signalRemove", Plate)
						end
					end

					Player(source)["state"]["Buttons"] = false
					vGARAGE.StopHotwired(source)
					Active[Passport] = nil
				else
					TriggerClientEvent("Notify", source, "amarelo", "<b>Bloqueador de Sinal</b> já instalado.", "Atenção", 5000)
				end
			end
		end
	end,

	["postit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("postit:initPostit", source)
	end,

	["dismantle"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.DismantleStatus(source) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				TriggerClientEvent("inventory:Close",source)

				TriggerClientEvent("dismantle:Init", source)
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Você possui um contrato ativo.", "Aviso", 5000)
		end
	end,

	["absolut"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "p_whiskey_notop", 49, 28422, 0.0, 0.0, 0.05, 0.0, 0.0, 0.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.AlcoholTimer(Passport, 30)
					vRP.UpgradeThirst(Passport, 10)
					TriggerClientEvent("Drunk", source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["hennessy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "p_whiskey_notop", 49, 28422, 0.0, 0.0, 0.05, 0.0, 0.0, 0.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.AlcoholTimer(Passport, 30)
					vRP.UpgradeThirst(Passport, 10)
					TriggerClientEvent("Drunk", source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["chandon"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "prop_beer_blr", 49, 28422, 0.0, 0.0, -0.10, 0.0, 0.0, 0.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.AlcoholTimer(Passport, 30)
					vRP.UpgradeThirst(Passport, 10)
					TriggerClientEvent("Drunk", source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["dewars"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "prop_beer_blr", 49, 28422, 0.0, 0.0, -0.10, 0.0, 0.0, 0.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.AlcoholTimer(Passport, 30)
					vRP.UpgradeThirst(Passport, 10)
					TriggerClientEvent("Drunk", source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["orangejuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 50)
					vRP.GenerateItem(Passport, "emptybottle", 1)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["passionjuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 50)
					vRP.DowngradeStress(Passport, 20)
					vRP.GenerateItem(Passport, "emptybottle", 1)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Dexterity", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["tangejuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 50)
					vRP.GenerateItem(Passport, "emptybottle", 1)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Dexterity", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["grapejuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 50)
					vRP.GenerateItem(Passport, "emptybottle", 1)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Dexterity", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["strawberryjuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 50)
					vRP.GenerateItem(Passport, "emptybottle", 1)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Dexterity", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["bananajuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 50)
					vRP.GenerateItem(Passport, "emptybottle", 1)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["acerolajuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 50)
					vRP.GenerateItem(Passport, "emptybottle", 1)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["orange"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["corn"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local CornValue = math.random(15, 30)

		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, CornValue)

					local RandomCorn = math.random(100)
					if RandomCorn > 50 then
						vRP.UpgradeCough(Passport, CornValue)
						TriggerClientEvent("inventory:Chicken", source)
						TriggerClientEvent("Energetic", source, 10, 1.10)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["apple"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["strawberry"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["coffee"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 5000)
		vRPC.CreateObjects(source, "amb@world_human_aa_coffee@idle_a", "idle_a", "p_amb_coffeecup_01", 49, 28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("Energetic", source, 10, 1.10)
					vRP.UpgradeThirst(Passport, 20)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["coffee2"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["coffeemilk"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Bebendo", 5000)
		vRPC.CreateObjects(source, "amb@world_human_aa_coffee@idle_a", "idle_a", "p_amb_coffeecup_01", 49, 28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("Energetic", source, 10, 1.10)
					vRP.UpgradeThirst(Passport, 20)
					vRP.UpgradeHunger(Passport, 25)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Dexterity", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["grape"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["tange"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["banana"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["acerola"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["passion"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["tomato"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["guarana"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["milkbottle"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 5000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Player(source)["state"]["Buttons"] = false
				vRPC.Destroy(source, "one")
				Active[Passport] = nil

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local RandomCough = math.random(100)
					if RandomCough >= 50 then
						vRP.UpgradeCough(Passport, math.random(2))
					end

					TriggerClientEvent("CleanEffectDrugs", source)
					vRP.GenerateItem(Passport, "emptybottle", 1)
					vRP.UpgradeThirst(Passport, 100)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["water"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Player(source)["state"]["Buttons"] = false
				vRPC.Destroy(source, "one")
				Active[Passport] = nil

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.GenerateItem(Passport, "emptybottle", 1)
					vRP.UpgradeThirst(Passport, 20)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["mushroom"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 10000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Player(source)["state"]["Buttons"] = false
				vRPC.Destroy(source, "one")
				Active[Passport] = nil

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local RandomCough = math.random(100)
					if RandomCough >= 50 then
						vRP.UpgradeCough(Passport, math.random(2))
					end

					TriggerClientEvent("Mushroom", source)
					TriggerClientEvent("bikes:Mushroom", source)
					TriggerClientEvent("Notify", source, "azul", "Os efeitos alucinógenos do <b>"..itemName("mushroom").."</b> fazem você se esforçar mais e ganhar mais peso nas mochilas andando de bicicleta.", false, 10000)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["dirtywater"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.GenerateItem(Passport, "emptybottle", 1)
					vRPC.DowngradeHealth(Passport, 5)

					local RandomCough = math.random(100)
					if RandomCough >= 50 then
						vRP.UpgradeCough(Passport, math.random(25,30))
					end

					vRP.UpgradeThirst(Passport, 15)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["emptybottle"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Status, Style = vCLIENT.CheckFountain(source)
		if Status then
			if Style == "fountain" then
				if vRP.MaxItens(Passport, "water", Amount) then
					TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 5000)
					return
				end

				vRPC.PlayAnim(source, true, { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }, true)
			elseif Style == "floor" then
				if vRP.MaxItens(Passport, "dirtywater", Amount) then
					TriggerClientEvent("Notify", source, "vermelho", "Limite atingido.", "Aviso", 5000)
					return
				end

				vRPC.PlayAnim(source, true, { "amb@world_human_bum_wash@male@high@base", "base" }, true)
			end

			vRPC.AnimActive(source)
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Enchendo", 10000)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.Destroy(source, "one")
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,Amount,true,Slot) then
						if Style == "floor" then
							vRP.GenerateItem(Passport, "dirtywater", Amount, true)
						else
							vRP.GenerateItem(Passport, "water", Amount, true)
						end
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end,

	["guarananatural"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Bebendo", 10000)
		vRPC.CreateObjects(source, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", "prop_food_bs_juice02", 49, 28422, 0.0, -0.01, -0.15, 0.0, 0.0, 0.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					if vCLIENT.Restaurant(source, "Burgershot") then
						vRP.UpgradeThirst(Passport, 60)
						TriggerEvent("inventory:BuffServer", source, Passport, "Dexterity", 900)
					else
						vRP.UpgradeThirst(Passport, 30)
					end

					TriggerClientEvent("Energetic", source, 10, 1.10)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["sinkalmy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Tomando", 5000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 5)
					vRP.ChemicalTimer(Passport, 3)
					vRP.DowngradeStress(Passport, 20)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["ritmoneury"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Tomando", 5000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 5)
					vRP.ChemicalTimer(Passport, 3)
					vRP.DowngradeStress(Passport, 30)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cola"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 5000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "prop_ecola_can", 49, 60309, 0.01, 0.01, 0.05, 0.0, 0.0, 90.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 15)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["soda"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Bebendo", 5000)
		vRPC.CreateObjects(source, "mp_player_intdrink", "loop_bottle", "ng_proc_sodacan_01b", 49, 60309, 0.0, 0.0, -0.04, 0.0, 0.0, 130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 15)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["fishingrod"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vCLIENT.Fishing(source) then
			vRPC.AnimActive(source)
			Active[Passport] = os.time() + 100
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close", source)

			if vRP.TakeItem(Passport, "worm", 1, true) then
				if not vRPC.PlayingAnim(source, "amb@world_human_stand_fishing@idle_a", "idle_c") then
					vRPC.AnimActive(source)
					vRPC.CreateObjects(source, "amb@world_human_stand_fishing@idle_a", "idle_c", "prop_fishing_rod_01", 49, 60309)
				end

				if vRP.Task(source, 6, 75000) then
					local Result = RandPercentage({
						{ ["Item"] = "sardine", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "smalltrout", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "orangeroughy", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "anchovy", ["Chance"] = 90, ["Amount"] = 1 },
						{ ["Item"] = "catfish", ["Chance"] = 90, ["Amount"] = 1 },
						{ ["Item"] = "herring", ["Chance"] = 60, ["Amount"] = 1 },
						{ ["Item"] = "yellowperch", ["Chance"] = 60, ["Amount"] = 1 },
						{ ["Item"] = "salmon", ["Chance"] = 40, ["Amount"] = 1 },
						{ ["Item"] = "smallshark", ["Chance"] = 15, ["Amount"] = 1 },
						{ ["Item"] = "treasurebox", ["Chance"] = 3, ["Amount"] = 1 }
					})

					if (vRP.InventoryWeight(Passport) + itemWeight(Result["Item"]) * Result["Amount"]) <= vRP.GetWeight(Passport) then
						vRP.PutExperience(Passport, "Fisherman", 1)
						vRP.GenerateItem(Passport, Result["Item"], Result["Amount"], true)
					else
						TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>1x "..itemName("worm").."</b>.", "Atenção", 5000)
			end

			Player(source)["state"]["Buttons"] = false
			vRPC.Destroy(source, "one")
			Active[Passport] = nil
		end
	end,

	["fishingrodplus"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vCLIENT.Fishing(source) then
			vRPC.AnimActive(source)
			Active[Passport] = os.time() + 100
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close", source)

			if vRP.TakeItem(Passport, "worm", 1, true) then
				if not vRPC.PlayingAnim(source, "amb@world_human_stand_fishing@idle_a", "idle_c") then
					vRPC.AnimActive(source)
					vRPC.CreateObjects(source, "amb@world_human_stand_fishing@idle_a", "idle_c", "prop_fishing_rod_01", 49, 60309)
				end

				if vRP.Task(source, 3, 75000) then
					local Result = RandPercentage({
						{ ["Item"] = "sardine", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "smalltrout", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "orangeroughy", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "anchovy", ["Chance"] = 90, ["Amount"] = 1 },
						{ ["Item"] = "catfish", ["Chance"] = 90, ["Amount"] = 1 },
						{ ["Item"] = "herring", ["Chance"] = 60, ["Amount"] = 1 },
						{ ["Item"] = "yellowperch", ["Chance"] = 60, ["Amount"] = 1 },
						{ ["Item"] = "salmon", ["Chance"] = 40, ["Amount"] = 1 },
						{ ["Item"] = "smallshark", ["Chance"] = 15, ["Amount"] = 1 },
						{ ["Item"] = "treasurebox", ["Chance"] = 5, ["Amount"] = 1 }
					})

					if (vRP.InventoryWeight(Passport) + itemWeight(Result["Item"]) * Result["Amount"]) <= vRP.GetWeight(Passport) then
						vRP.PutExperience(Passport, "Fisherman", 1)
						vRP.GenerateItem(Passport, Result["Item"], Result["Amount"], true)
					else
						TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Precisa de <b>1x "..itemName("worm").."</b>.", "Atenção", 5000)
			end

			Player(source)["state"]["Buttons"] = false
			vRPC.Destroy(source, "one")
			Active[Passport] = nil
		end
	end,

	["anchovy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque a <b>"..itemName("WEAPON_SWITCHBLADE").."</b> em mãos.","Atenção",5000)
			return
		end

		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport, "fishfillet", 2)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end,

	["catfish"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque a <b>"..itemName("WEAPON_SWITCHBLADE").."</b> em mãos.","Atenção",5000)
			return
		end

		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport, "fishfillet", 2)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end,

	["herring"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque a <b>"..itemName("WEAPON_SWITCHBLADE").."</b> em mãos.","Atenção",5000)
			return
		end

		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport, "fishfillet", 2)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end,

	["orangeroughy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque a <b>"..itemName("WEAPON_SWITCHBLADE").."</b> em mãos.","Atenção",5000)
			return
		end

		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport, "fishfillet", 2)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end,

	["salmon"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque a <b>"..itemName("WEAPON_SWITCHBLADE").."</b> em mãos.","Atenção",5000)
			return
		end

		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport, "fishfillet", 2)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end,

	["sardine"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque a <b>"..itemName("WEAPON_SWITCHBLADE").."</b> em mãos.","Atenção",5000)
			return
		end

		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport, "fishfillet", 2)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end,

	["smallshark"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque a <b>"..itemName("WEAPON_SWITCHBLADE").."</b> em mãos.","Atenção",5000)
			return
		end

		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 6) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport, "fishfillet", 6)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end,

	["smalltrout"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque a <b>"..itemName("WEAPON_SWITCHBLADE").."</b> em mãos.","Atenção",5000)
			return
		end

		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport, "fishfillet", 2)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end,

	["yellowperch"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.CheckWeapon(source, "WEAPON_SWITCHBLADE") then
			TriggerClientEvent("Notify",source,"amarelo","Coloque a <b>"..itemName("WEAPON_SWITCHBLADE").."</b> em mãos.","Atenção",5000)
			return
		end

		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport, "fishfillet", 2)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end,

	["pizzamozzarella"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "knjgh_pizzaslice1", 49, 60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 50)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["pizzabanana"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "knjgh_pizzaslice2", 49, 60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 50)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["pizzachocolate"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "knjgh_pizzaslice3", 49, 60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 25)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["sushi"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 30)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["nigirizushi"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 25)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["calzone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["chickenfries"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 30)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cookies"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("Energetic", source, 20, 1.10)
					vRP.UpgradeHunger(Passport, 30)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["onionrings"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 30)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["hamburger"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_cs_burger_01", 49, 60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 15)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["hamburger2"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_cs_burger_01", 49, 60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 50)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["hamburger3"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_cs_burger_01", 49, 60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 50)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cannedsoup"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Tomando", 5000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source, false)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 20)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["canofbeans"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Tomando", 5000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source, false)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 20)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["tablecoke"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_coke_table01a"
		local application, Coords, heading = vRPC.ObjectControlling(source, Hash)
		if application then
			if not vCLIENT.ObjectExists(source, Coords, Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = heading, object = Hash, item = Full, Distance = 50, mode = "1" }

					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["tablemeth"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_meth_table01a"
		local Application, Coords, heading = vRPC.ObjectControlling(source, Hash)
		if Application then
			if not vCLIENT.ObjectExists(source, Coords, Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 50, mode = "1" }

					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["tableweed"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_table_01a"
		local application, Coords, heading = vRPC.ObjectControlling(source, Hash)
		if application then
			if not vCLIENT.ObjectExists(source, Coords, Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 50, mode = "1" }

					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["sprays01"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "spray_01"
		local Application, Coords, Heading = vRPC.ObjectControlling(source, Hash)
		if Application then
			vRPC.AnimActive(source)
			Active[Passport] = os.time() + 5
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress", source, "Pichando", 5000)
			vRPC.CreateObjects(source, "switch@franklin@lamar_tagging_wall", "lamar_tagging_exit_loop_lamar", "prop_cs_spray_can", 1, 28422, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.Destroy(source)

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Number = 0

						repeat
							Number = Number + 1
						until not Objects[tostring(Number)]

						Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(Heading), object = Hash, item = Full, Distance = 100, mode = "Spray" }

						TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
					end
				end

				Wait(100)
			until not Active[Passport]
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["campfire"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_beach_fire"
		local application, Coords, heading = vRPC.ObjectControlling(source, Hash)
		if application then
			if not vCLIENT.ObjectExists(source, Coords, Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]) + 0.10, h = mathLength(heading), object = Hash, item = Full, Distance = 50, mode = "2" }

					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["oilbarrel"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_barrel_02a"
		local application, Coords, heading = vRPC.ObjectControlling(source, Hash)
		if application then
			if not vCLIENT.ObjectExists(source, Coords, Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 100, mode = "Oil" }

					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["barrier"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_mp_barrier_02b"
		local application, Coords, heading = vRPC.ObjectControlling(source, Hash)
		if application then
			if not vCLIENT.ObjectExists(source, Coords, Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 100, mode = "3" }

					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["spike"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "xs_prop_arena_spikes_01a"
		local application, Coords, heading = vRPC.ObjectControlling(source, Hash)
		if application then
			if not vCLIENT.ObjectExists(source, Coords, Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 100, mode = "3" }

					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["medicbag"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "xm_prop_x17_bag_med_01a"
		local application, Coords, heading = vRPC.ObjectControlling(source, Hash)
		if application then
			if not vCLIENT.ObjectExists(source, Coords, Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 50, mode = "4" }

					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["weedclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.ConsultItem(Passport, "bucket", 1) then
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)

			local Hash = "bkr_prop_weed_med_01a"
			local Application, Coords = vRPC.ObjectControlling(source, Hash)
			if Application then
				if not vCLIENT.ObjectExists(source, Coords, Hash) then
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					if vRP.Task(source, 3, 10000) then
						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							local Points = 0
							local Owner = vRP.Passport(source)
							local Route = GetPlayerRoutingBucket(source)

							if Split[2] ~= nil then
								Points = parseInt(Split[2])
							end

							vRP.RemoveItem(Passport, "bucket", 1, true)
							exports["plants"]:Plants(Hash, Owner, Coords, Route, Points, Full)
						end
					else
						local Service = vRP.NumPermission("Policia")
						for Passports,Sources in pairs(Service) do
							async(function()
								TriggerClientEvent("sounds:Private",Sources,"crime",0.5)
								TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Manejo de Drogas", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", color = 16 })
							end)
						end
					end

					vRPC.Destroy(source)
				end
			end

			Player(source)["state"]["Buttons"] = false
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..itemName("bucket").."</b>.", "Atenção", 5000)
		end
	end,

	["weedclone2"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.ConsultItem(Passport, "bucket", 1) then
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)

			local Hash = "bkr_prop_weed_lrg_01a"
			local Application, Coords = vRPC.ObjectControlling(source, Hash)
			if Application then
				if not vCLIENT.ObjectExists(source, Coords, Hash) then
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					if vRP.Task(source, 6, 10000) then
						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							local Points = 0
							local Owner = vRP.Passport(source)
							local Route = GetPlayerRoutingBucket(source)

							if Split[2] ~= nil then
								Points = parseInt(Split[2])
							end

							vRP.RemoveItem(Passport, "bucket", 1, true)
							exports["plants"]:Plants(Hash, Owner, Coords, Route, Points, Full)
						end
					else
						local Service = vRP.NumPermission("Policia")
						for Passports,Sources in pairs(Service) do
							async(function()
								TriggerClientEvent("sounds:Private",Sources,"crime",0.5)
								TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Manejo de Drogas", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", color = 16 })
							end)
						end
					end

					vRPC.Destroy(source)
				end
			end

			Player(source)["state"]["Buttons"] = false
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..itemName("bucket").."</b>.", "Atenção", 5000)
		end
	end,

	["mushseed"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local RandMush = math.random(2)
		local MushType = "prop_stoneshroom"..RandMush

		local Hash = MushType
		local Application, Coords = vRPC.ObjectControlling(source, Hash)
		if Application then
			if not vCLIENT.ObjectExists(source, Coords, Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

					local Points = 0
					local Owner = vRP.Passport(source)
					local Route = GetPlayerRoutingBucket(source)

					if Split[2] ~= nil then
						Points = parseInt(Split[2])
					end

					exports["plants"]:Plants(Hash, Owner, Coords, Route, Points, Full)
					vRPC.Destroy(source)
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["c4"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "ch_prop_ch_ld_bomb_01a"
		local Application, Coords, Heading = vRPC.ObjectControlling(source, Hash)
		if Application then
			local CoordsAtm, NumberAtm = vCLIENT.Atm(source, Coords)

			if CoordsAtm then
				if not AtmTimers[NumberAtm] then
					AtmTimers[NumberAtm] = os.time()
				end

				if os.time() < AtmTimers[NumberAtm] then
					local Cooldown = parseInt(AtmTimers[NumberAtm] - os.time())
					TriggerClientEvent("Notify", source, "azul", "Caixa vazio, aguarde <b>" .. Cooldown .. "</b> segundos até que um transportador venha até o local efetuar reabastecimento do mesmo.", false, 5000)
					Player(source)["state"]["Buttons"] = false

					return
				end

				local Service, Total = vRP.NumPermission("Policia")
				if Total <= 4 then
					TriggerClientEvent("Notify", source, "azul", "Caixa vazio, aguarde até que um transportador venha até o local efetuar reabastecimento do mesmo.", false, 5000)
					Player(source)["state"]["Buttons"] = false

					return
				end

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(Heading), object = Hash, item = Full, Distance = 100 }
					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
					TriggerClientEvent("Progress", source, "Plantando", 30000)
					AtmTimers[NumberAtm] = os.time() + 10800
					local ExplosionProgress = 30

					for Passports, Sources in pairs(Service) do
						async(function()
							vRPC.PlaySound(Sources, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
							TriggerClientEvent("NotifyPush", Sources, { code = 20, title = "Caixa Eletrônico", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", time = "Recebido às " .. os.date("%H:%M"), blipColor = 16 })
						end)
					end

					repeat
						Wait(1000)
						ExplosionProgress = ExplosionProgress - 1
					until ExplosionProgress <= 0

					if math.random(100) >= 50 then
						exports["inventory"]:Drops(Passport, source, "dollars", math.random(2500, 4500))
					else
						exports["inventory"]:Drops(Passport, source, "dollars2", math.random(1500, 3500))
					end

					TriggerClientEvent("player:Residuals", source, "Resíduo de Explosivo.")
					TriggerClientEvent("objects:Remover", -1, tostring(Number))
					TriggerClientEvent("vRP:Explosion", source, Coords)

					TriggerEvent("Wanted", source, Passport, 600)
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["cookedfishfillet"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source, false)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 20)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cookedmeat"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.PlayAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.StopAnim(source, false)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 30)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["hotdog"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", "prop_cs_hotdog_01", 49, 28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 10)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["sandwich"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_sandwich_01", 49, 18905, 0.13, 0.05, 0.02, -50.0, 16.0, 60.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 10)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["tacos"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_taco_01", 49, 18905, 0.16, 0.06, 0.02, -50.0, 220.0, 60.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 15)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["fries"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_food_bs_chips", 49, 18905, 0.10, 0.0, 0.08, 150.0, 320.0, 160.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 5)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["friesbacon"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_food_bs_chips", 49, 18905, 0.10, 0.0, 0.08, 150.0, 320.0, 160.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 20)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["milkshake"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Tomando", 5000)
		vRPC.CreateObjects(source, "amb@world_human_aa_coffee@idle_a", "idle_a", "p_amb_coffeecup_01", 49, 28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 25)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["milkshakepeanut"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("Progress", source, "Tomando", 5000)
		vRPC.CreateObjects(source, "amb@world_human_aa_coffee@idle_a", "idle_a", "p_amb_coffeecup_01", 49, 28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 25)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer", source, Passport, "Dexterity", 900)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cappuccino"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Tomando", 5000)
		vRPC.CreateObjects(source, "amb@world_human_aa_coffee@idle_a", "idle_a", "p_amb_coffeecup_01", 49, 28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport, 15)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["applelove"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_choc_ego", 49, 60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("Energetic", source, 20, 1.10)
					vRP.UpgradeHunger(Passport, 10)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cupcake"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_choc_ego", 49, 60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("Energetic", source, 20, 1.10)
					vRP.UpgradeHunger(Passport, 25)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["marshmallow"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 3
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 3000)
		vRPC.PlayAnim(source, true, { "mp_suicide", "pill" }, true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 5)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["chocolate"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_choc_ego", 49, 60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport, 5)
					vRP.DowngradeStress(Passport, 3)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["donut"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress", source, "Comendo", 5000)
		vRPC.CreateObjects(source, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", "prop_amb_donut", 49, 28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source, "one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("Energetic", source, 20, 1.10)
					vRP.UpgradeHunger(Passport, 5)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["notepad"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 100
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Keyboard = vKEYBOARD.Primary(source,"Mensagem:")
		if Keyboard then
			if vRP.TakeItem(Passport,Full,1,false,Slot) then
				if Split[2] then
					vRP.SetServerData(Full,Keyboard[1])
					vRP.GenerateItem(Passport,Full,1,false)
					TriggerClientEvent("Notify",source,"verde","Anotação salva.","Sucesso",5000)
				else
					local Time = os.time()
					vRP.SetServerData("notepad-"..Time,Keyboard[1])
					vRP.GenerateItem(Passport,"notepad-"..Time,1,false)
					TriggerClientEvent("Notify",source,"verde","Anotação criada.","Sucesso",5000)
				end
			end

			TriggerClientEvent("inventory:Update",source,"Backpack")
		end

		Player(source)["state"]["Buttons"] = false
		Active[Passport] = nil
	end,

	["megaphone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("player:Megaphone", source)
		TriggerClientEvent("pma-voice:Megaphone", source, true)
		TriggerEvent("pma-voice:Megaserver", source, true)
		TriggerClientEvent("emotes", source, "megaphone")
	end,

	["notebook"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("notebook:Open", source)
	end,

	["whistle"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Whistle[Passport] or os.time() > Whistle[Passport]) then
			TriggerClientEvent("Progress", source, "Usando apito", 3500)
			local ClosestPed = vRPC.ClosestPed(source, 30)
			if ClosestPed then
				TriggerClientEvent("sounds:Private", source, "whistle", 0.5)
				TriggerClientEvent("sounds:Private", ClosestPed, "whistle", 0.5)
			else
				TriggerClientEvent("sounds:Private", source, "whistle", 0.5)
			end

			vRP.UpgradeStress(Passport, 2)
			Whistle[Passport] = os.time() + 60
		else
			local Timer = parseInt(Whistle[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",false,5000)
		end
	end,

	["tyres"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			if not vCLIENT.CheckWeapon(source, "WEAPON_WRENCH") then
				TriggerClientEvent("Notify", source, "amarelo", "Coloque a <b>" .. itemName("WEAPON_WRENCH") .. "</b> em mãos.", "Atenção", 5000)
				return
			end

			local tyreStatus, Tyre, Network, Plate = vCLIENT.tyreStatus(source)
			if tyreStatus then
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source, false, { "amb@medic@standing@kneel@idle_a", "idle_a" }, true)
				vRPC.CreateObjects(source, "anim@heists@box_carry@", "idle", "imp_prop_impexp_tyre_01a", 49, 28422, -0.02, -0.1, 0.2, 10.0, 0.0, 0.0)

				if vRP.Task(source, 3, 7500) then
					Active[Passport] = os.time() + 10
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress", source, "Colocando", 10000)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							Player(source)["state"]["Buttons"] = false

							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								local Players = vRPC.Players(source)
								for _, v in pairs(Players) do
									async(function()
										TriggerClientEvent("inventory:repairTyre", v, Network, Tyre, Plate)
									end)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				end

				vRPC.Destroy(source)
			end
		end
	end,

	["premiumplate"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)

		local Model = vRPC.VehicleName(source)
		local Vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Model })
		if Vehicle[1] then
			local Keyboard = vKEYBOARD.Primary(source, "Placa: (8 Caracteres)")
			if Keyboard then
				local Plate = string.sub(Keyboard[1], 1, 8)
				local PlateCheck = sanitizeString(Plate, "abcdefghijklmnopqrstuvwxyz0123456789", true)

				if string.len(PlateCheck) ~= 8 then
					TriggerClientEvent("Notify", source, "vermelho", "O nome de definição para a placa inválida.", "Aviso", 5000)
					return
				else
					if vRP.PassportPlate(Plate) then
						TriggerClientEvent("Notify", source, "amarelo", "A placa escolhida já possui em outro veículo.", "Atenção", 5000)
						return
					else
						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							vRP.Query("vehicles/plateVehiclesUpdate", { Passport = Passport, vehicle = Model, plate = string.upper(Plate) })
							TriggerClientEvent("Notify", source, "verde", "Placa atualizada.", "Sucesso", 5000)
						end
					end
				end
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Modelo de veículo não encontrado.", "Aviso", 5000)
		end
	end,

	["radio"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("radio:Open",source)
		vRPC.AnimActive(source)
	end,

	["scuba"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("hud:Scuba", source)

		if Player(source)["state"]["Scuba"] then
			Player(source)["state"]["Scuba"] = false
		else
			Player(source)["state"]["Scuba"] = true
		end
	end,

	["oxygencylinder"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			vRP.UpgradeOxigen(Passport, itemData(Full))
			TriggerClientEvent("Notify", source, "verde", "Você adicionou <b>+"..itemData(Full).."%</b> de oxigênio.", "Sucesso", 5000)
		end
	end,

	["handcuff"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local ClosestPed = vRPC.ClosestPed(source,2)
			if ClosestPed then
				Player(source)["state"]["Cancel"] = true
				Player(source)["state"]["Buttons"] = true

				if Player(ClosestPed)["state"]["Handcuff"] then
					Player(ClosestPed)["state"]["Handcuff"] = false
					Player(ClosestPed)["state"]["Commands"] = false
					TriggerClientEvent("sounds:Private",source,"uncuff",0.5)
					TriggerClientEvent("sounds:Private",ClosestPed,"uncuff",0.5)

					vRPC.Destroy(ClosestPed)
					vRPC.Destroy(source)
				else
					if vRP.GetHealth(ClosestPed) > 100 then
						TriggerEvent("inventory:ServerCarry",source,Passport,ClosestPed,true)
						vRPC.PlayAnim(source,false,{ "mp_arrest_paired", "cop_p2_back_left" },false)
						vRPC.PlayAnim(ClosestPed,false,{ "mp_arrest_paired", "crook_p2_back_left" },false)

						SetTimeout(3500,function()
							TriggerEvent("inventory:ServerCarry",source,Passport)
							TriggerClientEvent("sounds:Private",source,"cuff",0.5)
							TriggerClientEvent("sounds:Private",ClosestPed,"cuff",0.5)

							vRPC.Destroy(ClosestPed)
							vRPC.Destroy(source)
						end)
					else
						TriggerClientEvent("sounds:Private",source,"cuff",0.5)
						TriggerClientEvent("sounds:Private",ClosestPed,"cuff",0.5)
					end

					Player(ClosestPed)["state"]["Handcuff"] = true
					Player(ClosestPed)["state"]["Commands"] = true

					if UsingLbPhone then
						TriggerClientEvent("lb-phone:Close",ClosestPed)
					end

					TriggerClientEvent("inventory:Close",ClosestPed)
					TriggerClientEvent("radio:RadioClean",ClosestPed)
				end

				Player(source)["state"]["Cancel"] = false
				Player(source)["state"]["Buttons"] = false
			end
		end
	end,

	["hood"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local OtherSource = vRPC.ClosestPed(source,2)
		local OtherPassport = vRP.Passport(OtherSource)
		if OtherSource and OtherPassport then
			TriggerClientEvent("hud:Hood",OtherSource)
			TriggerClientEvent("inventory:Close",OtherSource)
			TriggerClientEvent("Notify",source,"amarelo","Você usou o <b>"..itemName("hood").."</b> em <b>"..vRP.FullName(OtherPassport).."</b>.","Atenção",5000)
		end
	end,

	["rope"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			if not Carry[Passport] then
				local OtherSource = vRPC.ClosestPed(source,2)
				local OtherPassport = vRP.Passport(OtherSource)
				if OtherSource and not Carry[OtherPassport] then
					Carry[Passport] = OtherSource
					Player(source)["state"]["Carry"] = true
					Player(OtherSource)["state"]["Carry"] = true
					TriggerClientEvent("inventory:Carry",OtherSource,source,"Attach")
				end
			else
				TriggerClientEvent("inventory:Carry",Carry[Passport],source,"Detach")
				Player(Carry[Passport])["state"]["Carry"] = false

				Player(source)["state"]["Carry"] = false
				Carry[Passport] = nil
			end
		end
	end,

	["rolepass"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRP.CheckRolepass(source) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				TriggerEvent("vRP:ActivePass",source)
			end
		end
	end,

	["premium"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Hierarchy = 1
		if not vRP.UserPremium(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.SetPremium(source)
				vRP.SetPermission(Passport,"Premium",Hierarchy)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				TriggerClientEvent("Notify", source, "verde", "Você ativou o seu <b>"..itemName(Item).."</b>.", "Sucesso", 5000)
			end
		else
			if vRP.HasGroup(Passport,"Premium",Hierarchy) and vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.UpgradePremium(source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				TriggerClientEvent("Notify", source, "amarelo", "Você renovou o seu <b>"..itemName(Item).."</b>.", "Atenção", 5000)
			end
		end
	end,

	["premium2"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Hierarchy = 2
		if not vRP.UserPremium(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.SetPremium(source)
				vRP.SetPermission(Passport,"Premium",Hierarchy)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				TriggerClientEvent("Notify", source, "verde", "Você ativou o seu <b>"..itemName(Item).."</b>.", "Sucesso", 5000)
			end
		else
			if vRP.HasGroup(Passport,"Premium",Hierarchy) and vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.UpgradePremium(source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				TriggerClientEvent("Notify", source, "amarelo", "Você renovou o seu <b>"..itemName(Item).."</b>.", "Atenção", 5000)
			end
		end
	end,

	["premium3"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Hierarchy = 3
		if not vRP.UserPremium(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.SetPremium(source)
				vRP.SetPermission(Passport,"Premium",Hierarchy)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				TriggerClientEvent("Notify", source, "verde", "Você ativou o seu <b>"..itemName(Item).."</b>.", "Sucesso", 5000)
			end
		else
			if vRP.HasGroup(Passport,"Premium",Hierarchy) and vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.UpgradePremium(source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				TriggerClientEvent("Notify", source, "amarelo", "Você renovou o seu <b>"..itemName(Item).."</b>.", "Atenção", 5000)
			end
		end
	end,

	["creator"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)

		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			TriggerClientEvent("barbershop:Open", source, "open", true)
		end
	end,

	["pager"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed and Player(ClosestPed)["state"]["Handcuff"] then
			local OtherPassport = vRP.Passport(ClosestPed)
			if OtherPassport then
				if vRP.HasService(OtherPassport,"Policia") then
					TriggerEvent("Wanted",source,Passport, 600)

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vRP.ServiceLeave(ClosestPed,OtherPassport,"Policia",true)
						TriggerClientEvent("Notify",source,"verde","Todas as comunicações foram retiradas.","Sucesso",5000)
					end
				end

				if vRP.HasService(OtherPassport,"Paramedico") then
					TriggerEvent("Wanted",source,Passport, 600)

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vRP.ServiceLeave(ClosestPed,OtherPassport,"Paramedico",true)
						TriggerClientEvent("Notify",source,"verde","Todas as comunicações foram retiradas.","Sucesso",5000)
					end
				end
			end
		end
	end
}