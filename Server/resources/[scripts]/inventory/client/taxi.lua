-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local LocateSelect = 1
local LastPosition = 1
local ServiceBlip = nil
local SelectPosition = 1
local LastPassenger = nil
local CurrentStatus = false
local ServiceStatus = false
local CurrentPassenger = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
local SpawnModels = { "ig_abigail", "a_m_m_afriamer_01", "ig_mp_agent14", "csb_agent", "ig_amandatownley", "s_m_y_ammucity_01", "u_m_y_antonb", "g_m_m_armboss_01", "g_m_m_armgoon_01", "g_m_m_armlieut_01", "ig_ashley", "s_m_m_autoshop_01", "ig_money", "g_m_y_ballaeast_01", "g_f_y_ballas_01", "g_m_y_ballasout_01", "s_m_y_barman_01", "u_m_y_baygor", "a_m_o_beach_01", "ig_bestmen", "a_f_y_bevhills_01", "a_m_m_bevhills_02", "u_m_m_bikehire_01", "u_f_y_bikerchic", "mp_f_boatstaff_01", "s_m_m_bouncer_01", "ig_brad", "ig_bride", "u_m_y_burgerdrug_01", "a_m_m_business_01", "a_m_y_business_02", "s_m_o_busker_01", "ig_car3guy2", "cs_carbuyer", "g_m_m_chiboss_01", "g_m_m_chigoon_01", "g_m_m_chigoon_02", "u_f_y_comjane", "ig_dale", "ig_davenorton", "s_m_y_dealer_01", "ig_denise", "ig_devin", "a_m_y_dhill_01", "ig_dom", "a_m_y_downtown_01", "ig_dreyfuss" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:TAXIINIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:TaxiInit")
AddEventHandler("inventory:TaxiInit",function()
	if vSERVER.CheckWork("Taxi") then
		if ServiceStatus then
			if vSERVER.DriveServicesPermission("Taxi", false) then
				ServiceStatus = false

				exports["target"]:LabelText("WorkTaxi","Trabalhar")
				TriggerEvent("Notify","amarelo","Trabalho finalizado.","Atenção",5000)

				if DoesBlipExist(ServiceBlip) then
					RemoveBlip(ServiceBlip)
					ServiceBlip = nil
				end

				if CurrentPassenger ~= nil then
					TriggerServerEvent("DeletePed", CurrentPassenger)
					CurrentPassenger = nil
				end

				if LastPassenger ~= nil then
					TriggerServerEvent("DeletePed", LastPassenger)
					LastPassenger = nil
				end
			end
		else
			if vSERVER.DriveServicesPermission("Taxi", true) then
				LocateSelect = 1

				exports["target"]:LabelText("WorkTaxi","Finalizar")
				TriggerEvent("Notify","verde","Trabalho iniciado.","Sucesso",5000)

				repeat
					if LastPosition == SelectPosition then
						SelectPosition = math.random(#TaxiCoords[LocateSelect])
					end

					Wait(1)
				until LastPosition ~= SelectPosition

				CurrentPassenger = nil
				CurrentStatus = false
				ServiceStatus = true
				LastPassenger = nil
				BlipPassenger()
			end
		end
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
			local Distance = #(Coords - vec3(TaxiCoords[LocateSelect][SelectPosition][1], TaxiCoords[LocateSelect][SelectPosition][2], TaxiCoords[LocateSelect][SelectPosition][3]))
			if Distance <= 100 then
				TimeDistance = 1

				DrawMarker(1, TaxiCoords[LocateSelect][SelectPosition][1], TaxiCoords[LocateSelect][SelectPosition][2], TaxiCoords[LocateSelect][SelectPosition][3] - 3, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 3.0, 255, 255, 255, 50, 0, 0, 0, 0)
				DrawMarker(21, TaxiCoords[LocateSelect][SelectPosition][1], TaxiCoords[LocateSelect][SelectPosition][2], TaxiCoords[LocateSelect][SelectPosition][3], 0, 0, 0, 0, 180.0, 130.0, 1.5, 1.5, 1.0, 65, 130, 226, 100, 0, 0, 0, 1)

				if IsControlJustPressed(1,38) and Distance <= 2.5 and GetEntityModel(Vehicle) == -956048545 then
					if CurrentStatus then
						FreezeEntityPosition(Vehicle, true)

						if DoesEntityExist(CurrentPassenger) then
							vSERVER.PaymentTaxi()
							Wait(1000)
							TaskLeaveVehicle(CurrentPassenger, Vehicle, 262144)
							TaskWanderStandard(CurrentPassenger, 10.0, 10)
							Wait(1000)
							SetVehicleDoorShut(Vehicle, 3, 0)
							Wait(1000)
						end

						FreezeEntityPosition(Vehicle,false)

						LastPassenger = PedToNet(CurrentPassenger)
						LastPosition = SelectPosition
						CurrentStatus = false

						repeat
							if LastPosition == SelectPosition then
								SelectPosition = math.random(#TaxiCoords[LocateSelect])
							end
							Wait(1)
						until LastPosition ~= SelectPosition

						BlipPassenger()

						Wait(5000)

						if LastPassenger ~= nil then
							TriggerServerEvent("DeletePed", LastPassenger)
							LastPassenger = nil
						end
					else
						GeneratePassenger(Vehicle)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPASSENGER
-----------------------------------------------------------------------------------------------------------------------------------------
function GeneratePassenger(Vehicle)
	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)

	if LastPassenger ~= nil then
		TriggerServerEvent("DeletePed",LastPassenger)
		LastPassenger = nil
	end

	local RandModels = math.random(#SpawnModels)
	local Application, Network = vRPS.CreatePed(SpawnModels[RandModels], TaxiSpawnPeds[LocateSelect][SelectPosition][1], TaxiSpawnPeds[LocateSelect][SelectPosition][2], TaxiSpawnPeds[LocateSelect][SelectPosition][3], Heading, 4)
	if Application then
		local SpawnPassenger = 0

		CurrentPassenger = LoadNetwork(Network)
		while not DoesEntityExist(CurrentPassenger) and SpawnPassenger <= 1000 do
			CurrentPassenger = LoadNetwork(Network)
			SpawnPassenger = SpawnPassenger + 1
			Wait(1)
		end

		SpawnPassenger = 0
		local ControlPed = NetworkRequestControlOfEntity(CurrentPassenger)
		while not ControlPed and SpawnPassenger <= 1000 do
			ControlPed = NetworkRequestControlOfEntity(CurrentPassenger)
			SpawnPassenger = SpawnPassenger + 1
			Wait(1)
		end

		TaskEnterVehicle(CurrentPassenger, Vehicle, -1, 2, 1.0, 1,0)
		SetEntityInvincible(CurrentPassenger, true)
		SetEntityAsNoLongerNeeded(CurrentPassenger)

		while not IsPedSittingInVehicle(CurrentPassenger, Vehicle) do
			Wait(1)
		end

		LastPosition = SelectPosition
		repeat
			if LastPosition == SelectPosition then
				SelectPosition = math.random(#TaxiCoords[LocateSelect])
			end

			Wait(1)
		until LastPosition ~= SelectPosition

		CurrentStatus = true
		BlipPassenger()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPPASSENGER
-----------------------------------------------------------------------------------------------------------------------------------------
function BlipPassenger()
	if DoesBlipExist(ServiceBlip) then
		RemoveBlip(ServiceBlip)
		ServiceBlip = nil
	end

	ServiceBlip = AddBlipForCoord(TaxiCoords[LocateSelect][SelectPosition][1], TaxiCoords[LocateSelect][SelectPosition][2], TaxiCoords[LocateSelect][SelectPosition][3])
	SetBlipSprite(ServiceBlip, 12)
	SetBlipColour(ServiceBlip, 5)
	SetBlipScale(ServiceBlip, 0.9)
	SetBlipRoute(ServiceBlip, true)
	SetBlipAsShortRange(ServiceBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Taxista")
	EndTextCommandSetBlipName(ServiceBlip)
end