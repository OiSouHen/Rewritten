-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("notepad")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart", function(Resource)
	if GetCurrentResourceName() == Resource then
		SetNuiFocus(false, false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATENOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("notepad:createNotepad")
AddEventHandler("notepad:createNotepad", function()
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "showNotepad" })
	vRP.CreateObjects("amb@medic@standing@timeofdeath@base", "base", "prop_notepad_01", 49, 60309)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ESCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("escape", function(Data, Callback)
	SetNuiFocus(false, false)
	vRP.Destroy("one")
	SendNUIMessage({ action = "hideNotepad" })

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EDITNOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("editNote", function(Data, Callback)
	SetNuiFocus(false, false)
	vRP.Destroy("one")
	SendNUIMessage({ action = "hideNotepad" })
	vSERVER.editNotepad(Data["id"], Data["text"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPNOTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropNote", function(Data, Callback)
	SetNuiFocus(false, false)
	vRP.Destroy("one")
	vSERVER.createNotepad(Data["text"])
	SendNUIMessage({ action = "hideNotepad" })

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADNOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)
			for k, v in pairs(GlobalState["Notepad"]) do
				local Distance = #(Coords - vec3(v["x"], v["y"], v["z"]))
				if Distance <= 5 then
					TimeDistance = 1
					DrawText3Ds(v["x"], v["y"], v["z"] - 0.8, "~g~G~w~   LER     ~y~H~w~   DESTRUIR")

					if Distance <= 1.2 then
						if IsControlJustPressed(1, 47) then
							SetNuiFocus(true, true)
							SendNUIMessage({ action = "showNotepad2", text = v["text"], id = v["id"] })
							vRP.CreateObjects("amb@medic@standing@timeofdeath@base", "base", "prop_notepad_01", 49, 60309)
						elseif IsControlJustPressed(1, 304) then
							vSERVER.destroyNotepad(v["id"])
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x, y, z, text)
	local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255, 255, 255, 150)
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x, _y)

		local width = string.len(text) / 190 * 0.45
		DrawRect(_x, _y + 0.0125, width, 0.03, 15, 15, 15, 175)
	end
end
