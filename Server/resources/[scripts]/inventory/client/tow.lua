-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Model = 0
local Selected = 0
local Attached = nil
local vehTower = nil
local Active = false
local Spawned = false
local Time = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Vehicles = { "blista", "dilettante", "issi2", "panto", "prairie", "rhapsody", "felon", "oracle", "buccaneer", "chino", "picador", "sabregt", "virgo", "bfinjection", "rancherxl", "baller", "bjxl", "cavalcade", "gresley", "habanero", "landstalker", "radi", "rocoto", "seminole", "serrano", "asea", "asterope", "emperor", "ingot", "intruder", "premier", "primo", "regina", "stanier", "stratum" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESCUES
-----------------------------------------------------------------------------------------------------------------------------------------
local Rescues = {
	vec4(2055.47, 3179.24, 44.97, 59.53),
	vec4(2175.76, 3499.56, 45.17, 340.16),
	vec4(2480.51, 3829.97, 39.92, 85.04),
	vec4(2467.19, 4106.69, 37.86, 337.33),
	vec4(2505.29, 4214.18, 39.73, 144.57),
	vec4(2637.09, 4246.96, 44.62, 314.65),
	vec4(2588.58, 4664.46, 33.88, 317.49),
	vec4(2142.51, 4783.96, 40.78, 25.52),
	vec4(2011.63, 4970.06, 41.37, 116.23),
	vec4(1665.84, 4970.69, 42.07, 133.23),
	vec4(1728.26, 4772.97, 41.65, 0.0),
	vec4(1342.81, 4309.73, 37.79, 167.25),
	vec4(736.69, 4176.68, 40.52, 345.83),
	vec4(17.36, 3685.17, 39.5, 291.97),
	vec4(472.46, 3568.16, 33.04, 167.25),
	vec4(899.0, 3579.55, 33.18, 0.0),
	vec4(1272.59, 3621.74, 32.86, 107.72),
	vec4(1484.0, 3751.71, 33.58, 212.6),
	vec4(1704.33, 3765.01, 34.17, 317.49),
	vec4(1963.98, 3834.32, 31.81, 209.77),
	vec4(1959.72, 3764.37, 32.0, 28.35),
	vec4(1127.61, 2647.57, 37.79, 0.0),
	vec4(970.73, 2724.43, 39.29, 348.67),
	vec4(565.84, 2719.71, 41.87, 2.84),
	vec4(466.12, 2591.94, 43.08, 11.34),
	vec4(262.59, 2581.57, 44.74, 99.22),
	vec4(-448.95, 2865.45, 35.64, 124.73),
	vec4(-1159.67, 2674.09, 17.89, 221.11),
	vec4(-1906.89, 2008.71, 141.39, 272.13),
	vec4(-2530.33, 2347.3, 32.86, 212.6),
	vec4(-2308.52, 3271.63, 32.64, 59.53),
	vec4(-2078.14, 2818.11, 32.62, 266.46),
	vec4(-2283.83, 4269.35, 43.89, 238.12),
	vec4(-1051.88, 5322.76, 44.96, 297.64),
	vec4(-579.04, 5370.35, 70.16, 252.29),
	vec4(-743.45, 5536.11, 33.3, 28.35),
	vec4(-674.75, 5779.26, 17.14, 62.37),
	vec4(-480.18, 6260.08, 12.92, 246.62),
	vec4(-202.91, 6570.24, 10.78, 223.94),
	vec4(-82.87, 6561.1, 31.29, 223.94),
	vec4(435.01, 6534.1, 27.72, 87.88),
	vec4(1579.31, 6449.85, 24.84, 153.08),
	vec4(3321.63, 5141.53, 18.16, 99.22),
	vec4(2866.44, 4729.55, 48.54, 195.6),
	vec4(2949.8, 4642.16, 48.34, 226.78),
	vec4(3002.34, 4113.8, 57.12, 172.92),
	vec4(2976.39, 3485.07, 71.24, 138.9),
	vec4(3511.77, 3783.87, 29.74, 167.25)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	exports["target"]:AddCircleZone("Inventory:TowDriver", vec3(408.98, -1622.71, 29.28), 0.5, {
		name = "Inventory:TowDriver",
		heading = 0.0
	}, {
		Distance = 1.5,
		options = {
			{
				event = "inventory:ToggleTow",
				label = "Trabalhar",
				tunnel = "shop"
			}, {
				event = "garages:Impound",
				label = "Apreendidos",
				tunnel = "shop"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:TOGGLETOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:ToggleTow")
AddEventHandler("inventory:ToggleTow", function()
	if vSERVER.CheckWork("Tows") then
		if GetGameTimer() >= Time then
			Time = GetGameTimer() + 60000

			if Active then
				Active = false
			else
				Active = true
				Model = math.random(#Vehicles)
				Selected = math.random(#Rescues)

				TriggerEvent("NotifyPush", { code = 20, title = "Registro de Veículo", x = Rescues[Selected]["x"], y = Rescues[Selected]["y"], z = Rescues[Selected]["z"], vehicle = VehicleName(Vehicles[Model]), color = 2 })
			end

			vSERVER.ToggleTow()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Active and not Spawned then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Distance = #(Coords - vec3(Rescues[Selected]["x"], Rescues[Selected]["y"], Rescues[Selected]["z"]))

			if Distance <= 100 then
				Spawned = true
				vGARAGE.ServerVehicle(Vehicles[Model], Rescues[Selected]["x"], Rescues[Selected]["y"], Rescues[Selected]["z"], Rescues[Selected]["w"], nil, 0, nil, 100, 0)
			end
		end

		Wait(5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Tow")
AddEventHandler("inventory:Tow", function(Entity)
	if Entity[2] == Vehicles[Model] then
		Spawned = false
		Model = math.random(#Vehicles)
		Selected = math.random(#Rescues)
		vSERVER.PaymentTow(Entity[4], Entity[1])

		TriggerEvent("NotifyPush", { code = 20, title = "Registro de Veículo", x = Rescues[Selected]["x"], y = Rescues[Selected]["y"], z = Rescues[Selected]["z"], name = "Aguardando reboque", color = 2 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:INVOKETOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:InvokeTow")
AddEventHandler("inventory:InvokeTow", function()
	local Ped = PlayerPedId()
	local Vehicle = GetLastDrivenVehicle()
	if (GetEntityModel(Vehicle) == GetHashKey("flatbed") or GetEntityModel(Vehicle) == GetHashKey("flatbed2")) and not IsPedInAnyVehicle(Ped) then
		local Tower = vRP.ClosestVehicle(10)

		if IsEntityAVehicle(Vehicle) and IsEntityAVehicle(Tower) then
			local vehCoords01 = GetEntityCoords(Vehicle)
			local vehCoords02 = GetEntityCoords(Tower)
			local vehDistance = #(vehCoords01 - vehCoords02)

			if vehDistance <= 15 then
				if Attached then
					TriggerServerEvent("inventory:ServerTow", VehToNet(Vehicle), VehToNet(Attached), "out")
					vehTower = nil
					Attached = nil
				else
					if Vehicle ~= Tower then
						vehTower = Tower
						LocalPlayer["state"]["Cancel"] = true
						LocalPlayer["state"]["Commands"] = true
						TaskTurnPedToFaceEntity(Ped, Tower, 5000)
						TriggerEvent("sounds:Private", "tow", 0.5)
						TriggerEvent("Progress", "Rebocando", 4500)
						Entity(Vehicle)["state"]:set("Tow", true, true)
						vRP.PlayAnim(false, { "mini@repair", "fixing_a_player" }, true)

						Wait(4500)

						vRP.Destroy()
						Attached = Tower
						LocalPlayer["state"]["Cancel"] = false
						LocalPlayer["state"]["Commands"] = false
						TriggerServerEvent("inventory:ServerTow", VehToNet(Vehicle), VehToNet(Tower), "in")
					end
				end
			else
				TriggerEvent("Notify", "amarelo", "O reboque precisa estar próximo do veículo.", "Atenção", 5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLIENTTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:ClientTow")
AddEventHandler("inventory:ClientTow", function(Vehicle, Vehicle02, Mode)
	if NetworkDoesNetworkIdExist(Vehicle) and NetworkDoesNetworkIdExist(Vehicle02) then
		local Vehicle = NetToEnt(Vehicle)
		local Vehicle02 = NetToEnt(Vehicle02)
		if DoesEntityExist(Vehicle) and DoesEntityExist(Vehicle02) then
			if Mode == "in" then
				local Min = GetModelDimensions(GetEntityModel(Vehicle02)) AttachEntityToEntity(Vehicle02, Vehicle, GetEntityBoneIndexByName(Vehicle, "bodyshell"), 0, -2.2, 0.4 - Min["z"], 0, 0, 0, true, true, false, true, 2, true)
			elseif Mode == "out" then
				DetachEntity(Vehicle02, false, false)

				local Heading = GetEntityHeading(Vehicle)
				local Coords = GetOffsetFromEntityInWorldCoords(Vehicle, 0.0, -10.0, 0.0)
				SetEntityCoords(Vehicle02, Coords["x"], Coords["y"], Coords["z"], false, false, false, false)
				SetEntityHeading(Vehicle02, Heading)
				SetVehicleOnGroundProperly(Vehicle02)

				if Entity(Vehicle)["state"]["Tow"] then
					Entity(Vehicle)["state"]:set("Tow", nil, true)
				end
			end
		end
	end
end)