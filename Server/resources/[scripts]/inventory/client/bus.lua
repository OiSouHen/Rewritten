-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Selected = 1
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUS:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bus:Init")
AddEventHandler("bus:Init",function()
	if vSERVER.CheckWork("Bus") then
		if Active then
			if DoesBlipExist(Blip) then
				RemoveBlip(Blip)
				Blip = nil
			end

			exports["target"]:LabelText("WorkBus","Trabalhar")
			TriggerEvent("Notify","amarelo","Trabalho finalizado.","Atenção",5000)
			Active = false
		else
			exports["target"]:LabelText("WorkBus","Finalizar")
			TriggerEvent("Notify","verde","Trabalho iniciado.","Sucesso",5000)
			Active = true
			MakeBlips()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Active then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				local Vehicle = GetVehiclePedIsUsing(Ped)
				if GetEntityArchetypeName(Vehicle) == "bus" then
					local Coords = GetEntityCoords(Ped)
					local Distance = #(Coords - BusLocations[Selected])

					if Distance <= 200 then
						TimeDistance = 1

						DrawMarker(22,BusLocations[Selected]["x"],BusLocations[Selected]["y"],BusLocations[Selected]["z"] + 3.0,0.0,0.0,0.0,0.0,180.0,0.0,7.5,7.5,5.0,65,130,226,100,0,0,0,1)
						DrawMarker(1,BusLocations[Selected]["x"],BusLocations[Selected]["y"],BusLocations[Selected]["z"] - 3.0,0.0,0.0,0.0,0.0,0.0,0.0,15.0,15.0,10.0,255,255,255,50,0,0,0,0)

						if Distance <= 10 then
							vSERVER.PaymentBus(Selected)

							if Selected >= #BusLocations then
								Selected = 1
							else
								Selected = Selected + 1
							end

							MakeBlips()
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(BusLocations[Selected]["x"],BusLocations[Selected]["y"],BusLocations[Selected]["z"])
	SetBlipSprite(Blip,1)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,77)
	SetBlipScale(Blip,0.75)
	SetBlipRoute(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Motorista")
	EndTextCommandSetBlipName(Blip)
end