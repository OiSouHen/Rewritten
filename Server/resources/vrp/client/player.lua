-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYCOORDSZ
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.EntityCoordsZ()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local _, GroundZ = GetGroundZFor_3dCoord(Coords["x"], Coords["y"], Coords["z"])

	return vec3(Coords["x"], Coords["y"], GroundZ)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ModelExist(Hash)
	return IsModelInCdimage(Hash)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.SetHealth(Health)
	local Ped = PlayerPedId()
	SetEntityHealth(Ped, Health)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.UpgradeHealth(Number)
	local Ped = PlayerPedId()
	local Health = GetEntityHealth(Ped)
	if Health > 100 then
		SetEntityHealth(Ped, Health + Number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.DowngradeHealth(Number)
	local Ped = PlayerPedId()
	local Health = GetEntityHealth(Ped)

	SetEntityHealth(Ped, Health - Number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlayingAnim(Dict, Name)
	return IsEntityPlayingAnim(PlayerPedId(), Dict, Name, 3)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Skin(Hash)
	if LoadModel(Hash) then
		LocalPlayer["state"]:set("Charizard", true, false)

		local Pid = PlayerId()
		local Ped = PlayerPedId()

		SetPlayerModel(Pid, Hash)
		SetPedComponentVariation(Ped, 5, 0, 0, 1)
		SetModelAsNoLongerNeeded(Hash)

		if NewHensa then
			tvRP.ReloadCharacter()
		end

		ReloadCharacter(Pid, Ped)

		LocalPlayer["state"]:set("Charizard", false, false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ReloadCharacter()
	exports["skinshop"]:Apply()
	exports["barbershop"]:Apply()
	exports["tattooshop"]:Apply()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active", function(Passport, Name)
	TriggerEvent("hud:Passport", Passport)
	LocalPlayer["state"]:set("Name", Name, false)
	LocalPlayer["state"]:set("Active", true, false)
	LocalPlayer["state"]:set("Blastoise", true, false)
	LocalPlayer["state"]:set("Passport", Passport, false)

	local Pid = PlayerId()
	local Ped = PlayerPedId()

	ReloadCharacter(Pid, Ped)
	SetLocalPlayerAsGhost(true)
	SetEntityInvincible(Ped, true)
	FreezeEntityPosition(Ped, false)
	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(Ped, true, false)
	Entity(Ped)["state"]:set("Passport", Passport, true)

	SetTimeout(10000, function()
		SetLocalPlayerAsGhost(false)
		SetEntityInvincible(Ped, false)
		LocalPlayer["state"]:set("Blastoise", false, false)
	end)

	AddTextEntry("FE_THDR_GTAO", "Hensa Rewritten")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Pid = PlayerId()
		local Ped = PlayerPedId()

		SetPlayerHealthRechargeMultiplier(Pid, 0.0)
		SetPlayerHealthRechargeLimit(Pid, 0.0)

		if GetPlayerMaxArmour(Ped) ~= 100 then
			SetPlayerMaxArmour(Ped, 100)
		end

		if GetPlayerMaxStamina(Pid) ~= 100.0 then
			SetPlayerMaxStamina(Pid, 100.0)
		end

		Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function ReloadCharacter(Pid, Ped)
	StopAudioScenes()
	RemovePickups(Pid)
	SetMaxWantedLevel(0)
	SetRandomBoats(false)
	SetRandomTrains(false)
	DisableIdleCamera(true)
	SetGarbageTrucks(false)
	SetPedHelmet(Ped, false)
	SetDeepOceanScaler(0.0)
	SetPedMaxHealth(Ped, 200)
	SetPlayerTargetingMode(DefaultTargetMode)
	SetRandomEventFlag(false)
	SetPoliceRadarBlips(false)
	DistantCopCarSirens(false)
	SetWeaponsNoAutoswap(true)
	SetEntityMaxHealth(Ped, 200)
	SetAiWeaponDamageModifier(0.5)
	SetAllVehicleGeneratorsActive()
	SetPoliceIgnorePlayer(Ped, true)
	SetArtificialLightsState(false)
	SetPlayerCanUseCover(Pid, false)
	SetPedSteersAroundPeds(Ped, true)
	SetEveryoneIgnorePlayer(Ped, true)
	DisableVehicleDistantlights(true)
	SetAiMeleeWeaponDamageModifier(5.0)
	SetDispatchCopsForPlayer(Ped, false)
	SetFlashLightKeepOnWhileMoving(true)
	SetPedDropsWeaponsWhenDead(Ped, false)
	SetPedCanLosePropsOnDamage(Ped, false, 0)

	SetPedConfigFlag(Ped, 48, true)
	SetPedConfigFlag(Ped, 35, false)
	SetPedConfigFlag(Ped, 438, true)
	SetForceFootstepUpdate(Ped, true)
	SetPedAudioFootstepLoud(Ped, true)
	SetPedAudioFootstepQuiet(Ped, true)

	SetBlipAlpha(GetNorthRadarBlip(), 0)
	ReplaceHudColourWithRgba(116, 65, 130, 226, 255)

	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetAudioFlag("DisableFlightMusic", true)
	SetAudioFlag("PoliceScannerDisabled", true)
	SetScenarioGroupEnabled("Heist_Island_Peds", true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON", false)
	SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE", false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE", false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM", false)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM", false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_construction_01", false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_crowd_background_main", false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_crowd_exterior_lobby", false)
	SetStaticEmitterEnabled("se_dlc_aw_arena_crowd_interior_lobby", false)
	SetStaticEmitterEnabled("se_walk_radio_d_picked", false)
	StartAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
	StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones", true, true)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones", false, true)
	SetWeaponDamageModifier("WEAPON_BAT", 0.25)
	SetWeaponDamageModifier("WEAPON_FROST", 0.25)
	SetWeaponDamageModifier("WEAPON_KATANA", 0.25)
	SetWeaponDamageModifier("WEAPON_HAMMER", 0.25)
	SetWeaponDamageModifier("WEAPON_WRENCH", 0.25)
	SetWeaponDamageModifier("WEAPON_THERMAL", 0.25)
	SetWeaponDamageModifier("WEAPON_UNARMED", 0.25)
	SetWeaponDamageModifier("WEAPON_HATCHET", 0.25)
	SetWeaponDamageModifier("WEAPON_CROWBAR", 0.25)
	SetWeaponDamageModifier("WEAPON_MACHETE", 0.25)
	SetWeaponDamageModifier("WEAPON_POOLCUE", 0.25)
	SetWeaponDamageModifier("WEAPON_KNUCKLE", 0.25)
	SetWeaponDamageModifier("WEAPON_KARAMBIT", 0.25)
	SetWeaponDamageModifier("WEAPON_GOLFCLUB", 0.25)
	SetWeaponDamageModifier("WEAPON_BATTLEAXE", 0.25)
	SetWeaponDamageModifier("WEAPON_SWITCHBLADE", 0.0)
	SetWeaponDamageModifier("WEAPON_FLASHLIGHT", 0.25)
	SetWeaponDamageModifier("WEAPON_NIGHTSTICK", 0.35)
	SetWeaponDamageModifier("WEAPON_SMOKEGRENADE", 0.0)
	SetWeaponDamageModifier("WEAPON_STONE_HATCHET", 0.25)

	for Number = 1,121 do
		EnableDispatchService(Number, false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPICKUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function RemovePickups(Pid)
	local Pickups = {
		`PICKUP_AMMO_BULLET_MP`,
		`PICKUP_AMMO_FIREWORK`,
		`PICKUP_AMMO_FIREWORK_MP`,
		`PICKUP_AMMO_FLAREGUN`,
		`PICKUP_AMMO_GRENADELAUNCHER`,
		`PICKUP_AMMO_GRENADELAUNCHER_MP`,
		`PICKUP_AMMO_HOMINGLAUNCHER`,
		`PICKUP_AMMO_MG`,
		`PICKUP_AMMO_MINIGUN`,
		`PICKUP_AMMO_MISSILE_MP`,
		`PICKUP_AMMO_PISTOL`,
		`PICKUP_AMMO_RIFLE`,
		`PICKUP_AMMO_RPG`,
		`PICKUP_AMMO_SHOTGUN`,
		`PICKUP_AMMO_SMG`,
		`PICKUP_AMMO_SNIPER`,
		`PICKUP_ARMOUR_STANDARD`,
		`PICKUP_CAMERA`,
		`PICKUP_CUSTOM_SCRIPT`,
		`PICKUP_GANG_ATTACK_MONEY`,
		`PICKUP_HEALTH_SNACK`,
		`PICKUP_HEALTH_STANDARD`,
		`PICKUP_MONEY_CASE`,
		`PICKUP_MONEY_DEP_BAG`,
		`PICKUP_MONEY_MED_BAG`,
		`PICKUP_MONEY_PAPER_BAG`,
		`PICKUP_MONEY_PURSE`,
		`PICKUP_MONEY_SECURITY_CASE`,
		`PICKUP_MONEY_VARIABLE`,
		`PICKUP_MONEY_WALLET`,
		`PICKUP_PARACHUTE`,
		`PICKUP_PORTABLE_CRATE_FIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_FIXED_INCAR_SMALL`,
		`PICKUP_PORTABLE_CRATE_FIXED_INCAR_WITH_PASSENGERS`,
		`PICKUP_PORTABLE_CRATE_UNFIXED`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_WITH_PASSENGERS`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW`,
		`PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE`,
		`PICKUP_PORTABLE_PACKAGE`,
		`PICKUP_SUBMARINE`,
		`PICKUP_VEHICLE_ARMOUR_STANDARD`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT_NO_ROTATE`,
		`PICKUP_VEHICLE_HEALTH_STANDARD`,
		`PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW`,
		`PICKUP_VEHICLE_MONEY_VARIABLE`,
		`PICKUP_VEHICLE_WEAPON_APPISTOL`,
		`PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,
		`PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,
		`PICKUP_VEHICLE_WEAPON_GRENADE`,
		`PICKUP_VEHICLE_WEAPON_MICROSMG`,
		`PICKUP_VEHICLE_WEAPON_MOLOTOV`,
		`PICKUP_VEHICLE_WEAPON_PISTOL`,
		`PICKUP_VEHICLE_WEAPON_PISTOL50`,
		`PICKUP_VEHICLE_WEAPON_SAWNOFF`,
		`PICKUP_VEHICLE_WEAPON_SMG`,
		`PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,
		`PICKUP_VEHICLE_WEAPON_STICKYBOMB`,
		`PICKUP_WEAPON_ADVANCEDRIFLE`,
		`PICKUP_WEAPON_APPISTOL`,
		`PICKUP_WEAPON_ASSAULTRIFLE`,
		`PICKUP_WEAPON_ASSAULTRIFLE_MK2`,
		`PICKUP_WEAPON_ASSAULTSHOTGUN`,
		`PICKUP_WEAPON_ASSAULTSMG`,
		`PICKUP_WEAPON_AUTOSHOTGUN`,
		`PICKUP_WEAPON_BAT`,
		`PICKUP_WEAPON_BATTLEAXE`,
		`PICKUP_WEAPON_BOTTLE`,
		`PICKUP_WEAPON_BULLPUPRIFLE`,
		`PICKUP_WEAPON_BULLPUPRIFLE_MK2`,
		`PICKUP_WEAPON_BULLPUPSHOTGUN`,
		`PICKUP_WEAPON_CARBINERIFLE`,
		`PICKUP_WEAPON_CARBINERIFLE_MK2`,
		`PICKUP_WEAPON_COMBATMG`,
		`PICKUP_WEAPON_COMBATMG_MK2`,
		`PICKUP_WEAPON_COMBATPDW`,
		`PICKUP_WEAPON_COMBATPISTOL`,
		`PICKUP_WEAPON_COMPACTLAUNCHER`,
		`PICKUP_WEAPON_COMPACTRIFLE`,
		`PICKUP_WEAPON_CROWBAR`,
		`PICKUP_WEAPON_DAGGER`,
		`PICKUP_WEAPON_DBSHOTGUN`,
		`PICKUP_WEAPON_DOUBLEACTION`,
		`PICKUP_WEAPON_FIREWORK`,
		`PICKUP_WEAPON_FLAREGUN`,
		`PICKUP_WEAPON_FLASHLIGHT`,
		`PICKUP_WEAPON_GOLFCLUB`,
		`PICKUP_WEAPON_GRENADE`,
		`PICKUP_WEAPON_GRENADELAUNCHER`,
		`PICKUP_WEAPON_GUSENBERG`,
		`PICKUP_WEAPON_HAMMER`,
		`PICKUP_WEAPON_HATCHET`,
		`PICKUP_WEAPON_HEAVYPISTOL`,
		`PICKUP_WEAPON_HEAVYSHOTGUN`,
		`PICKUP_WEAPON_HEAVYSNIPER`,
		`PICKUP_WEAPON_HEAVYSNIPER_MK2`,
		`PICKUP_WEAPON_HOMINGLAUNCHER`,
		`PICKUP_WEAPON_KNIFE`,
		`PICKUP_WEAPON_KNUCKLE`,
		`PICKUP_WEAPON_MACHETE`,
		`PICKUP_WEAPON_MACHINEPISTOL`,
		`PICKUP_WEAPON_MARKSMANPISTOL`,
		`PICKUP_WEAPON_MARKSMANRIFLE`,
		`PICKUP_WEAPON_MARKSMANRIFLE_MK2`,
		`PICKUP_WEAPON_MG`,
		`PICKUP_WEAPON_MICROSMG`,
		`PICKUP_WEAPON_MINIGUN`,
		`PICKUP_WEAPON_MINISMG`,
		`PICKUP_WEAPON_MOLOTOV`,
		`PICKUP_WEAPON_MUSKET`,
		`PICKUP_WEAPON_NIGHTSTICK`,
		`PICKUP_WEAPON_PETROLCAN`,
		`PICKUP_WEAPON_PIPEBOMB`,
		`PICKUP_WEAPON_PISTOL`,
		`PICKUP_WEAPON_PISTOL_MK2`,
		`PICKUP_WEAPON_PISTOL50`,
		`PICKUP_WEAPON_POOLCUE`,
		`PICKUP_WEAPON_PROXMINE`,
		`PICKUP_WEAPON_PUMPSHOTGUN`,
		`PICKUP_WEAPON_PUMPSHOTGUN_MK2`,
		`PICKUP_WEAPON_RAILGUN`,
		`PICKUP_WEAPON_REVOLVER`,
		`PICKUP_WEAPON_REVOLVER_MK2`,
		`PICKUP_WEAPON_RPG`,
		`PICKUP_WEAPON_SAWNOFFSHOTGUN`,
		`PICKUP_WEAPON_SMG`,
		`PICKUP_WEAPON_SMG_MK2`,
		`PICKUP_WEAPON_SMOKEGRENADE`,
		`PICKUP_WEAPON_SNIPERRIFLE`,
		`PICKUP_WEAPON_SNSPISTOL`,
		`PICKUP_WEAPON_SNSPISTOL_MK2`,
		`PICKUP_WEAPON_SPECIALCARBINE`,
		`PICKUP_WEAPON_SPECIALCARBINE_MK2`,
		`PICKUP_WEAPON_STICKYBOMB`,
		`PICKUP_WEAPON_STONE_HATCHET`,
		`PICKUP_WEAPON_STUNGUN`,
		`PICKUP_WEAPON_SWITCHBLADE`,
		`PICKUP_WEAPON_PENCIL`,
		`PICKUP_WEAPON_VINTAGEPISTOL`,
		`PICKUP_WEAPON_WRENCH`,
		`PICKUP_WEAPON_RAYCARBINE`
	}

	for Number = 1, #Pickups do
		ToggleUsePickupsForPlayer(Pid, Pickups[Number], false)
	end
end