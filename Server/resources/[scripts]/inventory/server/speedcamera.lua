-----------------------------------------------------------------------------------------------------------------------------------------
-- SPEEDCAMERAFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.SpeedCameraFines(Value, Speed, Vehicle, Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not (Player(source)["state"]["TestDrive"] or Player(source)["state"]["DrivingSchool"]) then
			if not (vRP.HasPermission(Passport, "Policia") or vRP.HasPermission(Passport, "Paramedico") or vRP.HasPermission(Passport, "Mecanico")) then
				local driverLicense = vRP.GetDriverLicense(Passport)
				if driverLicense == 1 then
					Active[Passport] = true

					local Coords = vRP.GetEntityCoords(source)
					local Service, Total = vRP.NumPermission("Policia")
					for Passports, Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("Notify", Sources, "policia", "Alguém foi autuado por excesso de velocidade.", "Radar de Velocidade", 5000)
							vRPC.PlaySound(Sources, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
						end)
					end

					TriggerClientEvent("sounds:Private", source, "speedcamera", 0.5)
					TriggerClientEvent("Notify", source ,"default", "Você excedeu o limite máximo de velocidade.", "Radar de Velocidade", 10000)

					if NewBank then
						exports["bank"]:AddFines(Passport, Passport, Value, "Velocidade captada: "..math.floor(Speed)..", com o veículo: "..Vehicle..".")
					end

					local Consult = vRP.Query("vehicles/plateVehicles",{ plate = Plate })
					if Consult[1] then
						if Consult[1]["arrest"] <= os.time() then
							vRP.Query("vehicles/arrestVehicles",{ Passport = Consult[1]["Passport"], vehicle = Vehicle })
							TriggerClientEvent("Notify", source, "default", "O veículo foi autuado por exceder o limite máximo de velocidade.", "Radar de Velocidade", 10000)
						end
					end

					exports["markers"]:Enter(source, "Corredor")

					SetTimeout(10000, function()
						exports["markers"]:Exit(source)
					end)

					Active[Passport] = nil
				else
					TriggerClientEvent("Notify", source, "default", "Você possúi problemas em sua <b>Carteira de Habilitação</b>, por isso você passou despercebido.", "Radar de Velocidade", 10000)	
				end
			else
				TriggerClientEvent("Notify", source, "default", "Graças à seu trabalho você passou despercebido.", "Radar de Velocidade", 10000)
			end
		end
	end
end