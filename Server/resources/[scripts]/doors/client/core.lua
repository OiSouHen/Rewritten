-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("doors")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Display = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(GlobalState["Doors"]) do
		if IsDoorRegisteredWithSystem(Number) then
			RemoveDoorFromSystem(Number)
		end

		AddDoorToSystem(Number,v["Hash"],v["Coords"],false,false,true)

		DoorSystemSetOpenRatio(Number,0.0,false,true)
		DoorSystemSetAutomaticRate(Number,2.5,false,true)
		DoorSystemSetDoorState(Number,v["Lock"] and 1 or 0,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Doors",nil,function(Name,Key,Value)
	for Number,v in pairs(Value) do
		DoorSystemSetOpenRatio(Number,0.0,false,true)
		DoorSystemSetAutomaticRate(Number,2.5,false,true)
		DoorSystemSetDoorState(Number,v["Lock"] and 1 or 0,true)

		if v["Other"] then
			DoorSystemSetOpenRatio(v["Other"],0.0,false,true)
			DoorSystemSetAutomaticRate(v["Other"],2.5,false,true)
			DoorSystemSetDoorState(v["Other"],v["Lock"] and 1 or 0,true)
		end

		if Display[Number] then
			SendNUIMessage({ name = "Show", payload = { "E",v["Lock"] and "Trancado" or "Destrancado","Pressione o botão" } })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number,v in pairs(GlobalState["Doors"]) do
			if not v["Disabled"] then
				if #(Coords - v["Coords"]) <= v["Distance"] then
					TimeDistance = 1

					if not Display[Number] then
						SendNUIMessage({ name = "Show", payload = { "E",v["Lock"] and "Trancado" or "Destrancado","Pressione o botão" } })
						Display[Number] = true
					end

					if IsControlJustPressed(1,38) then
						vSERVER.Permission(Number)
					end
				else
					if Display[Number] then
						SendNUIMessage({ name = "Hide" })
						Display[Number] = nil
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)