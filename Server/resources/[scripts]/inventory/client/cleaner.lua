-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Working = false
local ServicesDone = {}
local ServicesBlips = {}
local PropertysBlips = {}
local WorkingProperty = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANER:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cleaner:Init")
AddEventHandler("cleaner:Init", function()
	if not vSERVER.CheckWork("Cleaner") then
		return
	end

	if Working then
		exports["target"]:LabelText("WorkCleaner", "Trabalhar")
		TriggerEvent("Notify", "amarelo", "Trabalho finalizado.", "Atenção", 5000)
		ManageBlips("Propertys", false)
		FinishService()
	else
		exports["target"]:LabelText("WorkCleaner", "Finalizar")
		TriggerEvent("Notify", "verde", "Trabalho iniciado.", "Sucesso", 5000)
		ManageBlips("Propertys", true)
		StartWorking()
	end

	Working = not Working
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTWORKING
-----------------------------------------------------------------------------------------------------------------------------------------
function StartWorking()
    CreateThread(function()
        while Working do
            local Ped = PlayerPedId()
            local PedCoords = GetEntityCoords(Ped)

            if not WorkingProperty then
                for k,v in pairs(PropertysCleaner) do
                    local Distance = #(PedCoords - vec3(v["Entrance"][1], v["Entrance"][2], v["Entrance"][3]))

                    if Distance <= 30.0 then
                        DrawText3D(v["Entrance"][1], v["Entrance"][2], v["Entrance"][3], "~g~G~w~  INICIAR")

                        if Distance <= 0.75 and IsControlJustPressed(1, 47) and not IsPedInAnyVehicle(Ped) then
                            if vSERVER.CheckProperty(k) then
                                WorkingProperty = k
                                ManageBlips("Services", true)
                                TriggerEvent("Notify", "amarelo", "Você começou a limpar a casa <b>"..WorkingProperty.."</b>.", "Atenção", 5000)
                            end
                        end
                    end
                end
            else
                for k,v in pairs(PropertysCleaner[WorkingProperty]["Services"]) do
                    if not ServicesDone[k] then
                        local Distance = #(PedCoords - vec3(v[1], v[2], v[3]))

                        if Distance <= 15.0 then
                            DrawText3D(v[1], v[2], v[3], "~g~G~w~  "..(v[4]):upper())

                            if Distance <= 0.75 then
                                if IsControlJustPressed(1, 47) and not IsPedInAnyVehicle(Ped) then
                                    ServicesDone[k] = true

                                    if v[8] then
                                        vRP.CreateObjects(v[5], v[6], v[7], v[8], v[9])
                                    elseif v[6] then
                                        vRP.PlayAnim(false, { v[5], v[6] }, true)
                                    else
                                        vRP.PlayAnim(false, { task = v[5] }, false)
                                    end

                                    LocalPlayer["state"]["Cancel"] = true
                                    LocalPlayer["state"]["Commands"] = true

                                    TriggerEvent("Progress", "Limpando" ,( CleanerAnimationDuration * 1000 ))
                                    Wait(CleanerAnimationDuration * 1000)

                                    LocalPlayer["state"]["Cancel"] = false
                                    LocalPlayer["state"]["Commands"] = false

                                    vRP.Destroy()

                                    if DoesBlipExist(ServicesBlips[k]) then
                                        RemoveBlip(ServicesBlips[k])
                                    end

                                    if GetServicesComplete() >= #PropertysCleaner[WorkingProperty]["Services"] then
                                        TriggerEvent("Notify", "verde", "Você finalizou a limpeza na casa <b>"..WorkingProperty.."</b>.", "Sucesso", 5000)
                                        vSERVER.PaymentHouse(ServicesDone)
                                        FinishService()
                                    else
                                        TriggerEvent("Notify", "azul", "Continue trabalhando na residência.", false,5000)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            Wait(1)
        end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSERVICESCOMPLETE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetServicesComplete()
	local Count = 0
	for _, v in pairs(ServicesDone) do
		if v then
			Count += 1
		end
	end

	return Count
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function FinishService()
	ManageBlips("Services", false)
	WorkingProperty = false
	ServicesDone = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MANAGEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function ManageBlips(BlipType, Create)
	if Create then
		ManageBlips(BlipType, false)

		local TableToUse = BlipType == "Propertys" and PropertysCleaner or PropertysCleaner[WorkingProperty]["Services"]
		local BlipTable = BlipType == "Propertys" and PropertysBlips or ServicesBlips
		local BlipConfig = BlipsCleaner[BlipType]
		for k,v in pairs(TableToUse) do
			local x, y, z = 0.0, 0.0, 0.0
			local BlipName = BlipType == "Propertys" and "Serviço" or "~y~Tarefa:~w~ " .. v[4]

			if BlipType == "Propertys" then
				x, y, z = v["Entrance"][1], v["Entrance"][2], v["Entrance"][3]
			elseif BlipType == "Services" then
				x, y, z = v[1], v[2], v[3]
			end

			BlipTable[k] = AddBlipForCoord(x, y, z)
			SetBlipSprite(BlipTable[k], BlipConfig.Sprite)
			SetBlipAsShortRange(BlipTable[k], true)
			SetBlipColour(BlipTable[k], BlipConfig.Color)
			SetBlipScale(BlipTable[k], BlipConfig.Scale)
		end
	else
		local TableToDelete = BlipType == "Propertys" and PropertysBlips or ServicesBlips
		for k,v in pairs(TableToDelete) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,150)

		SetTextEntry("STRING")
		AddTextComponentString(text)
		EndTextCommandDisplayText(_x,_y)

		local Width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,Width,0.03,15,15,15,175)
	end
end