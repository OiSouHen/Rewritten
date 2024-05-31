-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Name = nil
local Plate = nil
local Amounts = 1
local Selected = 1
local Active = false
local Vehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]:set("Dismantle", false, true)
LocalPlayer["state"]:set("DismantleModel", "", true)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Peds = {
	"ig_abigail", "a_m_m_afriamer_01", "ig_mp_agent14", "csb_agent", "ig_amandatownley", "s_m_y_ammucity_01", "u_m_y_antonb", "g_m_m_armboss_01", "g_m_m_armgoon_01", "g_m_m_armlieut_01", "ig_ashley", "s_m_m_autoshop_01", "ig_money", "g_m_y_ballaeast_01", "g_f_y_ballas_01", "g_m_y_ballasout_01", "s_m_y_barman_01", "u_m_y_baygor", "a_m_o_beach_01", "ig_bestmen", "a_f_y_bevhills_01", "a_m_m_bevhills_02", "u_m_m_bikehire_01", "u_f_y_bikerchic", "mp_f_boatstaff_01", "s_m_m_bouncer_01", "ig_brad", "ig_bride", "u_m_y_burgerdrug_01", "a_m_m_business_01", "a_m_y_business_02", "s_m_o_busker_01", "ig_car3guy2", "cs_carbuyer", "g_m_m_chiboss_01", "g_m_m_chigoon_01", "g_m_m_chigoon_02", "u_f_y_comjane", "ig_dale", "ig_davenorton", "s_m_y_dealer_01", "ig_denise", "ig_devin", "a_m_y_dhill_01", "ig_dom", "a_m_y_downtown_01", "ig_dreyfuss"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
local Category = {
	[1] = {
		"gt500", "toros", "sheava", "surano", "rapidgt", "feltzer2", "alpha", "gp1",
		"infernus", "bullet", "freecrawler", "turismo2", "zr350",
		"locust", "seven70", "caracara2", "ruffian", "enduro"
	},
	[2] = {
		"specter", "rebla", "ruston", "jester", "banshee", "cypher", "voltic",
		"rt3000", "sc1", "carbonizzare", "infernus2", "imorgon", "sultan2",
		"elegy2", "yosemite2", "ninef", "everon", "double"
	},
	[3] = {
		"jackal", "sugoi", "penumbra", "paragon", "nero", "komoda", "ninef2",
		"futo", "buffalo3", "banshee2", "adder", "schlagen", "bestiagts",
		"jester3", "elegy", "cheetah2", "khamelion", "sanchez", "diablous2"
	},
	[4] = {
		"omnis", "massacro", "euros", "cheetah", "tyrus", "kuruma", "nero2",
		"ardent", "sultan3", "autarch", "fmj", "jester2", "carbonrs", "reever"
	},
	[5] = {
		"gb200", "sultanrs", "pariah", "vacca", "zentorno", "t20", "issi7",
		"penetrator", "emerus", "revolter", "sentinel3", "bati", "bf400",
	},
	[6] = {
		"flashgt", "dominator7", "osiris", "turismor", "jester4",
		"pfister811", "italigtb2", "akuma"
	},
	[7] = {
		"penumbra2", "tempesta", "raiden", "vectre", "entityxf",
		"comet6", "drafter", "bati2"
	},
	[8] = {
		"reaper", "growler", "tigon", "italigtb", "visione",
		"entity2", "deveste", "hakuchou"
	},
	[9] = {
		"vagner", "tyrant", "krieger", "furia", "xa21",
		"neon", "taipan", "jugular", "paragon2", "hakuchou2"
	},
	[10] = {
		"calico", "zorrusso", "italirsx", "coquette4",
		"italigto", "cyclone", "neo", "shinobi", "thrax"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Dismantles = {
	vec4(-625.45, -1657.5, 25.63, 243.78),
	vec4(-820.02, -1273.31, 4.8, 167.25),
	vec4(-819.41, -1199.15, 6.74, 138.9),
	vec4(-1048.27, -864.63, 4.8, 56.7),
	vec4(-699.77, -988.89, 20.2, 300.48),
	vec4(-477.73, -764.71, 40.02, 269.3),
	vec4(-276.35, -771.75, 38.59, 68.04),
	vec4(-323.24, -945.7, 30.89, 249.45),
	vec4(-318.42, -1112.96, 22.76, 340.16),
	vec4(145.06, -1145.18, 29.1, 184.26),
	vec4(240.51, -1413.74, 30.4, 328.82),
	vec4(400.88, -1648.56, 29.1, 320.32),
	vec4(571.65, -1922.32, 24.52, 119.06),
	vec4(1446.51, -2614.0, 48.21, 345.83),
	vec4(1278.73, -1796.5, 43.64, 107.72),
	vec4(803.66, -724.37, 27.57, 133.23),
	vec4(862.91, -1383.57, 25.95, 34.02),
	vec4(156.73, -1451.26, 28.95, 138.9),
	vec4(88.01, -195.89, 54.31, 158.75),
	vec4(62.68, 260.59, 109.22, 68.04),
	vec4(-469.97, 542.25, 120.68, 357.17),
	vec4(-669.89, 752.33, 173.86, 0.0),
	vec4(-1535.05, 890.15, 181.62, 201.26),
	vec4(-3150.55, 1096.16, 20.52, 283.47),
	vec4(-3249.57, 987.82, 12.3, 2.84),
	vec4(-3052.24, 600.0, 7.16, 289.14),
	vec4(-2139.52, -380.26, 13.01, 348.67),
	vec4(-1855.42, -623.86, 10.99, 48.19),
	vec4(-1703.92, -933.34, 7.48, 294.81),
	vec4(-1576.25, -1047.58, 12.82, 73.71),
	vec4(-891.67, -2059.35, 9.12, 42.52),
	vec4(-621.52, -2152.62, 5.8, 5.67),
	vec4(-363.52, -2273.8, 7.41, 14.18),
	vec4(-259.06, -2651.38, 5.81, 314.65),
	vec4(128.47, -2626.56, 5.9, 167.25),
	vec4(781.92, -2957.77, 5.61, 68.04),
	vec4(915.41, -2195.35, 30.14, 172.92),
	vec4(728.43, -2033.73, 29.1, 354.34),
	vec4(1145.1, -475.1, 66.19, 257.96),
	vec4(935.39, -54.52, 78.57, 56.7),
	vec4(615.57, 614.44, 128.72, 68.04),
	vec4(672.45, 245.19, 93.75, 56.7),
	vec4(446.95, 260.66, 103.02, 68.04),
	vec4(90.35, 485.94, 147.49, 206.93),
	vec4(226.83, 680.87, 189.31, 104.89),
	vec4(320.08, 494.93, 152.39, 286.3),
	vec4(505.98, -1843.29, 27.38, 124.73),
	vec4(313.21, -1940.86, 24.45, 48.19),
	vec4(197.28, -2027.34, 18.08, 345.83),
	vec4(154.9, -1881.0, 23.44, 65.2),
	vec4(709.92, -1401.71, 26.17, 286.3)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dismantle:Init")
AddEventHandler("dismantle:Init", function()
	if not Active then
		Experience = vSERVER.Experience("Dismantle")

		Plate = "DISM" .. (1000 + LocalPlayer["state"]["Passport"])

		local Level = ClassCategory(Experience)
		local RandLevels = math.random(Level)
		local Model = math.random(#Category[RandLevels])

		Selected = math.random(#Dismantles)
		Name = Category[RandLevels][Model]
		Active = true
		Amounts = 1

		if Level == 3 or Level == 4 then
			Amounts = 2
		elseif Level == 5 or Level == 6 then
			Amounts = 3
		elseif Level == 7 or Level == 8 then
			Amounts = 4
		elseif Level == 9 or Level == 10 then
			Amounts = 5
		end

		LocalPlayer["state"]:set("Dismantle", true, true)
		LocalPlayer["state"]:set("DismantleModel", Name, true)

		TriggerEvent("NotifyPush", { code = 20, title = "Localização Veículo", x = Dismantles[Selected]["x"], y = Dismantles[Selected]["y"], z = Dismantles[Selected]["z"], vehicle = VehicleName(Name), blipColor = 44 })
		TriggerEvent("Notify", "azul", "Contrato iniciado, espero que você consiga me ajudar com esse serviço, tome muito cuidado.", "Jimmy Jango", 10000)
		exports["target"]:LabelText("Dismantle", "Finalizar")
	else
		TriggerEvent("Notify", "amarelo", "Ainda preciso de seus serviços, então não vou poder finalizar seu contrato por enquanto.", "Jimmy Jango", 10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.DismantleStatus()
	return Active
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:DISMANTLERESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:DismantleReset")
AddEventHandler("target:DismantleReset", function()
	Name = nil
	Amounts = 1
	Selected = 1
	Plate = nil
	Active = false
	Vehicle = false

	exports["target"]:LabelText("Dismantle", "Iniciar")

	LocalPlayer["state"]:set("Dismantle", false, true)
	LocalPlayer["state"]:set("DismantleModel", "", true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Active and not Vehicle then
			local Ped = PlayerPedId()
			if #(GetEntityCoords(Ped) - Dismantles[Selected]["xyz"]) <= 75 then
				Vehicle = vGARAGE.ServerVehicle(Name, Dismantles[Selected][1], Dismantles[Selected][2], Dismantles[Selected][3], Dismantles[Selected][4], Plate, 1000, nil, 1000)

				local OhterNetwork = NetToEnt(Vehicle)
				DecorSetInt(OhterNetwork, "Player_Vehicle", -1)
				SetVehRadioStation(OhterNetwork, "OFF")

				if NetworkDoesNetworkIdExist(Vehicle) then
					local Network = NetToEnt(Vehicle)
					if NetworkDoesNetworkIdExist(Network) then
						SetVehicleOnGroundProperly(Network)
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISMAPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Dismapatch")
AddEventHandler("inventory:Dismapatch", function()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local Heading = GetEntityHeading(Ped)

	for Number = 1, Amounts do
		local Cooldown = 0
		local OtherPeds = math.random(#Peds)
		local SpawnX = Coords["x"] + math.random(-20, 20)
		local SpawnY = Coords["y"] + math.random(-20, 20)
		local HitZ, GroundZ = GetGroundZFor_3dCoord(SpawnX, SpawnY, Coords["z"], true)
		local HitSafe, SafeCoords = GetSafeCoordForPed(SpawnX, SpawnY, GroundZ, false, 16)

		repeat
			Cooldown = Cooldown + 1
			SpawnX = Coords["x"] + math.random(-20, 20)
			SpawnY = Coords["y"] + math.random(-20, 20)
			HitZ, GroundZ = GetGroundZFor_3dCoord(SpawnX, SpawnY, Coords["z"], true)
			HitSafe, SafeCoords = GetSafeCoordForPed(SpawnX, SpawnY, GroundZ, false, 16)
		until (HitZ and HitSafe) or Cooldown >= 100

		if HitZ and HitSafe then
			local Application, Network = vRPS.CreatePed(Peds[OtherPeds], SafeCoords["x"], SafeCoords["y"], SafeCoords["z"], Heading, 28)
			if Application then
				SetTimeout(1000, function()
					local Entity = LoadNetwork(Network)
					if Entity then
						SetPedArmour(Entity, 100)
						SetPedAccuracy(Entity, 75)
						SetPedAlertness(Entity, 3)
						SetPedAsEnemy(Entity, true)
						SetPedMaxHealth(Entity, 500)
						SetEntityHealth(Entity, 500)
						SetPedKeepTask(Entity, true)
						SetPedCombatRange(Entity, 2)
						StopPedSpeaking(Entity, true)
						SetPedCombatMovement(Entity, 2)
						DisablePedPainAudio(Entity, true)
						SetPedPathAvoidFire(Entity, true)
						SetPedConfigFlag(Entity, 208, true)
						SetPedSeeingRange(Entity, 10000.0)
						SetPedCanEvasiveDive(Entity, false)
						SetPedHearingRange(Entity, 10000.0)
						SetPedDiesWhenInjured(Entity, false)
						SetPedPathCanUseLadders(Entity, true)
						SetPedFleeAttributes(Entity, 0, false)
						SetPedCombatAttributes(Entity, 46, true)
						SetPedFiringPattern(Entity, 0xC6EE6B4C)
						SetCanAttackFriendly(Entity, true, false)
						SetPedSuffersCriticalHits(Entity, false)
						SetPedPathCanUseClimbovers(Entity, true)
						SetPedDropsWeaponsWhenDead(Entity, false)
						SetPedEnableWeaponBlocking(Entity, false)
						SetPedPathCanDropFromHeight(Entity, false)
						RegisterHatedTargetsAroundPed(Entity, 100.0)
						GiveWeaponToPed(Entity, "WEAPON_PISTOL_MK2", -1, false, true)
						SetCurrentPedWeapon(Entity, "WEAPON_PISTOL_MK2", true)
						SetPedInfiniteAmmo(Entity, true, "WEAPON_PISTOL_MK2")
						SetPedRelationshipGroupHash(Entity, GetHashKey("HATES_PLAYER"))
						SetEntityCanBeDamagedByRelationshipGroup(Entity, false, "HATES_PLAYER")
						SetRelationshipBetweenGroups(5, GetHashKey("HATES_PLAYER"), GetHashKey("PLAYER"))
						SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("HATES_PLAYER"))
						TaskCombatPed(Entity, Ped, 0, 16)

						SetTimeout(1000, function()
							TaskWanderInArea(Entity, SafeCoords["x"], SafeCoords["y"], SafeCoords["z"], 25.0, 0.0, 0.0)
							SetModelAsNoLongerNeeded(Peds[OtherPeds])
						end)
					end
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISMANTLEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DismantleBlips")
AddEventHandler("inventory:DismantleBlips", function(Coords)
	local Vehicle = AddBlipForCoord(Coords["x"], Coords["y"], Coords["z"])
	SetBlipSprite(Vehicle, 225)
	SetBlipDisplay(Vehicle, 4)
	SetBlipAsShortRange(Vehicle, true)
	SetBlipColour(Vehicle, 5)
	SetBlipScale(Vehicle, 1.0)
	SetBlipFlashes(Vehicle, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo Procurado")
	EndTextCommandSetBlipName(Vehicle)

	SetTimeout(15000, function()
		if DoesBlipExist(Vehicle) then
			RemoveBlip(Vehicle)
		end
	end)
end)
