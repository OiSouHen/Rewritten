-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local LocateSelect = 1
local LastPosition = 1
local ServiceBlip = nil
local SelectPosition = 1
local LastPrisoner = nil
local CurrentStatus = false
local ServiceStatus = false
local CurrentPrisoner = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
local SpawnModels = { "u_m_y_prisoner_01", "s_m_y_prisoner_01", "s_m_y_prismuscl_01" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CORRECTIONSINIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CorrectionsInit")
AddEventHandler("inventory:CorrectionsInit",function()
	if LocalPlayer["state"]["Policia"] then
		if ServiceStatus then
			if vSERVER.DriveServicesPermission("Corrections", false) then
				ServiceStatus = false

				exports["target"]:LabelText("WorkCorrections","Trabalhar")
				TriggerEvent("Notify","amarelo","Trabalho finalizado.","Atenção",5000)

				if DoesBlipExist(ServiceBlip) then
					RemoveBlip(ServiceBlip)
					ServiceBlip = nil
				end

				if CurrentPrisoner ~= nil then
					TriggerServerEvent("DeletePed", CurrentPrisoner)
					CurrentPrisoner = nil
				end

				if LastPrisoner ~= nil then
					TriggerServerEvent("DeletePed", LastPrisoner)
					LastPrisoner = nil
				end
			end
		else
			if vSERVER.CorrectionsPermission("Corrections", true) then
				LocateSelect = 1

				exports["target"]:LabelText("WorkCorrections","Finalizar")
				TriggerEvent("Notify","verde","Trabalho iniciado.","Sucesso",5000)

				repeat
					if LastPosition == SelectPosition then
						SelectPosition = math.random(#CorrectionsCoords[LocateSelect])
					end

					Wait(1)
				until LastPosition ~= SelectPosition

				CurrentPrisoner = nil
				CurrentStatus = false
				ServiceStatus = true
				LastPrisoner = nil
				BlipCorrections()
			end
		end
	else
		TriggerEvent("Notify", "amarelo", "Você não tem permissões para fazer isso.", "Atenção", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if ServiceStatus then
			local Coords = GetEntityCoords(Ped)
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Distance = #(Coords - vec3(CorrectionsCoords[LocateSelect][SelectPosition][1], CorrectionsCoords[LocateSelect][SelectPosition][2], CorrectionsCoords[LocateSelect][SelectPosition][3]))
			if Distance <= 100 then
				TimeDistance = 1

				DrawMarker(1, CorrectionsCoords[LocateSelect][SelectPosition][1], CorrectionsCoords[LocateSelect][SelectPosition][2], CorrectionsCoords[LocateSelect][SelectPosition][3] - 3, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 3.0, 255, 255, 255, 50, 0, 0, 0, 0)
				DrawMarker(21, CorrectionsCoords[LocateSelect][SelectPosition][1], CorrectionsCoords[LocateSelect][SelectPosition][2], CorrectionsCoords[LocateSelect][SelectPosition][3], 0, 0, 0, 0, 180.0, 130.0, 1.5, 1.5, 1.0, 65, 130, 226, 100, 0, 0, 0, 1)

				if IsControlJustPressed(1,38) and Distance <= 2.5 and GetEntityModel(Vehicle) == -2007026063 then
					if CurrentStatus then
						FreezeEntityPosition(Vehicle, true)

						if DoesEntityExist(CurrentPrisoner) then
							vSERVER.PaymentDriveServices()
							Wait(1000)
							TaskLeaveVehicle(CurrentPrisoner, Vehicle, 262144)
							TaskWanderStandard(CurrentPrisoner, 10.0, 10)
							Wait(1000)
							SetVehicleDoorShut(Vehicle, 3, 0)
							Wait(1000)
						end

						FreezeEntityPosition(Vehicle,false)

						LastPrisoner = PedToNet(CurrentPrisoner)
						LastPosition = SelectPosition
						CurrentStatus = false

						repeat
							if LastPosition == SelectPosition then
								SelectPosition = math.random(#CorrectionsCoords[LocateSelect])
							end
							Wait(1)
						until LastPosition ~= SelectPosition

						BlipCorrections()

						Wait(5000)

						if LastPrisoner ~= nil then
							TriggerServerEvent("DeletePed", LastPrisoner)
							LastPrisoner = nil
						end
					else
						GeneratePrisoner(Vehicle)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPRISONER
-----------------------------------------------------------------------------------------------------------------------------------------
function GeneratePrisoner(Vehicle)
	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)

	if LastPrisoner ~= nil then
		TriggerServerEvent("DeletePed",LastPrisoner)
		LastPrisoner = nil
	end

	local RandModels = math.random(#SpawnModels)
	local Application, Network = vRPS.CreatePed(SpawnModels[RandModels], CorrectionsSpawnPeds[LocateSelect][SelectPosition][1], CorrectionsSpawnPeds[LocateSelect][SelectPosition][2], CorrectionsSpawnPeds[LocateSelect][SelectPosition][3], Heading, 4)
	if Application then
		local SpawnPassenger = 0

		CurrentPrisoner = LoadNetwork(Network)
		while not DoesEntityExist(CurrentPrisoner) and SpawnPassenger <= 1000 do
			CurrentPrisoner = LoadNetwork(Network)
			SpawnPassenger = SpawnPassenger + 1
			Wait(1)
		end

		SpawnPassenger = 0
		local ControlPed = NetworkRequestControlOfEntity(CurrentPrisoner)
		while not ControlPed and SpawnPassenger <= 1000 do
			ControlPed = NetworkRequestControlOfEntity(CurrentPrisoner)
			SpawnPassenger = SpawnPassenger + 1
			Wait(1)
		end

		TaskEnterVehicle(CurrentPrisoner, Vehicle, -1, 2, 1.0, 1,0)
		SetEntityInvincible(CurrentPrisoner, true)
		SetEntityAsNoLongerNeeded(CurrentPrisoner)

		while not IsPedSittingInVehicle(CurrentPrisoner, Vehicle) do
			Wait(1)
		end

		LastPosition = SelectPosition
		repeat
			if LastPosition == SelectPosition then
				SelectPosition = math.random(#CorrectionsCoords[LocateSelect])
			end

			Wait(1)
		until LastPosition ~= SelectPosition

		CurrentStatus = true
		BlipCorrections()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPCORRECTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function BlipCorrections()
	if DoesBlipExist(ServiceBlip) then
		RemoveBlip(ServiceBlip)
		ServiceBlip = nil
	end

	ServiceBlip = AddBlipForCoord(CorrectionsCoords[LocateSelect][SelectPosition][1], CorrectionsCoords[LocateSelect][SelectPosition][2], CorrectionsCoords[LocateSelect][SelectPosition][3])
	SetBlipSprite(ServiceBlip, 12)
	SetBlipColour(ServiceBlip, 5)
	SetBlipScale(ServiceBlip, 0.9)
	SetBlipRoute(ServiceBlip, true)
	SetBlipAsShortRange(ServiceBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Presidiário")
	EndTextCommandSetBlipName(ServiceBlip)
end