-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local LocateSelect = 1
local LastPosition = 1
local ServiceBlip = nil
local SelectPosition = 1
local LastPatient = nil
local CurrentStatus = false
local ServiceStatus = false
local CurrentPatient = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
local SpawnModels = { "u_f_y_corpse_01", "u_m_y_corpse_01" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PATIENTSINIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:PatientsInit")
AddEventHandler("inventory:PatientsInit",function()
	if LocalPlayer["state"]["Paramedico"] then
		if ServiceStatus then
			if vSERVER.DriveServicesPermission("Patients", false) then
				ServiceStatus = false

				exports["target"]:LabelText("WorkPatients","Trabalhar")
				TriggerEvent("Notify","amarelo","Trabalho finalizado.","Atenção",5000)

				if DoesBlipExist(ServiceBlip) then
					RemoveBlip(ServiceBlip)
					ServiceBlip = nil
				end

				if CurrentPatient ~= nil then
					TriggerServerEvent("DeletePed", CurrentPatient)
					CurrentPatient = nil
				end

				if LastPatient ~= nil then
					TriggerServerEvent("DeletePed", LastPatient)
					LastPatient = nil
				end
			end
		else
			if vSERVER.DriveServicesPermission("Patients", true) then
				LocateSelect = 1

				exports["target"]:LabelText("WorkPatients","Finalizar")
				TriggerEvent("Notify","verde","Trabalho iniciado.","Sucesso",5000)

				repeat
					if LastPosition == SelectPosition then
						SelectPosition = math.random(#PatientsCoords[LocateSelect])
					end

					Wait(1)
				until LastPosition ~= SelectPosition

				CurrentPatient = nil
				CurrentStatus = false
				ServiceStatus = true
				LastPatient = nil
				BlipPatients()
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
			local Distance = #(Coords - vec3(PatientsCoords[LocateSelect][SelectPosition][1], PatientsCoords[LocateSelect][SelectPosition][2], PatientsCoords[LocateSelect][SelectPosition][3]))
			if Distance <= 100 then
				TimeDistance = 1

				DrawMarker(1, PatientsCoords[LocateSelect][SelectPosition][1], PatientsCoords[LocateSelect][SelectPosition][2], PatientsCoords[LocateSelect][SelectPosition][3] - 3, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 3.0, 255, 255, 255, 50, 0, 0, 0, 0)
				DrawMarker(21, PatientsCoords[LocateSelect][SelectPosition][1], PatientsCoords[LocateSelect][SelectPosition][2], PatientsCoords[LocateSelect][SelectPosition][3], 0, 0, 0, 0, 180.0, 130.0, 1.5, 1.5, 1.0, 65, 130, 226, 100, 0, 0, 0, 1)

				if IsControlJustPressed(1,38) and Distance <= 2.5 and GetEntityModel(Vehicle) == 1171614426 then
					if CurrentStatus then
						FreezeEntityPosition(Vehicle, true)

						if DoesEntityExist(CurrentPatient) then
							vSERVER.PaymentDriveServices()
							Wait(1000)
							TaskLeaveVehicle(CurrentPatient, Vehicle, 262144)
							TaskWanderStandard(CurrentPatient, 10.0, 10)
							Wait(1000)
							SetVehicleDoorShut(Vehicle, 3, 0)
							Wait(1000)
						end

						FreezeEntityPosition(Vehicle,false)

						LastPatient = PedToNet(CurrentPatient)
						LastPosition = SelectPosition
						CurrentStatus = false

						repeat
							if LastPosition == SelectPosition then
								SelectPosition = math.random(#PatientsCoords[LocateSelect])
							end
							Wait(1)
						until LastPosition ~= SelectPosition

						BlipPatients()

						Wait(5000)

						if LastPatient ~= nil then
							TriggerServerEvent("DeletePed", LastPatient)
							LastPatient = nil
						end
					else
						GeneratePatients(Vehicle)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPATIENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function GeneratePatients(Vehicle)
	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)

	if LastPatient ~= nil then
		TriggerServerEvent("DeletePed",LastPatient)
		LastPatient = nil
	end

	local RandModels = math.random(#SpawnModels)
	local Application, Network = vRPS.CreatePed(SpawnModels[RandModels], PatientsSpawnPeds[LocateSelect][SelectPosition][1], PatientsSpawnPeds[LocateSelect][SelectPosition][2], PatientsSpawnPeds[LocateSelect][SelectPosition][3], Heading, 4)
	if Application then
		local SpawnPassenger = 0

		CurrentPatient = LoadNetwork(Network)
		while not DoesEntityExist(CurrentPatient) and SpawnPassenger <= 1000 do
			CurrentPatient = LoadNetwork(Network)
			SpawnPassenger = SpawnPassenger + 1
			Wait(1)
		end

		SpawnPassenger = 0
		local ControlPed = NetworkRequestControlOfEntity(CurrentPatient)
		while not ControlPed and SpawnPassenger <= 1000 do
			ControlPed = NetworkRequestControlOfEntity(CurrentPatient)
			SpawnPassenger = SpawnPassenger + 1
			Wait(1)
		end

		TaskEnterVehicle(CurrentPatient, Vehicle, -1, 2, 1.0, 1,0)
		SetEntityInvincible(CurrentPatient, true)
		SetEntityAsNoLongerNeeded(CurrentPatient)

		while not IsPedSittingInVehicle(CurrentPatient, Vehicle) do
			Wait(1)
		end

		LastPosition = SelectPosition
		repeat
			if LastPosition == SelectPosition then
				SelectPosition = math.random(#PatientsCoords[LocateSelect])
			end

			Wait(1)
		until LastPosition ~= SelectPosition

		CurrentStatus = true
		BlipPatients()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPPATIENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function BlipPatients()
	if DoesBlipExist(ServiceBlip) then
		RemoveBlip(ServiceBlip)
		ServiceBlip = nil
	end

	ServiceBlip = AddBlipForCoord(PatientsCoords[LocateSelect][SelectPosition][1], PatientsCoords[LocateSelect][SelectPosition][2], PatientsCoords[LocateSelect][SelectPosition][3])
	SetBlipSprite(ServiceBlip, 12)
	SetBlipColour(ServiceBlip, 5)
	SetBlipScale(ServiceBlip, 0.9)
	SetBlipRoute(ServiceBlip, true)
	SetBlipAsShortRange(ServiceBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Presidiário")
	EndTextCommandSetBlipName(ServiceBlip)
end