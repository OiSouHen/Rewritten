-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
local Treatment = false
local TreatmentTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Beds = {
	-- Medical Center Sul
	{ ["Coords"] = vec3(307.72, -581.74, 43.2), ["Heading"] = 340.16 },
	{ ["Coords"] = vec3(311.06, -582.96, 43.2), ["Heading"] = 340.16 },
	{ ["Coords"] = vec3(314.46, -584.2, 43.2),  ["Heading"] = 340.16 },
	{ ["Coords"] = vec3(317.68, -585.37, 43.2), ["Heading"] = 340.16 },
	{ ["Coords"] = vec3(322.62, -587.16, 43.2), ["Heading"] = 340.16 },
	{ ["Coords"] = vec3(324.26, -582.8, 43.2),  ["Heading"] = 158.75 },
	{ ["Coords"] = vec3(319.42, -581.05, 43.2), ["Heading"] = 158.75 },
	{ ["Coords"] = vec3(313.93, -579.04, 43.2), ["Heading"] = 158.75 },
	{ ["Coords"] = vec3(309.35, -577.38, 43.2), ["Heading"] = 158.75 },
	{ ["Coords"] = vec3(363.8, -589.12, 43.21), ["Heading"] = 68.04 },
	{ ["Coords"] = vec3(364.96, -585.94, 43.21), ["Heading"] = 68.04 },
	{ ["Coords"] = vec3(366.52, -581.67, 43.21), ["Heading"] = 68.04 },
	{ ["Coords"] = vec3(354.44, -600.19, 43.21), ["Heading"] = 68.04 },
	{ ["Coords"] = vec3(359.53, -586.23, 43.2), ["Heading"] = 68.04 },
	{ ["Coords"] = vec3(361.36, -581.3, 43.2),  ["Heading"] = 68.04 },
	-- Medical Center Norte
	{ ["Coords"] = vec3(-252.15, 6323.11, 32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-250.5, 6321.87, 32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-246.98, 6317.95, 32.33), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-245.27, 6316.22, 32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-251.03, 6310.51, 32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-252.63, 6312.12, 32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-254.39, 6313.88, 32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-256.1, 6315.58, 32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-258.03, 6317.12, 32.35), ["Heading"] = 317.49 },
	-- Boolingbroke
	{ ["Coords"] = vec3(1761.87, 2591.56, 45.66), ["Heading"] = 272.13 },
	{ ["Coords"] = vec3(1761.87, 2594.64, 45.66), ["Heading"] = 272.13 },
	{ ["Coords"] = vec3(1761.87, 2597.73, 45.66), ["Heading"] = 272.13 },
	{ ["Coords"] = vec3(1771.98, 2597.95, 45.66), ["Heading"] = 87.88 },
	{ ["Coords"] = vec3(1771.98, 2594.88, 45.66), ["Heading"] = 87.88 },
	{ ["Coords"] = vec3(1771.98, 2591.79, 45.66), ["Heading"] = 87.88 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(Beds) do
		AddBoxZone("Beds:"..Number, v["Coords"], 2.0, 1.0, {
			name = "Beds:"..Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"] - 0.10,
			maxZ = v["Coords"]["z"] + 0.50
		}, {
			shop = Number,
			Distance = 1.50,
			options = {
				{
					event = "target:PutBed",
					label = "Deitar",
					tunnel = "client"
				}, {
					event = "target:Treatment",
					label = "Tratamento",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PUTBED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:PutBed")
AddEventHandler("target:PutBed", function(Number)
	if not Previous then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped, Beds[Number]["Coords"]["x"], Beds[Number]["Coords"]["y"], Beds[Number]["Coords"]["z"] - 1, false, false, false, false)
		vRP.PlayAnim(false, { "amb@world_human_sunbathe@female@back@idle_a", "idle_a" }, true)
		SetEntityHeading(Ped, Beds[Number]["Heading"] - 180.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPBED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:UpBed")
AddEventHandler("target:UpBed", function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped, Previous["x"], Previous["y"], Previous["z"] - 1, false, false, false, false)
		Previous = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Treatment")
AddEventHandler("target:Treatment", function(Number)
	if not Previous and vSERVER.CheckIn() then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped, Beds[Number]["Coords"]["x"], Beds[Number]["Coords"]["y"], Beds[Number]["Coords"]["z"] - 1, false, false, false, false)
		vRP.PlayAnim(false, { "amb@world_human_sunbathe@female@back@idle_a", "idle_a" }, true)
		SetEntityHeading(Ped, Beds[Number]["Heading"] - 180.0)

		TriggerEvent("inventory:preventWeapon")
		LocalPlayer["state"]:set("Commands", true, true)
		LocalPlayer["state"]:set("Buttons", true, true)
		LocalPlayer["state"]:set("Cancel", true, true)
		NetworkSetFriendlyFireOption(false)
		TriggerEvent("paramedic:Reset")

		if GetEntityHealth(Ped) <= 100 then
			exports["survival"]:Revive(101)
		end

		Treatment = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:StartTreatment")
AddEventHandler("target:StartTreatment", function()
	if not Treatment then
		LocalPlayer["state"]:set("Commands", true, true)
		LocalPlayer["state"]:set("Buttons", true, true)
		LocalPlayer["state"]:set("Cancel", true, true)
		NetworkSetFriendlyFireOption(false)
		TriggerEvent("paramedic:Reset")
		Treatment = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBEDS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if Previous and not IsEntityPlayingAnim(Ped, "amb@world_human_sunbathe@female@back@idle_a", "idle_a", 3) then
			SetEntityCoords(Ped, Previous["x"], Previous["y"], Previous["z"] - 1, false, false, false, false)
			Previous = nil
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Treatment then
			if GetGameTimer() >= TreatmentTimer then
				local Ped = PlayerPedId()
				local Health = GetEntityHealth(Ped)
				TreatmentTimer = GetGameTimer() + 1000

				if Health < 200 then
					SetEntityHealth(Ped, Health + 1)
				else
					Treatment = false
					NetworkSetFriendlyFireOption(true)
					LocalPlayer["state"]:set("Cancel", false, true)
					LocalPlayer["state"]:set("Buttons", false, true)
					LocalPlayer["state"]:set("Commands", false, true)
					TriggerEvent("Notify", "verde", "Tratamento concluido.", "Sucesso", 5000)
				end
			end
		end

		Wait(1000)
	end
end)