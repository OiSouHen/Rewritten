-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
InCamera = false
SelectedCamera = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERAS
-----------------------------------------------------------------------------------------------------------------------------------------
local Cameras = {
	["1"] = { 433.93,-978.23,34.72,104.89 },
	["2"] = { 424.59,-996.6,34.72,119.06 },
	["3"] = { 438.16,-999.32,33.72,192.76 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CAMERANUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CameraNumber")
AddEventHandler("inventory:CameraNumber", function()
	if not IsPauseMenuActive() then
		if not LocalPlayer["state"]["Commands"] and not Dynamic and MumbleIsConnected() then
			if LocalPlayer["state"]["Policia"] then
				exports["dynamic"]:AddButton("1", "Clique para acessar a câmera.", "inventory:ServiceCameras", 1, false, false)
				exports["dynamic"]:AddButton("2", "Clique para acessar a câmera.", "inventory:ServiceCameras", 2, false, false)
				exports["dynamic"]:AddButton("3", "Clique para acessar a câmera.", "inventory:ServiceCameras", 3, false, false)

				exports["dynamic"]:openMenu()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SERVICECAMERAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:ServiceCameras")
AddEventHandler("inventory:ServiceCameras",function(Number)
	TriggerEvent("dynamic:Close")

	if InCamera then
		ClearTimecycleModifier()
		DestroyCam(SelectedCamera, false)
		TriggerEvent("hud:Active", true)
		SetCamActive(SelectedCamera, false)
		RenderScriptCams(false, false, 1, true, true)
		PlaySoundFrontend(-1, "HACKING_SUCCESS", false)

		InCamera = false
		SelectedCamera = nil
	else
		if Cameras[Number] then
			InCamera = true
			TriggerEvent("hud:Active", false)
			SetTimecycleModifier("heliGunCam")
			PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
			SelectedCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Cameras[Number][1], Cameras[Number][2], Cameras[Number][3], 0.0 ,0.0, Cameras[Number][4], 60.00, false, 0)
			SetCamActive(SelectedCamera, true)
			RenderScriptCams(true, false, 1, true, true)

			TriggerEvent("Notify", "default", "Pressione <b>F6</b> para sair da câmera.", false, 5000)
		end
	end
end)