-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local distance_light = false
local distance_shadow = false
local distance_vue_lod = false
local distance_texture = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALTHREADWITHOUTINFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	distance_vue_lod = GetResourceKvpInt("view_lod")
	distance_shadow = GetResourceKvpInt("dist_shadow")
	distance_light = GetResourceKvpInt("dist_light")
	distance_texture = GetResourceKvpInt("dist_texture")

	if not distance_vue_lod then
		distance_vue_lod = 0
		SetResourceKvpInt("view_lod", distance_vue_lod)
	end

	if not distance_texture then
		distance_texture = 0
		SetResourceKvpInt("dist_texture", distance_texture)
	end

	if not distance_shadow then
		distance_shadow = 0
		SetResourceKvpInt("dist_shadow", distance_shadow)
	end

	if not distance_light then
		distance_light = 0
		SetResourceKvpInt("dist_light", distance_light)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALTHREADINFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if distance_vue_lod == 0 then
			OverrideLodscaleThisFrame(1.0)
		else
			OverrideLodscaleThisFrame((1 - tonumber("0."..distance_vue_lod)))
		end

		if distance_light >= 1 then
			SetLightsCutoffDistanceTweak(distance_light == 1 and 0.3 or 0.0)
			SetFlashLightFadeDistance(distance_light == 1 and 0.3 or 0.0)
			DisableVehicleDistantlights(true)
		else
			SetLightsCutoffDistanceTweak(1.0)
			SetFlashLightFadeDistance(1.0)
		end

		if distance_shadow >= 1 then
			RopeDrawShadowEnabled(true)
			CascadeShadowsClearShadowSampleType()
			CascadeShadowsSetAircraftMode(true)
			CascadeShadowsEnableEntityTracker(true)
			CascadeShadowsSetDynamicDepthMode(true)
			CascadeShadowsInitSession()
			CascadeShadowsSetEntityTrackerScale(distance_shadow == 1 and 0.1 or 0.0)
			CascadeShadowsSetDynamicDepthValue(distance_shadow == 1 and 0.1 or 0.0)
			CascadeShadowsSetCascadeBoundsScale(distance_shadow == 1 and 0.1 or 0.0)
			SetPedAoBlobRendering(PlayerPedId(), true)
			SetTimecycleModifier("cinema")
		else
			RopeDrawShadowEnabled(false)
			CascadeShadowsSetAircraftMode(false)
			CascadeShadowsEnableEntityTracker(false)
			CascadeShadowsSetDynamicDepthMode(false)
			CascadeShadowsSetEntityTrackerScale(1.0)
			CascadeShadowsSetDynamicDepthValue(1.0)
			CascadeShadowsSetCascadeBoundsScale(1.0)
			SetPedAoBlobRendering(PlayerPedId(), false)
			ClearTimecycleModifier()
		end

		Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fps", function()
	SetNuiFocus(true, true)
	SendNUIMessage({ Action = "Display", distance = distance_vue_lod, light = distance_light, texture = distance_texture, shadow = distance_shadow })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save", function(data, cb)
	distance_vue_lod = tonumber(data.distance)
	distance_shadow = tonumber(data.shadow)
	distance_light = tonumber(data.light)
	distance_texture = tonumber(data.texture)

	SetResourceKvpInt("dist_light", distance_light)
	SetResourceKvpInt("dist_shadow", distance_shadow)
	SetResourceKvpInt("dist_texture", distance_texture)
	SetResourceKvpInt("view_lod", distance_vue_lod)

	SetNuiFocus(false, false)

	TriggerEvent("Notify", "default", "Distância das <b>Luzes</b> em: <b>"..distance_light.."</b>.<br>Distância das <b>Texturas</b> em: <b>"..distance_texture.."</b>.<br>Distância das <b>Sombras</b> em: <b>"..distance_shadow.."</b>.<br>Distância de <b>Carregamento</b> em: <b>"..distance_vue_lod.."</b>.", "Controle de Gráficos", 5000)
end)