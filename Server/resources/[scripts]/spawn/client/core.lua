-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Camera = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Locate = {
	{ ["Coords"] = vec3(-2205.92, -370.48, 13.29), ["name"] = "" },
	{ ["Coords"] = vec3(-2205.92, -370.48, 13.29), ["name"] = "" },
	{ ["Coords"] = vec3(-250.35, 6209.71, 31.49),  ["name"] = "" },
	{ ["Coords"] = vec3(1694.37, 4794.66, 41.92),  ["name"] = "" },
	{ ["Coords"] = vec3(1858.94, 3741.78, 33.09),  ["name"] = "" },
	{ ["Coords"] = vec3(328.0, 2617.89, 44.48),    ["name"] = "" },
	{ ["Coords"] = vec3(308.33, -232.25, 54.07),   ["name"] = "" },
	{ ["Coords"] = vec3(449.71, -659.27, 28.48),   ["name"] = "" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMS
-----------------------------------------------------------------------------------------------------------------------------------------
local Anims = {
	{ ["Dict"] = "rcmbarry", ["Name"] = "base" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:OPENED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("spawn:Opened", function()
	local Ped = PlayerPedId()
	SetEntityCoords(Ped, 233.85, -1387.59, 29.55, false, false, false, false)
	LocalPlayer["state"]:set("Blastoise", true, false)
	LocalPlayer["state"]:set("Charizard", true, false)
	SetEntityVisible(Ped, false, 0)
	FreezeEntityPosition(Ped, true)
	SetEntityInvincible(Ped, true)
	SetEntityHeading(Ped, 136.07)
	SetEntityHealth(Ped, 100)
	SetPedArmour(Ped, 0)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(Camera, 232.0, -1388.64, 30.45)
	RenderScriptCams(true, true, 0, true, true)
	SetCamRot(Camera, 0.0, 0.0, 320.0, 2)
	SetCamActive(Camera, true)

	Characters = vSERVER.Characters()
	if parseInt(#Characters) > 0 then
		Customization(Characters[1])
	end

	Wait(5000)

	SendNUIMessage({ name = "Spawn", payload = Characters })
	SetNuiFocus(true, true)

	if IsScreenFadedOut() then
		DoScreenFadeIn(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterChosen", function(Data, Callback)
	if vSERVER.ChosenCharacter(Data["Passport"]) then
		SendNUIMessage({ name = "Close" })
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("NewCharacter", function(Data, Callback)
	Callback(vSERVER.NewCharacter(Data["name"], Data["lastname"], Data["sex"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWITCHCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("SwitchCharacter", function(Data, Callback)
	for _, v in pairs(Characters) do
		if v["Passport"] == Data["Passport"] then
			Customization(v, true)
			break
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Finish")
AddEventHandler("spawn:Finish", function(Open, Barbershop)
	if Open then
		Locate[1] = { ["Coords"] = Barbershop, ["name"] = "" }

		for Number,v in pairs(Locate) do
			local Road = GetStreetNameAtCoord(v["Coords"]["x"], v["Coords"]["y"], v["Coords"]["z"])
			Locate[Number]["name"] = GetStreetNameFromHashKey(Road)
		end

		SetCamCoord(Camera, Locate[1]["Coords"]["x"], Locate[1]["Coords"]["y"], Locate[1]["Coords"]["z"] + 1)
		SendNUIMessage({ name = "Location", payload = Locate })
		LocalPlayer["state"]:set("Charizard", true, false)
		SetEntityVisible(PlayerPedId(), false, 0)
		SetCamRot(Camera, 0.0, 0.0, 0.0, 2)
	else
		SetEntityVisible(PlayerPedId(), true, 0)
		LocalPlayer["state"]:set("Charizard", false, false)
		TriggerServerEvent("vRP:BucketClient", "Exit")
		SendNUIMessage({ name = "Close" })
		TriggerEvent("hud:Active", true)
		SetNuiFocus(false, false)

		if DoesCamExist(Camera) then
			RenderScriptCams(false, false, 0, false, false)
			SetCamActive(Camera, false)
			DestroyCam(Camera, false)
			Camera = nil
		end

		if Barbershop then
			Wait(1000)
			TriggerServerEvent("vRP:BucketClient", "Enter")
			TriggerEvent("barbershop:Open", "open")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Spawn", function(Data, Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false, false, 0, false, false)
		SetCamActive(Camera, false)
		DestroyCam(Camera, false)
		Camera = nil
	end

	SetEntityVisible(PlayerPedId(), true, 0)
	LocalPlayer["state"]:set("Charizard", false, false)
	TriggerServerEvent("vRP:BucketClient", "Exit")
	TriggerServerEvent("vRP:OnlyObjects")
	SendNUIMessage({ name = "Close" })
	TriggerEvent("hud:Active", true)
	SetNuiFocus(false, false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Chosen", function(Data, Callback)
	local Ped = PlayerPedId()
	local Index = Data["index"]

	SetEntityCoords(Ped, Locate[Index]["Coords"]["x"], Locate[Index]["Coords"]["y"], Locate[Index]["Coords"]["z"] - 1)
	SetCamCoord(Camera, Locate[Index]["Coords"]["x"], Locate[Index]["Coords"]["y"], Locate[Index]["Coords"]["z"] + 1)
	SetCamRot(Camera, 0.0, 0.0, 0.0, 2)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Customization(Table, Check)
	if LoadModel(Table["Skin"]) then
		if Check then
			if GetEntityModel(PlayerPedId()) ~= GetHashKey(Table["Skin"]) then
				SetPlayerModel(PlayerId(), Table["Skin"])
				SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 1)
			end
		else
			SetPlayerModel(PlayerId(), Table["Skin"])
			SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 1)
		end

		local Ped = PlayerPedId()
		local Random = math.random(#Anims)
		if LoadAnim(Anims[Random]["Dict"]) then
			TaskPlayAnim(Ped, Anims[Random]["Dict"], Anims[Random]["Name"], 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		end

		exports["skinshop"]:Apply(Table["Clothes"], Ped)
		exports["barbershop"]:Apply(Table["Barber"], Ped)
		exports["tattooshop"]:Apply(Table["Tattoos"], Ped)

		SetEntityVisible(Ped, true, 0)
		LocalPlayer["state"]:set("Charizard", false, false)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:INCREMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Increment")
AddEventHandler("spawn:Increment", function(Tables)
	for _, v in pairs(Tables) do
		Locate[#Locate + 1] = { ["Coords"] = v["Coords"], ["name"] = "" }
	end
end)
