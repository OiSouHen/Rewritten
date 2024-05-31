-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Weapon = ""
local Timer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
local Drunk = 0
local DrunkTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
local Energetic = 0
local EnergeticTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- COCAINE
-----------------------------------------------------------------------------------------------------------------------------------------
local Cocaine = 0
local CocaineTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUSHROOM
-----------------------------------------------------------------------------------------------------------------------------------------
local Mushroom = 0
local MushroomTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- METHAMPHETAMINE
-----------------------------------------------------------------------------------------------------------------------------------------
local Methamphetamine = 0
local MethamphetamineTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- METADONE
-----------------------------------------------------------------------------------------------------------------------------------------
local Metadone = 0
local MetadoneTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEROIN
-----------------------------------------------------------------------------------------------------------------------------------------
local Heroin = 0
local HeroinTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRACK
-----------------------------------------------------------------------------------------------------------------------------------------
local Crack = 0
local CrackTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOATIVE
-----------------------------------------------------------------------------------------------------------------------------------------
local Radioative = 0
local RadioativeTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- JOINT
-----------------------------------------------------------------------------------------------------------------------------------------
local Joint = 0
local JointTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- OXYCONTIN
-----------------------------------------------------------------------------------------------------------------------------------------
local Oxycontin = 0
local OxycontinTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(Ped) then
			local Progress = 1000
			local Entitys = ClosestPed(2)
			if Entitys and not Entity(Entitys)["state"]["Drugs"] then
				TimeDistance = 1

				if IsControlJustPressed(1, 38) and GetGameTimer() >= Timer and GetVehiclePedIsIn(Entitys, true) == 0 and vSERVER.CheckDrugs() then
					Timer = GetGameTimer() + 5000

					ClearPedTasks(Entitys)
					ClearPedSecondaryTask(Entitys)
					ClearPedTasksImmediately(Entitys)

					TaskSetBlockingOfNonTemporaryEvents(Entitys, true)
					SetBlockingOfNonTemporaryEvents(Entitys, true)
					SetEntityAsMissionEntity(Entitys, true, true)
					SetPedDropsWeaponsWhenDead(Entitys, false)
					SetPedSuffersCriticalHits(Entitys, false)
					TaskTurnPedToFaceEntity(Entitys, Ped, 0.0)

					LocalPlayer["state"]:set("Buttons", true, true)
					LocalPlayer["state"]:set("Commands", true, true)
					Entity(Entitys)["state"]:set("Drugs", true, true)

					SetTimeout(1000, function()
						if LoadAnim("jh_1_ig_3-2") then
							TaskPlayAnim(Entitys, "jh_1_ig_3-2", "cs_jewelass_dual-2", 8.0, 8.0, -1, 16, 1, 0, 0, 0)
						end
					end)

					while true do
						local Ped = PlayerPedId()
						local Coords = GetEntityCoords(Ped)
						local EntityCoords = GetEntityCoords(Entitys)

						if #(Coords - EntityCoords) <= 2 then
							Progress = Progress - 1

							if Progress <= 0 and LoadModel("prop_anim_cash_note") then
								local Object = CreateObject("prop_anim_cash_note", Coords["x"], Coords["y"], Coords["z"], false, false, false)
								AttachEntityToEntity(Object, Entitys, GetPedBoneIndex(Entitys, 28422), 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, true, true, false, true, 2, true)
								vRP.CreateObjects("mp_safehouselost@", "package_dropoff", "prop_paper_bag_small", 16, 28422, 0.0, -0.05, 0.05, 180.0, 0.0, 0.0)
								SetModelAsNoLongerNeeded("prop_anim_cash_note")

								if LoadAnim("mp_safehouselost@") then
									TaskPlayAnim(Entitys, "mp_safehouselost@", "package_dropoff", 8.0, 8.0, -1, 16, 1, 0, 0, 0)
								end

								Wait(3000)

								if DoesEntityExist(Object) then
									DeleteEntity(Object)
								end

								LocalPlayer["state"]:set("Buttons", false, true)
								LocalPlayer["state"]:set("Commands", false, true)
								TaskWanderStandard(Entitys, 10.0, 10)
								SetEntityAsNoLongerNeeded(Entitys)
								vSERVER.PaymentDrugs()
								vRP.Destroy()

								break
							end
						else
							LocalPlayer["state"]:set("Buttons", false, true)
							LocalPlayer["state"]:set("Commands", false, true)
							TaskWanderStandard(Entitys, 10.0, 10)
							SetEntityAsNoLongerNeeded(Entitys)

							break
						end

						Wait(1)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPED
