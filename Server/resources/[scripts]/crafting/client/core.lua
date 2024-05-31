-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Timer = 0
local Select = ""
local Cancel = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number = 1, #Crafting do
		exports["target"]:AddCircleZone("Crafting:"..Number, Crafting[Number][1], 0.5, {
			name = "Crafting:"..Number,
			heading = 0.0,
			useZ = true
		}, {
			shop = Number,
			Distance = 1.0,
			options = {
				{
					event = "crafting:Open",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:Open",function(Number)
	if Crafting[Number] then
		if vSERVER.Permission(Crafting[Number][2]) and not exports["hud"]:Wanted() then
			if Crafting[Number][2] ~= Select and GetGameTimer() < Timer then
				TriggerEvent("Notify", "azul", "Produção em andamento.", false, 5000)
			else
				Select = Crafting[Number][2]
				SetNuiFocus(true, true)
				SendNUIMessage({ action = "OpenCraft", data = vSERVER.Crafting(Crafting[Number][2]) })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data, Callback)
	SetNuiFocus(false, false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OWNED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Owned",function(Data, Callback)
	Callback(vSERVER.Owned(Data["id"], Data["key"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Cancel",function(Data, Callback)
	Cancel = true
	Timer = 0  

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Crafting",function(Data, Callback)
	if GetGameTimer() >= Timer then
		Timer = GetGameTimer() + Data["time"] * 1000
		Cancel = false

		SetTimeout(Data["time"] * 1000, function()
			if not Cancel then
				vSERVER.FunctionCrafting(Data["id"], Data["key"], Data["amount"])
			end
		end)

		Callback(true)
	else
		TriggerEvent("Notify", "azul", "Produção em andamento.", false, 5000)
		Callback(false)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:PHARMACY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:Pharmacy",function()
	if vSERVER.Permission("Pharmacy") and not exports["hud"]:Wanted() then
		if "Pharmacy" ~= Select and GetGameTimer() < Timer then
			TriggerEvent("Notify", "azul", "Produção em andamento.", false, 5000)
		else
			Select = "Pharmacy"
			SetNuiFocus(true, true)
			SendNUIMessage({ action = "OpenCraft", data = vSERVER.Crafting("Pharmacy") })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:MINERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:Minerman",function()
	if vSERVER.Permission("Mining") and not exports["hud"]:Wanted() then
		if "Mining" ~= Select and GetGameTimer() < Timer then
			TriggerEvent("Notify", "azul", "Produção em andamento.", false, 5000)
		else
			Select = "Mining"
			SetNuiFocus(true, true)
			SendNUIMessage({ action = "OpenCraft", data = vSERVER.Crafting("Mining") })
		end
	end
end)