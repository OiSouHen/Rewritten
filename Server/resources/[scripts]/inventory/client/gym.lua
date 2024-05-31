-----------------------------------------------------------------------------------------------------------------------------------------
-- GYMTASKS
-----------------------------------------------------------------------------------------------------------------------------------------
GymTasks = {
	[1] = {
		["Name"] = "Barra",
		["Coords"] = { -1204.85, -1564.27, 4.6, 28.35 },
		["Duration"] = 60,
		["Progress"] = 60000,
		["Anim"] = "malhar2",
		["Value"] = 2,
		["Event"] = "emotes"
	},
	[2] = {
		["Name"] = "Biceps",
		["Coords"] = { -1202.72, -1565.35, 4.62, 218.27 },
		["Duration"] = 60,
		["Progress"] = 60000,
		["Animation"] = { "amb@world_human_muscle_free_weights@male@barbell@base","base" },
		["Anim"] = "malhar",
		["Value"] = 2,
		["Event"] = "emotes"
	},
	[3] = {
		["Name"] = "Barra",
		["Coords"] = { -1225.047, -1600.19, 4.18, 85.04 },
		["Duration"] = 60,
		["Progress"] = 60000,
		["Anim"] = "malhar2",
		["Value"] = 2,
		["Event"] = "emotes"
	},
	[4] = {
		["Name"] = "Barra",
		["Coords"] = { -1240.25, -1599.69, 4.16, 31.19 },
		["Duration"] = 60,
		["Progress"] = 60000,
		["Anim"] = "malhar2",
		["Value"] = 2,
		["Event"] = "emotes"
	},
	[5] = {
		["Name"] = "Barra",
		["Coords"] = { -1200.03, -1571.18, 4.6, 223.94 },
		["Duration"] = 60,
		["Progress"] = 60000,
		["Anim"] = "malhar2",
		["Value"] = 2,
		["Event"] = "emotes"
	},
	[6] = {
		["Name"] = "Biceps",
		["Coords"] = { -1196.88, -1573.14, 4.62, 31.19 },
		["Duration"] = 60,
		["Progress"] = 60000,
		["Anim"] = "malhar",
		["Value"] = 2,
		["Event"] = "emotes"
	},
	[7] = {
		["Name"] = "Flexao",
		["Coords"] = { -1206.35, -1568.08, 4.6, 121.89 },
		["Duration"] = 30,
		["Progress"] = 30000,
		["Anim"] = "flexao",
		["Value"] = 1,
		["Event"] = "emotes"
	},
	[8] = {
		["Name"] = "Flexao",
		["Coords"] = { -1207.92, -1566.3, 4.6, 130.4 },
		["Duration"] = 30,
		["Progress"] = 30000,
		["Anim"] = "flexao",
		["Value"] = 1,
		["Event"] = "emotes"
	},
	[9] = {
		["Name"] = "Abdominal",
		["Coords"] = { -1201.58, -1561.35, 4.62, 121.89 },
		["Duration"] = 30,
		["Progress"] = 30000,
		["Anim"] = "abdominal",
		["Value"] = 1,
		["Event"] = "emotes"
	},
	[10] = {
		["Name"] = "Abdominal",
		["Coords"] = { -1199.73, -1563.54, 4.62, 121.89 },
		["Duration"] = 30,
		["Progress"] = 30000,
		["Anim"] = "abdominal",
		["Value"] = 1,
		["Event"] = "emotes"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Seconds = 0
local OnGym = false
local HasObject = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for k,v in pairs(GymTasks) do
				local Distance = #(Coords - vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3]))
				if Distance <= 1.0 then
					TimeDistance = 1

					if not OnGym then
						GymDrawText3D(v["Coords"][1],v["Coords"][2],v["Coords"][3],"~g~E~w~   "..string.upper(v["Name"]))
					end

					if IsControlJustPressed(1,38) and Seconds <= 0 then
						if vSERVER.CheckGym() then
							Seconds = parseInt(v["Duration"])

							if not OnGym then
								OnGym = true

								SetEntityCoords(Ped,v["Coords"][1],v["Coords"][2],v["Coords"][3])
								SetEntityHeading(Ped,v["Coords"][4])

								TriggerEvent("Progress","Malhando",v["Progress"])

								if v["Anim"] and v["Event"] then
									TriggerEvent(v["Event"],v["Anim"])
									HasObject = true
								end
								
								while OnGym do
									if Seconds == 0 then
										vSERVER.StartGym(v["Value"])

										OnGym = false
										if HasObject then
											vSERVER.StopGym()
										else
											vSERVER.StopGym()
										end

										break
									end

									Wait(1000)
								end
							end
						end

					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Seconds > 0 then
			Seconds = Seconds - 1
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GYMDRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function GymDrawText3D(x,y,z,Text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,150)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(_x,_y)

		local Width = string.len(Text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,Width,0.03,15,15,15,175)
	end
end