-----------------------------------------------------------------------------------------------------------------------------------------
function ClosestPed(Radius)
	local Selected = false
	local Ped = PlayerPedId()
	local Radius = Radius + 0.0001
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CPed")

	for _, Entity in pairs(GamePool) do
		if Entity ~= PlayerPedId() and not IsPedAPlayer(Entity) and not IsEntityDead(Entity) and not IsPedDeadOrDying(Entity, true) and NetworkGetEntityIsNetworked(Entity) and GetPedArmour(Entity) <= 0 and not IsPedInAnyVehicle(Entity) and GetPedType(Entity) ~= 28 then
			local EntityCoords = GetEntityCoords(Entity)
			local EntityDistance = #(Coords - EntityCoords)

			if EntityDistance < Radius then
				Radius = EntityDistance
				Selected = Entity
			end
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANEFFECTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("CleanEffectDrugs")
AddEventHandler("CleanEffectDrugs", function()
	if GetScreenEffectIsActive("HeistTripSkipFade") then
		StopScreenEffect("HeistTripSkipFade")
	end

	if GetScreenEffectIsActive("Dont_tazeme_bro") then
		StopScreenEffect("Dont_tazeme_bro")
	end

	if GetScreenEffectIsActive("DrugsDrivingOut") then
		StopScreenEffect("DrugsDrivingOut")
	end

	if GetScreenEffectIsActive("DeathFailMPDark") then
		StopScreenEffect("DeathFailMPDark")
	end

	if GetScreenEffectIsActive("DrugsMichaelAliensFight") then
		StopScreenEffect("DrugsMichaelAliensFight")
	end

	if GetScreenEffectIsActive("HeistCelebPassBW") then
		StopScreenEffect("HeistCelebPassBW")
	end

	if GetScreenEffectIsActive("DeathFailMPIn") then
		StopScreenEffect("DeathFailMPIn")
	end

	if GetScreenEffectIsActive("MinigameTransitionIn") then
		StopScreenEffect("MinigameTransitionIn")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Energetic")
AddEventHandler("Energetic", function(Timer, Number)
	Energetic = Energetic + Timer
	SetRunSprintMultiplierForPlayer(PlayerId(), Number)

	if not AnimpostfxIsRunning("HeistTripSkipFade") then
		AnimpostfxPlay("HeistTripSkipFade", 0, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COCAINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Cocaine")
AddEventHandler("Cocaine", function()
	if AnimpostfxIsRunning("MinigameTransitionIn") then
		AnimpostfxStop("MinigameTransitionIn")
	end

	AnimpostfxPlay("MinigameTransitionIn", 0, true)
	Cocaine = Cocaine + 30
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUSHROOM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Mushroom")
AddEventHandler("Mushroom", function()
	if AnimpostfxIsRunning("ExplosionJosh3") then
		AnimpostfxStop("ExplosionJosh3")
	end

	AnimpostfxPlay("ExplosionJosh3", 0, true)
	Mushroom = Mushroom + 30
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- METHAMPHETAMINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Methamphetamine")
AddEventHandler("Methamphetamine", function()
	if AnimpostfxIsRunning("Dont_tazeme_bro") then
		AnimpostfxStop("Dont_tazeme_bro")
	end

	AnimpostfxPlay("Dont_tazeme_bro", 0, true)
	Methamphetamine = Methamphetamine + 30
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Drunk")
AddEventHandler("Drunk", function()
	if AnimpostfxIsRunning("DrugsDrivingOut") then
		AnimpostfxStop("DrugsDrivingOut")
	end

	AnimpostfxPlay("DrugsDrivingOut", 0, true)
	Drunk = Drunk + 120

	if not LocalPlayer["state"]["Walk"] then
		LocalPlayer["state"]:set("Walk", "move_m@drunk@verydrunk", false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- METADONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Metadone")
AddEventHandler("Metadone", function()
	if AnimpostfxIsRunning("DeathFailMPDark") then
		AnimpostfxStop("DeathFailMPDark")
	end

	AnimpostfxPlay("DeathFailMPDark", 90000, false)

	if not LocalPlayer["state"]["Megazord"] then
		LocalPlayer["state"]:set("Megazord", true, false)
	end

	SetPlayerMeleeWeaponDamageModifier(PlayerId(), 1.1)
	SetPlayerWeaponDamageModifier(PlayerId(), 1.1)
	SetAiMeleeWeaponDamageModifier(7.5)
	SetAiWeaponDamageModifier(0.75)
	Metadone = Metadone + 600
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEROIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Heroin")
AddEventHandler("Heroin", function()
	if AnimpostfxIsRunning("DrugsMichaelAliensFight") then
		AnimpostfxStop("DrugsMichaelAliensFight")
	end

	AnimpostfxPlay("DrugsMichaelAliensFight", 90000, false)
	SetEntityMaxHealth(PlayerPedId(), 250)
	SetPedMaxHealth(PlayerPedId(), 250)
	TriggerEvent("Health")

	Heroin = 900
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Crack")
AddEventHandler("Crack", function()
	if AnimpostfxIsRunning("HeistCelebPassBW") then
		AnimpostfxStop("HeistCelebPassBW")
	end

	AnimpostfxPlay("HeistCelebPassBW", 90000, false)
	TriggerEvent("Hunger", 180000)
	TriggerEvent("Thirst", 180000)
	Crack = 900
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOATIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Radioative")
AddEventHandler("Radioative", function()
	if AnimpostfxIsRunning("HeistCelebPassBW") then
		AnimpostfxStop("HeistCelebPassBW")
	end

	AnimpostfxPlay("HeistCelebPassBW", 90000, false)
	TriggerEvent("Hunger", 180000)
	TriggerEvent("Thirst", 180000)
	Radioative = 900
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JOINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Joint")
AddEventHandler("Joint", function()
	if AnimpostfxIsRunning("DeathFailMPIn") then
		AnimpostfxStop("DeathFailMPIn")
	end

	AnimpostfxPlay("DeathFailMPIn", 0, true)
	Joint = Joint + 30
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OXYCONTIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Oxycontin")
AddEventHandler("Oxycontin", function()
	if AnimpostfxIsRunning("DrugsMichaelAliensFight") then
		AnimpostfxStop("DrugsMichaelAliensFight")
	end

	AnimpostfxPlay("DrugsMichaelAliensFight", 0, true)
	Oxycontin = 30
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMETH
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Pid = PlayerId()
		local Ped = PlayerPedId()

		if Energetic > 0 and GetGameTimer() >= EnergeticTimer then
			Energetic = Energetic - 1
			RestorePlayerStamina(Pid, 1.0)
			EnergeticTimer = GetGameTimer() + 1000

			if Energetic <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("HeistTripSkipFade") then
					AnimpostfxStop("HeistTripSkipFade")
				end

				if AnimpostfxIsRunning("MinigameTransitionIn") then
					AnimpostfxStop("MinigameTransitionIn")
				end

				SetRunSprintMultiplierForPlayer(Pid, 1.0)
				EnergeticTimer = GetGameTimer()
				Energetic = 0
			end
		end

		if Drunk > 0 and GetGameTimer() >= DrunkTimer then
			Drunk = Drunk - 1
			DrunkTimer = GetGameTimer() + 1000

			if Drunk <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("DrugsDrivingOut") then
					AnimpostfxStop("DrugsDrivingOut")
				end

				if LocalPlayer["state"]["Walk"] then
					LocalPlayer["state"]:set("Walk", false, false)
				end

				DrunkTimer = GetGameTimer()
				Drunk = 0
			end
		end

		if Cocaine > 0 and GetGameTimer() >= CocaineTimer then
			Cocaine = Cocaine - 1
			CocaineTimer = GetGameTimer() + 1000

			if Cocaine <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("MinigameTransitionIn") then
					AnimpostfxStop("MinigameTransitionIn")
				end

				CocaineTimer = GetGameTimer()
				Cocaine = 0
			end
		end

		if Mushroom > 0 and GetGameTimer() >= MushroomTimer then
			Mushroom = Mushroom - 1
			MushroomTimer = GetGameTimer() + 1000

			if Mushroom <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("ExplosionJosh3") then
					AnimpostfxStop("ExplosionJosh3")
				end

				MushroomTimer = GetGameTimer()
				Mushroom = 0
			end
		end

		if Methamphetamine > 0 and GetGameTimer() >= MethamphetamineTimer then
			Methamphetamine = Methamphetamine - 1
			MethamphetamineTimer = GetGameTimer() + 1000

			if Methamphetamine <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("Dont_tazeme_bro") then
					AnimpostfxStop("Dont_tazeme_bro")
				end

				MethamphetamineTimer = GetGameTimer()
				Methamphetamine = 0
			end
		end

		if Metadone > 0 and GetGameTimer() >= MetadoneTimer then
			Metadone = Metadone - 1
			MetadoneTimer = GetGameTimer() + 1000

			if Metadone <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("DeathFailMPDark") then
					AnimpostfxStop("DeathFailMPDark")
				end

				Metadone = 0
				MetadoneTimer = GetGameTimer()
				SetAiWeaponDamageModifier(0.5)
				SetAiMeleeWeaponDamageModifier(5.0)
				SetPlayerWeaponDamageModifier(Pid, 1.0)
				SetPlayerMeleeWeaponDamageModifier(Pid, 1.0)
				LocalPlayer["state"]:set("Megazord", false, false)
			end
		end

		if Heroin > 0 and GetGameTimer() >= HeroinTimer then
			Heroin = Heroin - 1
			HeroinTimer = GetGameTimer() + 1000

			if Heroin <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("DrugsMichaelAliensFight") then
					AnimpostfxStop("DrugsMichaelAliensFight")
				end

				if GetEntityHealth(Ped) > 200 then
					SetEntityHealth(Ped,200)
				end

				HeroinTimer = GetGameTimer()
				SetEntityMaxHealth(Ped, 200)
				SetPedMaxHealth(Ped, 200)
				TriggerEvent("Health")
				Heroin = 0
			end
		end

		if Crack > 0 and GetGameTimer() >= CrackTimer then
			Crack = Crack - 1
			CrackTimer = GetGameTimer() + 1000

			if Crack <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("HeistCelebPassBW") then
					AnimpostfxStop("HeistCelebPassBW")
				end

				TriggerEvent("Hunger", 90000)
				TriggerEvent("Thirst", 90000)
				CrackTimer = GetGameTimer()
				Crack = 0
			end
		end

		if Radioative > 0 and GetGameTimer() >= RadioativeTimer then
			Radioative = Radioative - 1
			RadioativeTimer = GetGameTimer() + 1000

			if Radioative <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("HeistCelebPassBW") then
					AnimpostfxStop("HeistCelebPassBW")
				end

				TriggerEvent("Hunger", 90000)
				TriggerEvent("Thirst", 90000)
				RadioativeTimer = GetGameTimer()
				Radioative = 0
			end
		end

		if Joint > 0 and GetGameTimer() >= JointTimer then
			Joint = Joint - 1
			JointTimer = GetGameTimer() + 1000

			if Joint <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("DeathFailMPIn") then
					AnimpostfxStop("DeathFailMPIn")
				end

				if LocalPlayer["state"]["Walk"] then
					LocalPlayer["state"]:set("Walk", false, false)
				end

				SetRunSprintMultiplierForPlayer(Pid, 1.0)
				JointTimer = GetGameTimer()
				Joint = 0
			end
		end

		if Oxycontin > 0 and GetGameTimer() >= OxycontinTimer then
			Oxycontin = Oxycontin - 1
			OxycontinTimer = GetGameTimer() + 1000

			if Oxycontin <= 0 or GetEntityHealth(Ped) <= 100 then
				if AnimpostfxIsRunning("DrugsMichaelAliensFight") then
					AnimpostfxStop("DrugsMichaelAliensFight")
				end

				OxycontinTimer = GetGameTimer()
				Oxycontin = 0
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECOILS
-----------------------------------------------------------------------------------------------------------------------------------------
local Recoils = {
	["WEAPON_PISTOL"] = 0.50,
	["WEAPON_PISTOL_MK2"] = 0.50,
	["WEAPON_COMPACTRIFLE"] = 0.20,
	["WEAPON_APPISTOL"] = 0.35,
	["WEAPON_HEAVYPISTOL"] = 0.50,
	["WEAPON_MACHINEPISTOL"] = 0.35,
	["WEAPON_MICROSMG"] = 0.40,
	["WEAPON_NAILGUN"] = 0.50,
	["WEAPON_MINISMG"] = 0.35,
	["WEAPON_SNSPISTOL"] = 0.50,
	["WEAPON_SNSPISTOL_MK2"] = 0.50,
	["WEAPON_VINTAGEPISTOL"] = 0.50,
	["WEAPON_PISTOL50"] = 1.25,
	["WEAPON_COMBATPISTOL"] = 0.50,
	["WEAPON_PARAFAL"] = 0.30,
	["WEAPON_FNFAL"] = 0.30,
	["WEAPON_COLTXM177"] = 0.20,
	["WEAPON_CARBINERIFLE"] = 0.20,
	["WEAPON_CARBINERIFLE_MK2"] = 0.20,
	["WEAPON_ADVANCEDRIFLE"] = 0.20,
	["WEAPON_BULLPUPRIFLE"] = 0.20,
	["WEAPON_BULLPUPRIFLE_MK2"] = 0.20,
	["WEAPON_SPECIALCARBINE"] = 0.20,
	["WEAPON_SPECIALCARBINE_MK2"] = 0.20,
	["WEAPON_PUMPSHOTGUN"] = 1.50,
	["WEAPON_PUMPSHOTGUN_MK2"] = 1.75,
	["WEAPON_MUSKET"] = 2.25,
	["WEAPON_SAUER"] = 2.25,
	["WEAPON_SAWNOFFSHOTGUN"] = 1.50,
	["WEAPON_SMG"] = 0.35,
	["WEAPON_SMG_MK2"] = 0.35,
	["WEAPON_TACTICALRIFLE"] = 0.20,
	["WEAPON_HEAVYRIFLE"] = 0.20,
	["WEAPON_ASSAULTRIFLE"] = 0.20,
	["WEAPON_ASSAULTRIFLE_MK2"] = 0.25,
	["WEAPON_ASSAULTSMG"] = 0.20,
	["WEAPON_GUSENBERG"] = 0.20
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Weapon", function(Value)
	Weapon = Value
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CEVENTGUNSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("CEventGunShot", function(_, OtherPeds)
	if PlayerPedId() == OtherPeds and not IsPedInAnyHeli(OtherPeds) and Weapon ~= "" and Recoils[Weapon] then
		local Recoil = Recoils[Weapon]
		local Camera = GetGameplayCamRelativePitch()

		if Crack > 0 then
			Recoil = Recoil / 2
		end

		SetGameplayCamRelativePitch(Camera + Recoil, 1.0)

		ShakeGameplayCam("JOLT_SHAKE", 0.075)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRUGSBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DrugsBlips")
AddEventHandler("inventory:DrugsBlips", function(Coords)
	local Blip = AddBlipForCoord(Coords["x"], Coords["y"], Coords["z"])
	SetBlipSprite(Blip, 126)
	SetBlipDisplay(Blip, 4)
	SetBlipHighDetail(Blip, true)
	SetBlipAsShortRange(Blip, true)
	SetBlipColour(Blip, 5)
	SetBlipScale(Blip, 1.0)
	SetBlipFlashes(Blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Traficante Procurado")
	EndTextCommandSetBlipName(Blip)

	SetTimeout(10000, function()
		if DoesBlipExist(Blip) then
			RemoveBlip(Blip)
		end
	end)
end)