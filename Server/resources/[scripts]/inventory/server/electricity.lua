-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPLOSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local Explosions = {
	vec3(2108.88, 2334.7, 96.88),
	vec3(2092.43, 2320.5, 96.67)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ELECTRICITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Electricity")
AddEventHandler("inventory:Electricity", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Electricity["Blackout"] then
			Electricity["Blackout"] = os.time()
		end

		if os.time() >= Electricity["Blackout"] then
			local Service, Total = vRP.NumPermission("Policia")
			if Total >= 2 then
				if vRP.ConsultItem(Passport, "pliers", 1) then
					if vRP.TakeItem(Passport, "explosives", 3, true) then
						if vRP.Memory(source) then
							local Coords = vRP.GetEntityCoords(source)
							for Passports, Sources in pairs(Service) do
								async(function()
									TriggerClientEvent("NotifyPush", Sources,
										{ code = 31, title = "Sistema de Eletricidade", x = Coords["x"], y = Coords["y"],
											z = Coords["z"], time = "Recebido às " .. os.date("%H:%M"), blipColor = 22 })
									vRPC.PlaySound(Sources, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
								end)
							end

							vRPC.AnimActive(source)
							Active[Passport] = os.time() + 60
							Electricity["Blackout"] = os.time() + 18000
							TriggerClientEvent("Progress", source, "Sabotando", 60000)

							Player(source)["state"]["Buttons"] = true
							TriggerClientEvent("inventory:Close", source)
							vRPC.PlayAnim(source, false,
								{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

							repeat
								if os.time() >= parseInt(Active[Passport]) then
									Active[Passport] = nil

									TriggerEvent("Wanted", source, Passport, 300)
									vRP.GenerateItem(Passport, "metalwire", math.random(15, 30), true)
									TriggerClientEvent("player:Residuals", source, "Resíduo de Metal.")

									local Players = vRPC.ClosestPeds(source, 10)
									for _, v in pairs(Players) do
										async(function()
											TriggerClientEvent("Notify", v, "azul",
												"As <b>Caixas de Eletricidade</b> próximas a você irão explodir em <b>10 Segundos</b>, mantenha distância.",
												false, 10000)
										end)
									end

									SetTimeout(10000, function()
										for _, v in pairs(Explosions) do
											TriggerClientEvent("vRP:AddExplosion", source, v, 82, 1.0, true, false, true)
										end

										GlobalState["Blackout"] = true
										vRP.Blackout()

										TriggerClientEvent("Notify", -1, "azul",
											"Uma forte explosão em nossa central causou um apagão em toda a cidade, estamos trabalhando para reestabelecer os serviços.",
											"Central de Eletricidade", 10000)
									end)

									vRPC.StopAnim(source, false)
									vRP.UpgradeStress(Passport, math.random(3, 6))
									Player(source)["state"]["Buttons"] = false
								end

								Wait(100)
							until not Active[Passport]
						else
							Electricity["Blackout"] = os.time() + 60
						end
					else
						TriggerClientEvent("Notify", source, "amarelo",
							"Você precisa de <b>3x " .. itemName("explosives") .. "</b>.", "Atenção", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x " ..
					itemName("pliers") .. "</b>.", "Atenção", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", "Atenção", 5000)
			end
		else
			local Cooldown = MinimalTimers(Electricity["Blackout"] - os.time())
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
		end
	end
end)
