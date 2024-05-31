-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("arena")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Peds = {}
local Arena = "0"
local Players = 0
local KillStreek = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- ZONES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {
	["1"] = {
		["Ped"] = {
			["Model"] = "u_m_y_juggernaut_01",
			["Coords"] = vec3(-1048.56, -473.4, 36.87),
			["Heading"] = 317.49
		},
		["Respawn"] = {
			{ -1058.21, -513.09, 36.04 },
			{ -1023.25, -491.27, 36.97 },
			{ -999.92,  -532.48, 36.73 },
			{ -1069.01, -551.77, 35.0 },
			{ -1119.32, -578.29, 31.42 },
			{ -1149.25, -572.01, 30.19 },
			{ -1184.33, -565.33, 28.32 },
			{ -1219.62, -563.6,  27.77 },
			{ -1257.89, -517.26, 31.8 },
			{ -1226.66, -501.09, 30.89 },
			{ -1183.08, -458.22, 33.95 },
			{ -1138.99, -462.87, 35.25 },
			{ -1132.5,  -433.93, 36.04 },
			{ -1108.99, -445.2,  35.22 },
			{ -1081.1,  -463.67, 36.58 },
			{ -1098.47, -496.21, 35.77 }
		},
		["Exit"] = { -1046.43, -474.55, 36.78 },
		["Route"] = 900001,
		["PolyZone"] = PolyZone:Create({
			vector2(-971.53, -451.67),
			vector2(-944.80, -503.36),
			vector2(-987.69, -526.77),
			vector2(-1004.47, -541.25),
			vector2(-1025.26, -550.27),
			vector2(-1046.18, -557.81),
			vector2(-1066.37, -564.35),
			vector2(-1086.81, -573.03),
			vector2(-1111.39, -586.49),
			vector2(-1130.33, -596.72),
			vector2(-1149.24, -606.29),
			vector2(-1170.63, -623.22),
			vector2(-1269.28, -509.64),
			vector2(-1269.45, -500.99),
			vector2(-1206.05, -443.68),
			vector2(-1191.57, -436.54),
			vector2(-1164.05, -429.95),
			vector2(-1125.46, -425.34),
			vector2(-1109.49, -420.75),
			vector2(-1098.19, -416.18),
			vector2(-1077.92, -453.98),
			vector2(-1072.64, -461.31),
			vector2(-1061.59, -471.09),
			vector2(-1060.40, -469.96),
			vector2(-1049.98, -475.18),
			vector2(-1042.00, -482.13),
			vector2(-1043.93, -483.11),
			vector2(-1035.33, -482.96),
			vector2(-1025.11, -479.39)
		}, { name = "Arena-1" })
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number, v in pairs(Zones) do
			local Distance = #(Coords - v["Ped"]["Coords"])
			if Distance <= 100 and LocalPlayer["state"]["Route"] < 900000 then
				if not Peds[Number] then
					if LoadModel(v["Ped"]["Model"]) then
						Peds[Number] = CreatePed(4, v["Ped"]["Model"], v["Ped"]["Coords"]["x"], v["Ped"]["Coords"]["y"], v["Ped"]["Coords"]["z"] - 1, v["Ped"]["Heading"], false, false)
						SetPedArmour(Peds[Number], 99)
						SetEntityInvincible(Peds[Number], true)
						FreezeEntityPosition(Peds[Number], true)
						SetBlockingOfNonTemporaryEvents(Peds[Number], true)
						SetModelAsNoLongerNeeded(v["Ped"]["Model"])

						if LoadAnim("anim@heists@heist_corona@single_team") then
							TaskPlayAnim(Peds[Number], "anim@heists@heist_corona@single_team", "single_team_loop_boss", 8.0, 8.0, -1, 1, 0, 0, 0, 0)
						end

						exports["target"]:AddCircleZone("Arena:" .. Number, v["Ped"]["Coords"], 0.5, {
							name = "Arena:" .. Number,
							heading = 3374176
						}, {
							shop = Number,
							Distance = 2.0,
							options = {
								{
									event = "arena:Enter",
									label = "Participar",
									tunnel = "shop"
								}
							}
						})
					end
				end
			else
				if Peds[Number] then
					exports["target"]:RemCircleZone("Arena:" .. Number)

					if DoesEntityExist(Peds[Number]) then
						DeleteEntity(Peds[Number])
					end

					Peds[Number] = nil
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("arena:Enter")
AddEventHandler("arena:Enter", function(Number)
	if Arena == "0" and vSERVER.CheckEnter(Zones[Number]["Route"], Number) then
		Arena = Number
		SendNUIMessage({ Action = "Show" })
		LocalPlayer["state"]["Route"] = Zones[Number]["Route"]
		TriggerServerEvent("arena:Players", "+", Zones[Number]["Route"])

		local Ped = PlayerPedId()
		local Respawn = math.random(#Zones[Number]["Respawn"])
		SetEntityCoords(Ped, Zones[Number]["Respawn"][Respawn][1], Zones[Number]["Respawn"][Respawn][2],
			Zones[Number]["Respawn"][Respawn][3], false, false, false, false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:EXIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("arena:Exit")
AddEventHandler("arena:Exit", function()
	if Arena ~= "0" then
		local Ped = PlayerPedId()
		if GetEntityHealth(Ped) <= 100 then
			exports["survival"]:Revive(200)
		end

		SetEntityCoords(Ped, Zones[Arena]["Exit"][1], Zones[Arena]["Exit"][2], Zones[Arena]["Exit"][3], false, false, false, false)
		TriggerServerEvent("arena:Active", Arena)
		SendNUIMessage({ Action = "Hide" })
		LocalPlayer["state"]["Route"] = 0
		TriggerEvent("resetEnergetic")
		ClearPedBloodDamage(Ped)
		KillStreek = 0
		Arena = "0"
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:RESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("arena:Respawn")
AddEventHandler("arena:Respawn", function()
	if Arena ~= "0" then
		local Ped = PlayerPedId()
		local Respawn = math.random(#Zones[Arena]["Respawn"])
		SetEntityCoords(Ped, Zones[Arena]["Respawn"][Respawn][1], Zones[Arena]["Respawn"][Respawn][2], Zones[Arena]["Respawn"][Respawn][3], false, false, false, false)
		exports["survival"]:Revive(200, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("arena:Players")
AddEventHandler("arena:Players", function(Route, Amount)
	if LocalPlayer["state"]["Route"] == Route then
		Players = Amount
		SendNUIMessage({ Action = "Players", Players = Players, Streek = KillStreek })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:RESETSTREEK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("arena:ResetStreek")
AddEventHandler("arena:ResetStreek", function()
	SendNUIMessage({ Action = "Players", Players = Players, Streek = 0 })
	KillStreek = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered", function(name, Message)
	if name == "CEventNetworkEntityDamage" and Arena ~= "0" then
		if GetEntityHealth(Message[1]) <= 100 and PlayerPedId() == Message[2] and IsPedAPlayer(Message[1]) then
			SendNUIMessage({ Action = "Players", Players = Players, Streek = KillStreek + 1 })
			TriggerServerEvent("arena:Feed", Arena)
			KillStreek = KillStreek + 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if LocalPlayer["state"]["Route"] > 900000 and Arena ~= "0" and Zones[Arena]["PolyZone"] then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			if not Zones[Arena]["PolyZone"]:isPointInside(Coords) then
				TriggerServerEvent("arena:Exit")
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for _, v in pairs(Zones) do
		local blip = AddBlipForCoord(v["Ped"]["Coords"][1], v["Ped"]["Coords"][2], v["Ped"]["Coords"][3])
		SetBlipSprite(blip, 433)
		SetBlipDisplay(blip, 4)
		SetBlipAsShortRange(blip, true)
		SetBlipColour(blip, 62)
		SetBlipScale(blip, 0.7)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Arena Airsoft")
		EndTextCommandSetBlipName(blip)
	end
end)