-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Objects = {}
local Config = {
	["WEAPON_THERMAL"] = {
		["Bone"] = 24818,
		["x"] = 0.27,
		["y"] = -0.15,
		["z"] = 0.22,
		["RotX"] = 0.0,
		["RotY"] = 220.0,
		["RotZ"] = 2.5,
		["Model"] = "w_me_thermal"
	},
	["WEAPON_FROST"] = {
		["Bone"] = 24818,
		["x"] = 0.27,
		["y"] = -0.15,
		["z"] = 0.22,
		["RotX"] = 0.0,
		["RotY"] = 220.0,
		["RotZ"] = 2.5,
		["Model"] = "w_me_frost"
	},
	["WEAPON_KATANA"] = {
		["Bone"] = 24818,
		["x"] = 0.27,
		["y"] = -0.15,
		["z"] = 0.22,
		["RotX"] = 0.0,
		["RotY"] = 220.0,
		["RotZ"] = 2.5,
		["Model"] = "w_me_katana"
	},
	["WEAPON_COLTXM177"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_coltxm177"
	},
	["WEAPON_FNSCAR"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_fnscar"
	},
	["WEAPON_QBZ83"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_qbz83"
	},
	["WEAPON_CARBINERIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_carbinerifle"
	},
	["WEAPON_M4A4"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_m4a4"
	},
	["WEAPON_CARBINERIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_carbineriflemk2"
	},
	["WEAPON_ADVANCEDRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_advancedrifle"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_bullpuprifle"
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_bullpupriflemk2"
	},
	["WEAPON_SPECIALCARBINE"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_specialcarbine"
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_specialcarbinemk2"
	},
	["WEAPON_PARAFAL"] = {
		["Bone"] = 24818,
		["x"] = 0.0,
		["y"] = -0.14,
		["z"] = -0.12,
		["RotX"] = 0.0,
		["RotY"] = 360.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_parafal"
	},
	["WEAPON_FNFAL"] = {
		["Bone"] = 24818,
		["x"] = 0.0,
		["y"] = -0.14,
		["z"] = 0.12,
		["RotX"] = 180.0,
		["RotY"] = 360.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_fnfal"
	},
	["WEAPON_MUSKET"] = {
		["Bone"] = 24818,
		["x"] = -0.1,
		["y"] = -0.14,
		["z"] = 0.0,
		["RotX"] = 0.0,
		["RotY"] = 0.8,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_musket"
	},
	["WEAPON_BAT"] = {
		["Bone"] = 24818,
		["x"] = -0.18,
		["y"] = -0.18,
		["z"] = 0.0,
		["RotX"] = 0.0,
		["RotY"] = 90.0,
		["RotZ"] = 2.5,
		["Model"] = "w_me_bat"
	},
	["WEAPON_SAUER"] = {
		["Bone"] = 24818,
		["x"] = -0.0,
		["y"] = -0.16,
		["z"] = -0.1,
		["RotX"] = 0.0,
		["RotY"] = 0.8,
		["RotZ"] = 2.5,
		["Model"] = "w_sr_sauer"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sg_pumpshotgun"
	},
	["WEAPON_RPG"] = {
		["Bone"] = 24818,
		["x"] = -0.20,
		["y"] = -0.22,
		["z"] = 0.0,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5, 2.5,
		["Model"] = "w_lr_rpg"
	},
	["WEAPON_PUMPSHOTGUN_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sg_pumpshotgunmk2"
	},
	["WEAPON_SMG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_smg"
	},
	["WEAPON_SMG_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.22,
		["y"] = -0.14,
		["z"] = 0.12,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_smgmk2"
	},
	["WEAPON_COMPACTRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.22,
		["y"] = -0.14,
		["z"] = 0.12,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_assaultrifle_smg"
	},
	["WEAPON_ASSAULTSMG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.07,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_assaultsmg"
	},
	["WEAPON_HEAVYRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_heavyrifleh"
	},
	["WEAPON_TACTICALRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_carbinerifle_reh"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_assaultrifle"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 2.5,
		["Model"] = "w_ar_assaultrifle"
	},
	["WEAPON_GUSENBERG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.10,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 2.5,
		["Model"] = "w_sb_gusenberg"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RemoveWeapon")
AddEventHandler("inventory:RemoveWeapon", function(Name)
	local Split = splitString(Name, "-")
	local Name = Split[1]

	if Objects[Name] then
		TriggerServerEvent("DeleteObject", 0, Name)
		Objects[Name] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CREATEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CreateWeapon")
AddEventHandler("inventory:CreateWeapon", function(Name)
	local Split = splitString(Name, "-")
	local Name = Split[1]

	if not Objects[Name] and Config[Name] then
		local Ped = PlayerPedId()
		local Config = Config[Name]
		local Coords = GetEntityCoords(Ped)
		local Bone = GetPedBoneIndex(Ped, Config["Bone"])

		local Progression, Network = vRPS.CreateObject(Config["Model"], Coords["x"], Coords["y"], Coords["z"], Name)
		if Progression then
			Objects[Name] = LoadNetwork(Network)
			if Objects[Name] then
				AttachEntityToEntity(Objects[Name], Ped, Bone, Config["x"], Config["y"], Config["z"], Config["RotX"], Config["RotY"], Config["RotZ"], true, true, false, true, 2, true)
				SetEntityCompletelyDisableCollision(Objects[Name], false, true)
				SetModelAsNoLongerNeeded(Config["Model"])
			else
				TriggerServerEvent("DeleteObject", 0, Name)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHAKECONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local ShakeWait = 50
local ShakeIntensity = 0.2
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEDAMAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function TakeDamage()
	local PlayerPed = GetPlayerPed(-1)

	if not IsEntityDead(PlayerPed) then
		ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", ShakeIntensity)

		Wait(ShakeWait)

		StopGameplayCamShaking(false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:TAKEDAMAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:TakeDamage")
AddEventHandler("inventory:TakeDamage", function()
	TakeDamage()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHAKETHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local EntityHealth = GetEntityHealth(GetPlayerPed(-1))

	while true do
		Wait(0)

		local PlayerPed = GetPlayerPed(-1)
		local CurrentHealth = GetEntityHealth(PlayerPed)

		if EntityHealth > CurrentHealth then
			EntityHealth = CurrentHealth
			TriggerEvent("inventory:TakeDamage")
		else
			EntityHealth = CurrentHealth
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRECOIL
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()

		if IsPedArmed(Ped, 6) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)

			Wait(1)
		else
			Wait(1000)
		end

		if IsPedShooting(Ped) then
			local Cam = GetFollowPedCamViewMode()
			local InVehicle = IsPedInAnyVehicle(Ped)

			local Speed = math.ceil(GetEntitySpeed(Ped))
			if Speed > 70 then
				Speed = 70
			end

			local _,Weapon = GetCurrentPedWeapon(Ped)
			local Class = GetWeapontypeGroup(Weapon)
			local Pitch = GetGameplayCamRelativePitch()
			local CameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(Ped))

			local Recoil = math.random(110, 120 + (math.ceil(Speed * 0.5))) / 100
			local Rifle = false

			if Class == 970310034 or Class == 1159398588 then
				Rifle = true
			end

			if CameraDistance < 5.3 then
				CameraDistance = 1.5
			else
				if CameraDistance < 8.0 then
					CameraDistance = 4.0
				else
					CameraDistance =  7.0
				end
			end

			if InVehicle then
				Recoil = Recoil + (Recoil * CameraDistance)
			else
				Recoil = Recoil * 0.1
			end

			if Cam == 4 then
				Recoil = Recoil * 0.6

				if Rifle then
					Recoil = Recoil * 0.1
				end
			end

			if Rifle then
				Recoil = Recoil * 0.6
			end

			local Spread = math.random(4)
			local Head = GetGameplayCamRelativeHeading()
			local HeadSpeed = math.random(10, 40 + Speed) / 100

			if InVehicle then
				HeadSpeed = HeadSpeed * 2.0
			end

			if Spread == 1 then
				SetGameplayCamRelativeHeading(Head + HeadSpeed)
			elseif Spread == 2 then
				SetGameplayCamRelativeHeading(Head - HeadSpeed)
			end

			local Set = Pitch + Recoil
			SetGameplayCamRelativePitch(Set, 0.8)
		end
	end
end)