-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("barbershop", Hensa)
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Barber = {}
local Camera = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Barbershop"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Finish", function(Data, Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false, false, 0, false, false)
		SetCamActive(Camera, false)
		DestroyCam(Camera, false)
		Camera = nil
	end

	TriggerServerEvent("vRP:BucketClient", "Exit")
	FreezeEntityPosition(PlayerPedId(), false)
	exports["barbershop"]:Apply(Data)
	SetNuiFocus(false, false)
	vSERVER.Update(Data)
	vRP.removeObjects()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Cancel", function(Data, Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false, false, 0, false, false)
		SetCamActive(Camera, false)
		DestroyCam(Camera, false)
		Camera = nil
	end

	exports["barbershop"]:Apply(LocalPlayer["state"]["Barbershop"])
	LocalPlayer["state"]:set("Barbershop", {}, true)
	TriggerServerEvent("vRP:BucketClient", "Exit")
	FreezeEntityPosition(PlayerPedId(), false)
	SetNuiFocus(false, false)
	vRP.removeObjects()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update", function(Data, Callback)
	exports["barbershop"]:Apply(Data)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate", function(Data, Callback)
	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	if Data == "Left" then
		SetEntityHeading(Ped, Heading + 10)
	else
		SetEntityHeading(Ped, Heading - 10)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Apply")
AddEventHandler("barbershop:Apply", function(Data)
	exports["barbershop"]:Apply(Data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Apply", function(Data, Ped)
	if not Ped then
		Ped = PlayerPedId()
	end

	if Data then
		Barber = Data
	end

	for Number = 1, 46 do
		if not Barber[Number] then
			Barber[Number] = 0
		end
	end

	SetPedHeadBlendData(Ped, Fathers[Barber[1] + 1], Mothers[Barber[2] + 1], 0, Barber[5], 0, 0, Barber[3] + 0.0, 0, 0, false)

	SetPedEyeColor(Ped, Barber[4])

	SetPedComponentVariation(Ped, 2, Barber[10], 0, 0)
	SetPedHairColor(Ped, Barber[11], Barber[12])

	SetPedHeadOverlay(Ped, 0, Barber[7], 1.0)
	SetPedHeadOverlayColor(Ped, 0, 0, 0, 0)

	SetPedHeadOverlay(Ped, 1, Barber[22], Barber[23])
	SetPedHeadOverlayColor(Ped, 1, 1, Barber[24], Barber[24])

	SetPedHeadOverlay(Ped, 2, Barber[19], Barber[20])
	SetPedHeadOverlayColor(Ped, 2, 1, Barber[21], Barber[21])

	SetPedHeadOverlay(Ped, 3, Barber[9], 1.0)
	SetPedHeadOverlayColor(Ped, 3, 0, 0, 0)

	SetPedHeadOverlay(Ped, 4, Barber[13], Barber[14])
	SetPedHeadOverlayColor(Ped, 4, 2, Barber[15], Barber[15])

	SetPedHeadOverlay(Ped, 5, Barber[25], Barber[26])
	SetPedHeadOverlayColor(Ped, 5, 2, Barber[27], Barber[27])

	SetPedHeadOverlay(Ped, 6, Barber[6], 1.0)
	SetPedHeadOverlayColor(Ped, 6, 0, 0, 0)

	SetPedHeadOverlay(Ped, 8, Barber[16], Barber[17])
	SetPedHeadOverlayColor(Ped, 8, 2, Barber[18], Barber[18])

	SetPedHeadOverlay(Ped, 9, Barber[8], 1.0)
	SetPedHeadOverlayColor(Ped, 9, 0, 0, 0)

	SetPedFaceFeature(Ped, 0, Barber[28])
	SetPedFaceFeature(Ped, 1, Barber[29])
	SetPedFaceFeature(Ped, 2, Barber[30])
	SetPedFaceFeature(Ped, 3, Barber[31])
	SetPedFaceFeature(Ped, 4, Barber[32])
	SetPedFaceFeature(Ped, 5, Barber[33])
	SetPedFaceFeature(Ped, 6, Barber[44])
	SetPedFaceFeature(Ped, 7, Barber[34])
	SetPedFaceFeature(Ped, 8, Barber[36])
	SetPedFaceFeature(Ped, 9, Barber[35])
	SetPedFaceFeature(Ped, 10, Barber[45])
	SetPedFaceFeature(Ped, 12, Barber[42])
	SetPedFaceFeature(Ped, 13, Barber[46])
	SetPedFaceFeature(Ped, 14, Barber[37])
	SetPedFaceFeature(Ped, 15, Barber[38])
	SetPedFaceFeature(Ped, 16, Barber[40])
	SetPedFaceFeature(Ped, 17, Barber[39])
	SetPedFaceFeature(Ped, 18, Barber[41])
	SetPedFaceFeature(Ped, 19, Barber[43])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenBarbershop()
	for Number = 1, 46 do
		if not Barber[Number] then
			Barber[Number] = 0
		end
	end

	LocalPlayer["state"]:set("Barbershop", Barber, true)
	vRP.playAnim(true, { "mp_sleep", "bind_pose_180" }, true)

	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped, 0.0, 0.5, 0)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] + 0.6)
	RenderScriptCams(true, true, 100, true, true)
	SetCamRot(Camera, 0.0, 0.0, Heading + 180)
	SetEntityHeading(Ped, Heading)
	SetCamActive(Camera, true)

	SendNUIMessage({ name = "Open", payload = { Barber, GetNumberOfPedDrawableVariations(Ped, 2) - 1 } })
	SetNuiFocus(true, true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}

	for Number = 1, #BarberLocations do
		Tables[#Tables + 1] = { BarberLocations[Number]["x"], BarberLocations[Number]["y"], BarberLocations[Number]["z"], 2.5, "E", "Barbearia", "Pressione para abrir" }
	end

	TriggerEvent("hoverfy:Insert", Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999

		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Number = 1, #BarberLocations do
				if #(Coords - BarberLocations[Number]) <= 2.5 then
					TimeDistance = 1

					if IsControlJustPressed(1, 38) and not exports["hud"]:Wanted() then
						OpenBarbershop()
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Open")
AddEventHandler("barbershop:Open", function(Mode)
	Creation = true
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	for Number = 1, 1000 do
		SetEntityHeading(Ped, 87.88)
		SetEntityCoordsNoOffset(Ped, Coords["x"], Coords["y"], Number + 0.0, 1, 0, 0)

		RequestCollisionAtCoord(Coords["x"], Coords["y"], Coords["z"])
		while not HasCollisionLoadedAroundEntity(Ped) do
			Wait(1)
		end

		local Ground, GroundZ = GetGroundZFor_3dCoord(Coords["x"], Coords["y"], Number + 0.0)

		if Ground then
			SetEntityCoords(Ped, Coords["x"], Coords["y"], GroundZ)
			FreezeEntityPosition(Ped, true)
			OpenBarbershop()
			break
		end
	end
end)