-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("engine")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Price = 0
local Lasted = 0
local VehBrakes = {}
local ActiveFuel = 0
local DisplayNui = false
local FuelRecharger = false
local DelayEntered = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Event,Message)
	if Event == "CEventNetworkPlayerEnteredVehicle" then
		local Vehicle = Message[2]
		if Message[1] == PlayerId() and GetGameTimer() >= DelayEntered then
			DelayEntered = GetGameTimer() + 1000

			ActiveFuel = Entity(Vehicle)["state"]["Fuel"] or 100
			SetPedConfigFlag(GetPlayerPed(Message[1]),35,false)
			SetVehicleFuelLevel(Vehicle,ActiveFuel + 0.0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLOOR
-----------------------------------------------------------------------------------------------------------------------------------------
function floor(Number)
	local Mult = 10 ^ 1
	return math.floor(Number * Mult + 0.5) / Mult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBRAKES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			if GetVehiclePedIsTryingToEnter(Ped) > 0 then
				local Vehicle = GetVehiclePedIsUsing(Ped)
				if NetworkGetEntityIsNetworked(Vehicle) then
					local Network = NetworkGetNetworkIdFromEntity(Vehicle)

					if GetVehicleClass(Vehicle) ~= 14 and GetVehicleClass(Vehicle) ~= 15 and GetVehicleClass(Vehicle) ~= 16 and GetVehicleClass(Vehicle) ~= 21 then
						VehBrakes[Network] = vSERVER.VehicleBrakes(Network)

						SetVehicleHandlingFloat(Vehicle,"CHandlingData","fBrakeForce",VehBrakes[Network][1])
						SetVehicleHandlingFloat(Vehicle,"CHandlingData","fBrakeBiasFront",VehBrakes[Network][2])
						SetVehicleHandlingFloat(Vehicle,"CHandlingData","fHandBrakeForce",VehBrakes[Network][3])
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFUELCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetVehicleFuelLevel(Vehicle) >= 1 then
				if (GetEntitySpeed(Vehicle) * VehVelocity) >= 1 then
					ActiveFuel = (ActiveFuel - (Consume[floor(GetVehicleCurrentRpm(Vehicle))] or 1.0) * (Class[GetVehicleClass(Vehicle)] or 1.0) / 10)
					SetVehicleFuelLevel(Vehicle,ActiveFuel + 0.0)

					if GetPedInVehicleSeat(Vehicle,-1) == Ped then
						Entity(Vehicle)["state"]:set("Fuel",ActiveFuel,true)
					end
				end
			else
				SetVehicleEngineOn(Vehicle,false,true,true)
				TimeDistance = 1
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBRAKESCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetVehicleClass(Vehicle) ~= 14 and GetVehicleClass(Vehicle) ~= 15 and GetVehicleClass(Vehicle) ~= 16 and GetVehicleClass(Vehicle) ~= 21 then
				local Speed = GetEntitySpeed(Vehicle) * VehVelocity
				if Speed >= 1 and NetworkGetEntityIsNetworked(Vehicle) then
					local Network = NetworkGetNetworkIdFromEntity(Vehicle)

					if VehBrakes[Network] == nil then
						VehBrakes[Network] = vSERVER.VehicleBrakes(Network)

						SetVehicleHandlingFloat(Vehicle,"CHandlingData","fBrakeForce",VehBrakes[Network][1])
						SetVehicleHandlingFloat(Vehicle,"CHandlingData","fBrakeBiasFront",VehBrakes[Network][2])
						SetVehicleHandlingFloat(Vehicle,"CHandlingData","fHandBrakeForce",VehBrakes[Network][3])
					end

					if GetPedInVehicleSeat(Vehicle,-1) == Ped then
						if IsPedOnAnyBike(Ped) then
							local BrakeStatusOne = GetVehicleWheelBrakePressure(Vehicle,0)

							if BrakeStatusOne ~= 0.0 then
								UpdateBrakes(Vehicle,Network)
							end
						else
							local BrakeStatusOne = GetVehicleWheelBrakePressure(Vehicle,0)
							local BrakeStatusTeo = GetVehicleWheelBrakePressure(Vehicle,2)

							if BrakeStatusOne ~= 0.0 or BrakeStatusTeo ~= 0.0 then
								UpdateBrakes(Vehicle,Network)
							end
						end
					end
				end
			end
		end

		Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEBRAKES
-----------------------------------------------------------------------------------------------------------------------------------------
function UpdateBrakes(Vehicle,Network)
	local BrakeForceFloat = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fBrakeForce")
	local BrakeFrontFloat = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fBrakeBiasFront")
	local BrakeHandFloat = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fHandBrakeForce")

	local Force = BrakeForceFloat - (0.90 * 0.0015)
	local Front = BrakeFrontFloat - (0.55 * 0.0020)
	local Hands = BrakeHandFloat - (0.75 * 0.0020)

	if Force <= 0.0900 then Force = 0.0900 end
	if Front <= 0.0550 then Front = 0.0550 end
	if Hands <= 0.0750 then Hands = 0.0750 end

	local PlayerArounds = {}
	for _,Player in ipairs(GetActivePlayers()) do
		PlayerArounds[#PlayerArounds + 1] = GetPlayerServerId(Player)
	end

	TriggerServerEvent("engine:TryBrakes",Network,{ Force, Front, Hands },PlayerArounds)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:SUPPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:Supply")
AddEventHandler("engine:Supply",function(Entitys)
	local Vehicle = Entitys[3]
	Lasted = GetVehicleFuelLevel(Vehicle)

	if Lasted < 99.0 then
		local Gallon = Entitys[5]
		if not DisplayNui and not Gallon then
			SendNUIMessage({ name = "Show", payload = true })
			DisplayNui = true
		end

		FuelRecharger = true

		local Ped = PlayerPedId()
		TaskTurnPedToFaceEntity(Ped,Vehicle,5000)

		while FuelRecharger do
			DisableControlAction(0,18,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,23,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,30,true)
			DisableControlAction(0,31,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)

			local Coords = GetEntityCoords(Vehicle)
			local VehicleFuel = GetVehicleFuelLevel(Vehicle)

			if not Gallon then
				Price = Price + 0.105
				SetVehicleFuelLevel(Vehicle,VehicleFuel + 0.025)
				SendNUIMessage({ name = "Tank", payload = { tank = floor(VehicleFuel), price = Price, lts = 0.105 * 4 } })
			else
				if GetAmmoInPedWeapon(Ped,883325847) - 0.02 * 100 > 1 then
					SetPedAmmo(Ped,883325847,math.floor(GetAmmoInPedWeapon(Ped,883325847) - 0.02 * 100))
					SetVehicleFuelLevel(Vehicle,VehicleFuel + 0.025)
				end
			end

			DrawText3D(Coords,"~g~E~w~   FINALIZAR")

			if not IsEntityPlayingAnim(Ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) and LoadAnim("timetable@gardener@filling_can") then
				TaskPlayAnim(Ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",8.0,8.0,-1,50,1,0,0,0)
			end

			if VehicleFuel >= 100.0 or GetEntityHealth(Ped) <= 100 or (Gallon and GetAmmoInPedWeapon(Ped,883325847) - 0.02 * 100 <= 1) or IsControlJustPressed(1,38) then
				if not Gallon then
					if vSERVER.RechargeFuel(Price) then
						Entity(Vehicle)["state"]:set("Fuel",VehicleFuel,true)
						ActiveFuel = VehicleFuel
					else
						Entity(Vehicle)["state"]:set("Fuel",Lasted,true)
						ActiveFuel = Lasted
					end

					SendNUIMessage({ name = "Show", payload = false })
				else
					Entity(Vehicle)["state"]:set("Fuel",VehicleFuel,true)
				end

				FuelRecharger = false
				DisplayNui = false
				vRP.Destroy()
				Price = 0
			end

			Wait(1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCBRAKES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:SyncBrakes")
AddEventHandler("engine:SyncBrakes",function(Network,Result)
	VehBrakes[Network] = Result

	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			SetVehicleHandlingFloat(Vehicle,"CHandlingData","fBrakeForce",VehBrakes[Network][1])
			SetVehicleHandlingFloat(Vehicle,"CHandlingData","fBrakeBiasFront",VehBrakes[Network][2])
			SetVehicleHandlingFloat(Vehicle,"CHandlingData","fHandBrakeForce",VehBrakes[Network][3])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSTALL
-----------------------------------------------------------------------------------------------------------------------------------------
local Install = {
	[0] = "A",
	[1] = "B",
	[2] = "C",
	[3] = "D",
	[4] = "E"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(Coords,Text)
	local onScreen,x,y = World3dToScreen2d(Coords["x"],Coords["y"],Coords["z"] + 1)

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,150)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x,y)

		local Width = (string.len(Text) + 4) / 170 * 0.45
		DrawRect(x,y + 0.0125,Width,0.03,15,15,15,175)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:VEHRIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:Vehrify")
AddEventHandler("engine:Vehrify", function(Entitys)
	local Vehicle = Entitys[3]

	local Engine = GetVehicleMod(Vehicle,11)
	local Brake = GetVehicleMod(Vehicle,12)
	local Transmission = GetVehicleMod(Vehicle,13)
	local Suspension = GetVehicleMod(Vehicle,15)
	local Shielding = GetVehicleMod(Vehicle,16)

	if Entity(Vehicle)["state"]["Lockpick"] then
		exports["dynamic"]:AddButton("Chassi do Veículo", "Númeração <blue>1"..Entitys[3].."3</blue> adulterada.", "", "", false, false)
	else
		exports["dynamic"]:AddButton("Chassi do Veículo", "Numeração <blue>2"..Entitys[3].."4</blue> original.", "", "", false, false)
	end

	if Entity(Vehicle)["state"]["Drift"] then
		exports["dynamic"]:AddButton("Kit para Drifts", "Modificações <blue>Instaladas</blue>.", "", "", false, false)
	else
		exports["dynamic"]:AddButton("Kit para Drifts", "Modificações <blue>Desinstaladas</blue>.", "", "", false, false)
	end

	if Engine ~= -1 then
		exports["dynamic"]:AddButton("Motor", "Modificação atual instalada: <blue>"..(Engine + 1).."</blue> / " ..GetNumVehicleMods(Vehicle,11), "", "", false, false)
	end

	if Brake ~= -1 then
		exports["dynamic"]:AddButton("Freios", "Modificação atual instalada: <blue>"..(Brake + 1).."</blue> / " ..GetNumVehicleMods(Vehicle,12), "", "", false, false)
	end

	if Transmission ~= -1 then
		exports["dynamic"]:AddButton("Transmissão", "Modificação atual instalada: <blue>".. (Transmission + 1).."</blue> / " ..GetNumVehicleMods(Vehicle,13), "", "", false, false)
	end

	if Suspension ~= -1 then
		exports["dynamic"]:AddButton("Suspensão", "Modificação atual instalada: <blue>"..(Suspension + 1).."</blue> / " ..GetNumVehicleMods(Vehicle,15), "", "", false, false)
	end

	if Shielding ~= -1 then
		exports["dynamic"]:AddButton("Blindagem", "Modificação atual instalada: <blue>"..(Shielding + 1).."</blue> / " ..GetNumVehicleMods(Vehicle,16), "", "", false, false)
	end

	local Force = GetVehicleEngineHealth(Vehicle) / 10
	exports["dynamic"]:AddButton("Potência", "Potência do motor se encontra em <blue>"..parseInt(Force).."%</blue>.", "", "", false, false)

	local Body = GetVehicleBodyHealth(Vehicle) / 10
	exports["dynamic"]:AddButton("Lataria", "Qualidade da lataria se encontra em <blue>"..parseInt(Body).."%</blue>.", "", "", false, false)

	local Health = GetEntityHealth(Vehicle) / 10
	exports["dynamic"]:AddButton("Chassi", "Rigidez do chassi se encontra em <blue>"..parseInt(Health).."%</blue>.", "", "", false, false)

	local Brakes = vSERVER.VehicleBrakes(NetworkGetNetworkIdFromEntity(Vehicle))

	local ForceBreak = parseInt((Brakes[1] * 10000) / 90)
	exports["dynamic"]:AddButton("Freio Integral", "Freio Integral se encontra em <blue>"..ForceBreak.."%</blue>.", "", "", false, false)

	local FrontBreak = parseInt((Brakes[2] * 10000) / 55)
	exports["dynamic"]:AddButton("Freio Dianteiro", "Freio Dianteiro se encontra em <blue>"..FrontBreak.."%</blue>.", "", "", false, false)

	local HandsBreak = parseInt((Brakes[3] * 10000) / 75)
	exports["dynamic"]:AddButton("Freio Traseiro", "Freio Traseiro se encontra em <blue>"..HandsBreak.."%</blue>.", "", "", false, false)

	exports["dynamic"]:openMenu()
end)