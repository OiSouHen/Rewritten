-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("inventory",Hensa)
vGARAGE = Tunnel.getInterface("garages")
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {}
local Types = ""
local Weapon = ""
local Usables = 1
local Actived = false
local Listening = false
local Inventory = false
local TakeWeapon = false
local StoreWeapon = false
local Reloaded = GetGameTimer()
local ShotDelay = GetGameTimer()
local UseCooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Weapons",function()
	return Weapon
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel",function()
	vSERVER.Cancel()

	if InCamera then
		TriggerEvent("inventory:ServiceCameras")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:OBJECTSVERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:ObjectsVerify")
AddEventHandler("inventory:ObjectsVerify",function(Entity,Service)
	vSERVER.VerifyObjects(Entity,Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:StealTrunk")
AddEventHandler("inventory:StealTrunk",function(Entity)
	local DriverPed = GetPedInVehicleSeat(Entity[3], -1)
    if DriverPed ~= 0 and not IsPedAPlayer(DriverPed) then
		TriggerEvent("Notify", "amarelo", "Você não pode arrombar o porta malas com pessas dentro do veículo.", "Atenção", 5000)
		return
	end

	vSERVER.StealTrunk(Entity)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Animals")
AddEventHandler("inventory:Animals",function(Entity)
	vSERVER.Animals(Entity)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STOREOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:StoreObjects")
AddEventHandler("inventory:StoreObjects",function(Number)
	vSERVER.StoreObjects(Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:GENERATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:GenerateObjects")
AddEventHandler("inventory:GenerateObjects",function(Number)
	vSERVER.GenerateObjects(Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:MakeProducts")
AddEventHandler("inventory:MakeProducts",function(Service)
	vSERVER.MakeProducts(Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:MAKEPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:MakePackage")
AddEventHandler("inventory:MakePackage",function(Service)
	vSERVER.MakePackage(Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DELIVERPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DeliverPackage")
AddEventHandler("inventory:DeliverPackage",function(Service)
	vSERVER.DeliverPackage(Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Dismantle")
AddEventHandler("inventory:Dismantle",function(Entity)
	vSERVER.Dismantle(Entity)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RemoveTyres")
AddEventHandler("inventory:RemoveTyres",function(Entity)
	vSERVER.RemoveTyres(Entity)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CleanWeapons")
AddEventHandler("inventory:CleanWeapons",function(Create)
	if Weapon ~= "" then
		if Create and Usables <= 5 then
			TriggerEvent("inventory:CreateWeapon", Weapon)
		end

		RemoveAllPedWeapons(PlayerPedId(), true)
	end

	TriggerEvent("hud:Weapon", false)
	TriggerEvent("Weapon", "")
	Actived = false
	Weapon = ""
	Types = ""
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if LocalPlayer["state"]["Buttons"] then
			TimeDistance = 1

			DisableControlAction(0,75, true)
			DisableControlAction(0,47, true)
			DisableControlAction(0,257, true)
			DisablePlayerFiring(Ped, true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THROWABLEWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:throwableWeapons")
AddEventHandler("inventory:throwableWeapons",function(weaponName)
	currentWeapon = weaponName

	local Ped = PlayerPedId()
	if GetSelectedPedWeapon(Ped) == GetHashKey(currentWeapon) then
		while GetSelectedPedWeapon(Ped) == GetHashKey(currentWeapon) do
			if IsPedShooting(Ped) then
				vSERVER.RemoveThrowing(currentWeapon)
			end

			Wait(0)
		end

		currentWeapon = ""
	else
		Hensa.StoreWeapon()
		currentWeapon = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Inventory then
		Inventory = false
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "Close" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	TriggerEvent("inventory:Close")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:USE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Use")
AddEventHandler("inventory:Use",function(Slot,Amount)
	Usables = parseInt(Slot)
	vSERVER.Use(Usables, Amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Use",function(Data,Callback)
	if GetGameTimer() >= UseCooldown then
		TriggerEvent("inventory:Use",Data["slot"],Data["amount"])
		UseCooldown = GetGameTimer() + 1000
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Send",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Send(Data["slot"],Data["amount"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Destroy",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Destroy(Data["slot"],Data["amount"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	vRPS.UpdateInventory(Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update",function(Action)
	SendNUIMessage({ action = Action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyWeapon")
AddEventHandler("inventory:verifyWeapon", function(Item)
	local Split = splitString(Item, "-")
	local Name = Split[1]

	if Weapon == Name then
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped, Weapon)
		if not vSERVER.VerifyWeapon(Weapon, Ammo) then
			TriggerEvent("inventory:CleanWeapons", false)
		end
	else
		if Weapon == "" then
			vSERVER.VerifyWeapon(Name)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:preventWeapon")
AddEventHandler("inventory:preventWeapon", function()
	if Weapon ~= "" then
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped, Weapon)

		TriggerEvent("inventory:CreateWeapon", Weapon)
		vSERVER.PreventWeapons(Weapon, Ammo)
		TriggerEvent("hud:Weapon", false)
		RemoveAllPedWeapons(Ped, true)
		TriggerEvent("Weapon", "")

		Actived = false
		Weapon = ""
		Types = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Inventory",function()
	if not IsPauseMenuActive() and GetEntityHealth(PlayerPedId()) > 100 and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPlayerFreeAiming(PlayerId()) and not LocalPlayer["state"]["Bennys"] then
		Inventory = true
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "Open" })
		TriggerEvent("sounds:Private","chest",0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Inventory","Abrir/Fechar a mochila.","keyboard","OEM_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:paintVehicle")
AddEventHandler("inventory:paintVehicle", function(Index, Plate, Color)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleColours(Vehicle, Color, Color)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairVehicle")
AddEventHandler("inventory:repairVehicle", function(Index, Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				local Tyres = {}

				for i = 0, 7 do
					local Status = false

					if GetTyreHealth(Vehicle, i) ~= 1000.0 then
						Status = true
					end

					Tyres[i] = Status
				end

				local Fuel = GetVehicleFuelLevel(Vehicle)

				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)

				SetVehicleFuelLevel(Vehicle, Fuel)

				for Tyre, Burst in pairs(Tyres) do
					if Burst then
						SetVehicleTyreBurst(Vehicle, Tyre, true, 1000.0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRTYRE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairTyre")
AddEventHandler("inventory:repairTyre", function(Vehicle, Tyres, Plate)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				for i = 0, 7 do
					if GetTyreHealth(Vehicle, i) ~= 1000.0 then
						SetVehicleTyreBurst(Vehicle, i, true, 1000.0)
					end
				end

				SetVehicleTyreFixed(Vehicle, Tyres)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairPlayer")
AddEventHandler("inventory:repairPlayer", function(Index, Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleEngineHealth(Vehicle, 1000.0)
				SetVehicleBodyHealth(Vehicle, 1000.0)
				SetEntityHealth(Vehicle, 1000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairAdmin")
AddEventHandler("inventory:repairAdmin", function(Index, Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				local Fuel = GetVehicleFuelLevel(Vehicle)

				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)

				SetVehicleFuelLevel(Vehicle, Fuel)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEALARM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:vehicleAlarm")
AddEventHandler("inventory:vehicleAlarm", function(Index, Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleAlarm(Vehicle, true)
				StartVehicleAlarm(Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Parachute()
	local Ped = PlayerPedId()
	GiveWeaponToPed(Ped, "GADGET_PARACHUTE", 1, false, true)
	SetPedParachuteTintIndex(Ped, math.random(7))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHING
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Fishing()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local Fishings = {
		vec3(-315.33, 6588.65, -0.47)
	}

	for i = 1, #Fishings do
		if #(Coords - Fishings[i]) <= 30 and IsEntityInWater(Ped) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.AnimalAnim()
	local Ped = PlayerPedId()
	if IsEntityPlayingAnim(Ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 3) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ReturnWeapon()
	return Weapon ~= "" and Weapon or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckWeapon(Hash)
	return Weapon == Hash and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
local Attachs = {
	["ATTACH_FLASHLIGHT"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_03",
		["WEAPON_PISTOL50"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_HEAVYRIFLE"] = "COMPONENT_AT_AR_FLSH"
	},
	["ATTACH_CROSSHAIR"] = {
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_RAIL",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_RAIL_02",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_SCOPE_SMALL",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MACRO_02_MK2",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SCOPE_SMALL_MK2",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_HEAVYRIFLE"] = "COMPONENT_AT_SCOPE_MEDIUM"
	},
	["ATTACH_MAGAZINE"] = {
		["WEAPON_PISTOL"] = "COMPONENT_PISTOL_CLIP_02",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_PISTOL_MK2_CLIP_02",
		["WEAPON_COMPACTRIFLE"] = "COMPONENT_COMPACTRIFLE_CLIP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_APPISTOL_CLIP_02",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_MACHINEPISTOL_CLIP_02",
		["WEAPON_MICROSMG"] = "COMPONENT_MICROSMG_CLIP_02",
		["WEAPON_MINISMG"] = "COMPONENT_MINISMG_CLIP_02",
		["WEAPON_SNSPISTOL"] = "COMPONENT_SNSPISTOL_CLIP_02",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_SNSPISTOL_MK2_CLIP_02",
		["WEAPON_VINTAGEPISTOL"] = "COMPONENT_VINTAGEPISTOL_CLIP_02",
		["WEAPON_PISTOL50"] = "COMPONENT_PISTOL50_CLIP_02",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
		["WEAPON_ADVANCEDRIFLE"] = "COMPONENT_ADVANCEDRIFLE_CLIP_02",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_BULLPUPRIFLE_CLIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_SPECIALCARBINE_CLIP_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_SMG_MK2_CLIP_02",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_ASSAULTRIFLE_CLIP_02",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_ASSAULTSMG_CLIP_02",
		["WEAPON_GUSENBERG"] = "COMPONENT_GUSENBERG_CLIP_02",
		["WEAPON_HEAVYRIFLE"] = "COMPONENT_HEAVYRIFLE_CLIP_02"
	},
	["ATTACH_SILENCER"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SR_SUPP_03",
		["WEAPON_COLTXM177"] = "COMPONENT_COLTXM177_SUPP",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_HEAVYRIFLE"] = "COMPONENT_AT_AR_SUPP"
	},
	["ATTACH_GRIP"] = {
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_MUZZLE_08",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02",
		["WEAPON_HEAVYRIFLE"] = "COMPONENT_AT_AR_AFGRIP"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckAttachs(Name,Hash)
	return Attachs[Name] and Attachs[Name][Hash]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXISTATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ExistAttachs(Weapon)
	local Return = false

	for Name,v in pairs(Attachs) do
		if Attachs[Name] and Attachs[Name][Weapon] then
			Return = true
			break
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Attachs(Name,Hash)
	GiveWeaponComponentToPed(PlayerPedId(),Hash,Attachs[Name][Hash])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.TakeWeapon(Name, Ammo, Components, Type)
	if not TakeWeapon then
		if not Ammo then
			Ammo = 0
		end

		if Ammo > 0 then
			Actived = true
		end

		TakeWeapon = true
		LocalPlayer["state"]:set("Cancel",true,true)

		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			if LoadAnim("reaction@intimidation@1h") then
				TaskPlayAnim(Ped,"reaction@intimidation@1h","intro",8.0,8.0,-1,48,1,0,0,0)
			end

			Wait(1250)

			Weapon = Name
			TriggerEvent("Weapon",Name)
			TriggerEvent("inventory:RemoveWeapon",Name)
			GiveWeaponToPed(Ped,Name,Ammo,false,true)

			Wait(1000)

			ClearPedTasks(Ped)
		else
			Weapon = Name
			TriggerEvent("Weapon",Name)
			TriggerEvent("inventory:RemoveWeapon",Name)
			GiveWeaponToPed(Ped,Name,Ammo,false,true)
		end

		if Components then
			for nameItem,_ in pairs(Components) do
				Hensa.Attachs(nameItem,Name)
			end
		end

		if Type then
			Types = Type
		end

		TakeWeapon = false
		LocalPlayer["state"]:set("Cancel",false,true)

		if itemAmmo(Name) then
			TriggerEvent("hud:Weapon",true,Name)
		end

		if vSERVER.CheckExistWeapons(Name) or LocalPlayer["state"]["Safezone"] then
			TriggerEvent("inventory:CleanWeapons",true)
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.StoreWeapon()
	if not StoreWeapon then
		StoreWeapon = true

		local Last = Weapon
		local Ped = PlayerPedId()
		LocalPlayer["state"]:set("Cancel",true,true)

		if not IsPedInAnyVehicle(Ped) then
			if LoadAnim("reaction@intimidation@1h") then
				TaskPlayAnim(Ped,"reaction@intimidation@1h","outro",8.0,8.0,-1,48,1,0,0,0)
			end

			Wait(1600)

			ClearPedTasks(Ped)
		end

		local Ammos = GetAmmoInPedWeapon(Ped,Weapon)

		StoreWeapon = false
		TriggerEvent("inventory:CleanWeapons",true)
		LocalPlayer["state"]:set("Cancel",false,true)

		return true,Ammos,Last
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFOWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.InfoWeapon(Type)
	local Ammo = 0
	local Hash = nil
	local Status = false

	local Ammos = {
		["WEAPON_PISTOL_AMMO"] = {
			"WEAPON_PISTOL_MK2",
			"WEAPON_PISTOL50",
			"WEAPON_SNSPISTOL",
			"WEAPON_SNSPISTOL_MK2",
			"WEAPON_VINTAGEPISTOL"
		},
		["WEAPON_NAIL_AMMO"] = {
			"WEAPON_NAILGUN"
		},
		["WEAPON_RPG_AMMO"] = {
			"WEAPON_RPG"
		},
		["WEAPON_SMG_AMMO"] = {
			"WEAPON_MICROSMG",
			"WEAPON_MINISMG",
			"WEAPON_APPISTOL",
			"WEAPON_SMG_MK2",
			"WEAPON_GUSENBERG",
			"WEAPON_MACHINEPISTOL"
		},
		["WEAPON_RIFLE_AMMO"] = {
			"WEAPON_FNSCAR",
			"WEAPON_FNFAL",
			"WEAPON_QBZ83",
			"WEAPON_PARAFAL",
			"WEAPON_COLTXM177",
			"WEAPON_COMPACTRIFLE",
			"WEAPON_CARBINERIFLE_MK2",
			"WEAPON_BULLPUPRIFLE",
			"WEAPON_BULLPUPRIFLE_MK2",
			"WEAPON_ADVANCEDRIFLE",
			"WEAPON_ASSAULTRIFLE",
			"WEAPON_HEAVYRIFLE",
			"WEAPON_ASSAULTSMG",
			"WEAPON_ASSAULTRIFLE_MK2",
			"WEAPON_SPECIALCARBINE",
			"WEAPON_SPECIALCARBINE_MK2"
		},
		["WEAPON_SHOTGUN_AMMO"] = {
			"WEAPON_PUMPSHOTGUN_MK2",
			"WEAPON_SAWNOFFSHOTGUN"
		},
		["WEAPON_POLICE_AMMO"] = {
			"WEAPON_SMG",
			"WEAPON_PISTOL",
			"WEAPON_PUMPSHOTGUN",
			"WEAPON_CARBINERIFLE",
			"WEAPON_TACTICALRIFLE",
			"WEAPON_COMBATPISTOL",
			"WEAPON_HEAVYPISTOL"
		},
		["WEAPON_MUSKET_AMMO"] = {
			"WEAPON_MUSKET",
			"WEAPON_SAUER"
		},
		["WEAPON_PETROLCAN_AMMO"] = {
			"WEAPON_PETROLCAN"
		},
		["WEAPON_FIREEXTINGUISHER_AMMO"] = {
			"WEAPON_FIREEXTINGUISHER"
		}
	}

	if Ammos[Type] then
		local Ped = PlayerPedId()
		Ammo = GetAmmoInPedWeapon(Ped,Weapon)

		for _,v in pairs(Ammos[Type]) do
			if Weapon == v then
				Status = true
				Hash = Weapon
				break
			end
		end
	end

	return Status,Ammo,Hash
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADING
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Reloading(Hash,Ammo)
	AddAmmoToPed(PlayerPedId(),Hash,Ammo)
	Actived = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Actived and Weapon ~= "" then
			TimeDistance = 10

			local Ped = PlayerPedId()
			local Ammo = GetAmmoInPedWeapon(Ped,Weapon)

			if GetGameTimer() >= Reloaded and IsPedReloading(Ped) then
				vSERVER.PreventWeapons(Weapon,Ammo)
				Reloaded = GetGameTimer() + 100
			end

			if Ammo <= 0 or (Weapon == "WEAPON_PETROLCAN" and Ammo <= 135 and IsPedShooting(Ped)) or IsPedSwimming(Ped) then
				if Types ~= "" then
					vSERVER.RemoveThrowing(Types)
				else
					vSERVER.PreventWeapons(Weapon,Ammo)
				end

				TriggerEvent("inventory:CleanWeapons",true)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLANDESTINE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Clandestine()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local Clandestines = vec3(-471.87,6287.56,13.63)

	if #(Coords - Clandestines) <= 5 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKFOUNTAIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckFountain()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	if DoesObjectOfTypeExistAtCoords(Coords, 0.7, GetHashKey("prop_watercooler"), true) or DoesObjectOfTypeExistAtCoords(Coords, 0.7, GetHashKey("prop_watercooler_dark"), true) then
		return true, "fountain"
	end

	if IsEntityInWater(Ped) then
		return true, "floor"
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADRELOCATES
-----------------------------------------------------------------------------------------------------------------------------------------
local AdreLocates = {
	{ -471.94,6287.48,14.63,4 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADREDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.AdreDistance()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	for k, v in pairs(AdreLocates) do
		local Distance = #(Coords - vec3(v[1], v[2], v[3]))
		if Distance <= v[4] then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
local Firecracker = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.checkCracker()
	return GetGameTimer() <= Firecracker and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Firecracker")
AddEventHandler("inventory:Firecracker", function()
	if LoadPtfxAsset("scr_indep_fireworks") then
		Firecracker = GetGameTimer() + (5 * 60000)

		local Explosive = 25
		local Ped = PlayerPedId()
		local Coords = GetOffsetFromEntityInWorldCoords(Ped, 0.0, 0.6, 0.0)
		local Progression, Network = vRPS.CreateObject("ind_prop_firework_03", Coords["x"], Coords["y"], Coords["z"])
		if Progression then
			local Entity = LoadNetwork(Network)
			if Entity then
				FreezeEntityPosition(Entity, true)
				PlaceObjectOnGroundProperly(Entity)
				SetModelAsNoLongerNeeded("ind_prop_firework_03")
			end

			Wait(8000)

			repeat
				Wait(2000)
				Explosive = Explosive - 1
				UseParticleFxAssetNextCall("scr_indep_fireworks")
				StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", Coords["x"], Coords["y"], Coords["z"], 0.0, 0.0, 0.0, 2.5, false, false, false, false)
			until Explosive <= 0

			TriggerServerEvent("DeleteObject", Network)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WATER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Water()
	return IsEntityInWater(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Drops")
AddEventHandler("inventory:Drops",function(Table)
	Drops = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPSREMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DropsRemover")
AddEventHandler("inventory:DropsRemover",function(Route,Number)
	if Drops[Route] and Drops[Route][Number] then
		Drops[Route][Number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPSATUALIZAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DropsAtualizar")
AddEventHandler("inventory:DropsAtualizar",function(Route,Number,Amount)
	if Drops[Route] and Drops[Route][Number] then
		Drops[Route][Number]["Amount"] = Amount
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPSADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DropsAdicionar")
AddEventHandler("inventory:DropsAdicionar",function(Route,Number,Table)
	if not Drops[Route] then
		Drops[Route] = {}
	end

	Drops[Route][Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Drops",function(Data,Callback)
	if not TakeWeapon and not StoreWeapon and MumbleIsConnected() then
		vSERVER.Drops(Data["item"],Data["slot"],Data["amount"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local Route = LocalPlayer["state"]["Route"]
		if not IsPedInAnyVehicle(Ped) and Drops[Route] then
			local Coords = GetEntityCoords(Ped)

			for _,v in pairs(Drops[Route]) do
				if #(Coords - v["Coords"]) <= 50 then
					TimeDistance = 1

					DrawMarker(20,v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"] + 0.5,0.0,0.0,0.0,0.0,180.0,0.0,0.35,0.35,0.35,65,130,226,100,0,0,0,1)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Inventory",function(Data,Callback)
	local Inventory,Weight,MaxWeight = vSERVER.Inventory()
	if Inventory then
		local DropList = {}
		local Ped = PlayerPedId()
		local Route = LocalPlayer["state"]["Route"]

		if not IsPedInAnyVehicle(Ped) and Drops[Route] then
			local Coords = GetEntityCoords(Ped)
			local _,GroundZ = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])

			for Index,v in pairs(Drops[Route]) do
				if #(vec3(Coords["x"],Coords["y"],GroundZ) - v["Coords"]) <= 0.9 then
					DropList[#DropList + 1] = v
				end
			end
		end

		Callback({ Inventory = Inventory, Drops = DropList, Weight = Weight, MaxWeight = MaxWeight })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Pickup",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Pickup(Data["id"],Data["route"],Data["target"],Data["amount"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:EXPLODETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:explodeTyres")
AddEventHandler("inventory:explodeTyres", function(Network, Plate, Tyre)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleTyreBurst(Vehicle, Tyre, true, 1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local TyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.tyreStatus()
	local Ped = PlayerPedId()
	if not IsPedInAnyVehicle(Ped) then
		local Vehicle = vRP.ClosestVehicle(7)
		if IsEntityAVehicle(Vehicle) then
			local Coords = GetEntityCoords(Ped)

			for Index, Tyre in pairs(TyreList) do
				local Selected = GetEntityBoneIndexByName(Vehicle, Index)
				if Selected ~= -1 then
					local CoordsWheel = GetWorldPositionOfEntityBone(Vehicle, Selected)
					if #(Coords - CoordsWheel) <= 1.0 and GetTyreHealth(Vehicle, Tyre) ~= 1000.0 then
						return Vehicle, Tyre, VehToNet(Vehicle), GetVehicleNumberPlateText(Vehicle)
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.tyreHealth(Network,Tyre)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			return GetTyreHealth(Vehicle,Tyre)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ObjectExists(Coords,Hash)
	return DoesObjectOfTypeExistAtCoords(Coords["x"],Coords["y"],Coords["z"],0.35,Hash,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTERIOR
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckInterior()
	local Ped = PlayerPedId()
	return GetInteriorFromEntity(Ped) ~= 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:LISTEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Listen")
AddEventHandler("inventory:Listen", function(Number)
	if Listening then
		TriggerEvent("Notify", "amarelo", "Saiu da frequência <b>" .. Number .. "</b>.", "Atenção", 5000)
		TriggerEvent("sounds:Private", "radiooff", 1.0)
		exports["pma-voice"]:removePlayerFromRadio()
		TriggerEvent("hud:Radio", "Offline")
		TriggerEvent("radio:RadioClean")
		Listening = false
	else
		TriggerEvent("Notify", "verde", "Entrou na frequência <b>" .. Number .. "</b>.", "Sucesso", 5000)
		TriggerEvent("sounds:Private", "radioon", 0.5)
		exports["pma-voice"]:setRadioChannel(Number)
		TriggerEvent("hud:Radio", Number)
		Listening = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATM
-----------------------------------------------------------------------------------------------------------------------------------------
local Atm = {
	["1"] = vec3(121.17, -3019.62, 7.04),
	["2"] = vec3(797.69, -767.52, 26.77),
	["3"] = vec3(961.42, 41.48, 71.7),
	["4"] = vec3(168.55, 6636.81, 31.69),
	["5"] = vec3(-32.08, -1104.32, 27.26),
	["6"] = vec3(228.18, 338.4, 105.56),
	["7"] = vec3(158.63, 234.22, 106.63),
	["8"] = vec3(-57.67, -92.62, 57.78),
	["9"] = vec3(356.97, 173.54, 103.07),
	["10"] = vec3(-1415.94, -212.03, 46.51),
	["11"] = vec3(-1430.2, -211.08, 46.51),
	["12"] = vec3(-1282.54, -210.9, 42.44),
	["13"] = vec3(-1286.25, -213.44, 42.44),
	["14"] = vec3(-1289.32, -226.82, 42.44),
	["15"] = vec3(-1285.58, -224.28, 42.44),
	["16"] = vec3(-1109.8, -1690.82, 4.36),
	["17"] = vec3(1686.85, 4815.82, 42.01),
	["18"] = vec3(1701.21, 6426.57, 32.76),
	["19"] = vec3(1171.56, 2702.58, 38.16),
	["20"] = vec3(1172.5, 2702.59, 38.16),
	["21"] = vec3(-1091.49, 2708.66, 18.96),
	["22"] = vec3(-3144.38, 1127.6, 20.86),
	["23"] = vec3(527.36, -160.69, 57.09),
	["24"] = vec3(285.45, 143.39, 104.17),
	["25"] = vec3(-846.27, -341.28, 38.67),
	["26"] = vec3(-846.85, -340.2, 38.67),
	["27"] = vec3(-721.06, -415.56, 34.98),
	["28"] = vec3(-1410.34, -98.75, 52.42),
	["29"] = vec3(-1409.78, -100.49, 52.39),
	["30"] = vec3(-712.9, -818.92, 23.72),
	["31"] = vec3(-710.05, -818.9, 23.72),
	["32"] = vec3(-660.71, -854.07, 24.48),
	["33"] = vec3(-594.58, -1161.29, 22.33),
	["34"] = vec3(-596.09, -1161.28, 22.33),
	["35"] = vec3(-821.64, -1081.91, 11.12),
	["36"] = vec3(155.93, 6642.86, 31.59),
	["37"] = vec3(174.14, 6637.94, 31.58),
	["38"] = vec3(-283.01, 6226.11, 31.49),
	["39"] = vec3(-95.55, 6457.19, 31.46),
	["40"] = vec3(-97.3, 6455.48, 31.46),
	["41"] = vec3(-132.93, 6366.52, 31.48),
	["42"] = vec3(-386.74, 6046.08, 31.49),
	["43"] = vec3(24.47, -945.96, 29.35),
	["44"] = vec3(5.24, -919.83, 29.55),
	["45"] = vec3(295.77, -896.1, 29.22),
	["46"] = vec3(296.47, -894.21, 29.23),
	["47"] = vec3(1138.22, -468.93, 66.73),
	["48"] = vec3(1166.97, -456.06, 66.79),
	["49"] = vec3(1077.75, -776.54, 58.23),
	["50"] = vec3(289.1, -1256.8, 29.44),
	["51"] = vec3(288.81, -1282.37, 29.64),
	["52"] = vec3(-1571.05, -547.38, 34.95),
	["53"] = vec3(-1570.12, -546.72, 34.95),
	["54"] = vec3(-1305.4, -706.41, 25.33),
	["55"] = vec3(-2072.36, -317.28, 13.31),
	["56"] = vec3(-2295.48, 358.13, 174.6),
	["57"] = vec3(-2294.7, 356.46, 174.6),
	["58"] = vec3(-2293.92, 354.8, 174.6),
	["59"] = vec3(2558.75, 351.01, 108.61),
	["60"] = vec3(89.69, 2.47, 68.29),
	["61"] = vec3(-866.69, -187.75, 37.84),
	["62"] = vec3(-867.62, -186.09, 37.84),
	["63"] = vec3(-618.22, -708.89, 30.04),
	["64"] = vec3(-618.23, -706.89, 30.04),
	["65"] = vec3(-614.58, -704.83, 31.24),
	["66"] = vec3(-611.93, -704.83, 31.24),
	["67"] = vec3(-537.82, -854.49, 29.28),
	["68"] = vec3(-526.62, -1222.98, 18.45),
	["69"] = vec3(-165.15, 232.7, 94.91),
	["70"] = vec3(-165.17, 234.78, 94.91),
	["71"] = vec3(-303.25, -829.74, 32.42),
	["72"] = vec3(-301.7, -830.01, 32.42),
	["73"] = vec3(-203.81, -861.37, 30.26),
	["74"] = vec3(119.06, -883.72, 31.12),
	["75"] = vec3(112.58, -819.4, 31.34),
	["76"] = vec3(111.26, -775.25, 31.44),
	["77"] = vec3(114.43, -776.38, 31.41),
	["78"] = vec3(-256.23, -715.99, 33.53),
	["79"] = vec3(-258.87, -723.38, 33.48),
	["80"] = vec3(-254.42, -692.49, 33.6),
	["81"] = vec3(-28.0, -724.52, 44.23),
	["82"] = vec3(-30.23, -723.69, 44.23),
	["83"] = vec3(-1315.75, -834.69, 16.95),
	["84"] = vec3(-1314.81, -835.96, 16.95),
	["85"] = vec3(-2956.86, 487.64, 15.47),
	["86"] = vec3(-2958.98, 487.73, 15.47),
	["87"] = vec3(-3043.97, 592.42, 7.9),
	["88"] = vec3(-3241.17, 997.6, 12.55),
	["89"] = vec3(-1205.78, -324.79, 37.86),
	["90"] = vec3(-1205.02, -326.3, 37.84),
	["91"] = vec3(147.58, -1035.77, 29.34),
	["92"] = vec3(146.0, -1035.17, 29.34),
	["93"] = vec3(33.55, -1345.0, 29.49),
	["94"] = vec3(2555.28, 389.99, 108.61),
	["95"] = vec3(1153.65, -326.78, 69.2),
	["96"] = vec3(-717.71, -915.66, 19.21),
	["97"] = vec3(-56.98, -1752.09, 29.42),
	["98"] = vec3(381.93, 326.43, 103.56),
	["99"] = vec3(-3243.78, 1009.24, 12.82),
	["100"] = vec3(1737.02, 6413.25, 35.03),
	["101"] = vec3(540.4, 2667.86, 42.16),
	["102"] = vec3(1966.81, 3746.52, 32.33),
	["103"] = vec3(2680.45, 3288.48, 55.23),
	["104"] = vec3(1703.0, 4933.6, 42.06),
	["105"] = vec3(-1827.3, 784.88, 138.3),
	["106"] = vec3(-3043.91, 592.48, 7.9),
	["107"] = vec3(238.61, 212.44, 106.27),
	["108"] = vec3(239.06, 213.67, 106.27),
	["109"] = vec3(239.5, 214.88, 106.27),
	["110"] = vec3(239.94, 216.15, 106.27),
	["111"] = vec3(241.01, 219.02, 106.27),
	["112"] = vec3(241.43, 220.24, 106.27),
	["113"] = vec3(241.89, 221.49, 106.27),
	["114"] = vec3(242.35, 222.7, 106.27),
	["115"] = vec3(264.02, 203.62, 106.27),
	["116"] = vec3(264.48, 204.89, 106.27),
	["117"] = vec3(264.94, 206.14, 106.27),
	["118"] = vec3(265.38, 207.34, 106.27),
	["119"] = vec3(126.82, -1296.6, 29.27),
	["120"] = vec3(127.81, -1296.03, 29.27),
	["121"] = vec3(-248.04, 6327.51, 32.42),
	["122"] = vec3(315.09, -593.68, 43.29),
	["123"] = vec3(-677.36, 5834.58, 17.32),
	["124"] = vec3(472.3, -1001.57, 30.68),
	["125"] = vec3(468.52, -990.55, 26.27),
	["126"] = vec3(349.86, -594.51, 28.8),
	["127"] = vec3(2564.5, 2584.79, 38.08),
	["128"] = vec3(-1200.76, -885.44, 13.26),
	["129"] = vec3(821.54, -780.27, 26.17),
	["130"] = vec3(-1243.12, -1455.52, 4.31),
	["131"] = vec3(-1242.01, -1454.75, 4.31),
	["132"] = vec3(-1240.89, -1453.96, 4.31),
	["133"] = vec3(822.93, -825.94, 26.32),
	["134"] = vec3(-609.78, -1091.97, 22.33),
	["135"] = vec3(560.1, 2742.66, 43.35),
	["136"] = vec3(540.22, 2671.54, 42.3),
	["137"] = vec3(33.22, -1348.66, 29.63),
	["138"] = vec3(961.48, 41.24, 72.0),
	["139"] = vec3(236.85, 219.76, 106.61),
	["140"] = vec3(237.27, 218.87, 106.58),
	["141"] = vec3(237.7, 217.94, 106.6),
	["142"] = vec3(238.13, 217.02, 106.59),
	["143"] = vec3(238.57, 216.09, 106.62),
	["144"] = vec3(-34.76, -212.94, 45.88)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Atm(Coords)
	local Select = false
	local BombZone = false

	for Number,v in pairs(Atm) do
		if #(Coords - v) <= 1.0 then
			BombZone = vec3(v["x"], v["y"], v["z"] - 1)
			Select = Number
			break
		end
	end

	return BombZone, Select
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADATMTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number, v in pairs(Atm) do
		exports["target"]:AddCircleZone("Atm:" .. Number, v, 0.5, {
			name = "Atm:" .. Number,
			heading = 0.0
		}, {
			Distance = 1.0,
			options = {
				{
					event = "bank:Open",
					label = "Abrir",
					tunnel = "client"
				}, {
					event = "player:GetCard",
					label = "Solicitar Cartão",
					tunnel = "server"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKARMS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckArms()
	return exports["paramedic"]:Arms()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckMods(Vehicle, Mod)
	return GetNumVehicleMods(Vehicle, Mod) - 1
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCAR
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckCar(Vehicle)
	local Model = GetEntityModel(Vehicle)
	return IsThisModelACar(Model)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ActiveMods(Vehicle, Plate, Mod, Number)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleMod(Vehicle, Mod, Number)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BURGERSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
local Burgershot = PolyZone:Create({
	vec2(-1175.3, -894.8),
	vec2(-1185.34, -901.58),
	vec2(-1187.69, -898.4),
	vec2(-1198.78, -905.4),
	vec2(-1208.05, -891.77),
	vec2(-1186.99, -877.54)
}, { name = "Burgershot" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTAURANT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Restaurant()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	if Burgershot:isPointInside(Coords) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTIITYCOORDSZ
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.EntityCoordsZ()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local _,GroundZ = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])

	return vec3(Coords["x"],Coords["y"],GroundZ)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOSSANTOS
-----------------------------------------------------------------------------------------------------------------------------------------
local LosSantos = PolyZone:Create({
	vec2(-2153.08, -3131.33),
	vec2(-1581.58, -2092.38),
	vec2(-3271.05, 275.85),
	vec2(-3460.83, 967.42),
	vec2(-3202.39, 1555.39),
	vec2(-1642.50, 993.32),
	vec2(312.95, 1054.66),
	vec2(1313.70, 341.94),
	vec2(1739.01, -1280.58),
	vec2(1427.42, -3440.38),
	vec2(-737.90, -3773.97)
}, { name = "Santos" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANDYSHORES
-----------------------------------------------------------------------------------------------------------------------------------------
local SandyShores = PolyZone:Create({
	vec2(-375.38, 2910.14),
	vec2(307.66, 3664.47),
	vec2(2329.64, 4128.52),
	vec2(2349.93, 4578.50),
	vec2(1680.57, 4462.48),
	vec2(1570.01, 4961.27),
	vec2(1967.55, 5203.67),
	vec2(2387.14, 5273.98),
	vec2(2735.26, 4392.21),
	vec2(2512.33, 3711.16),
	vec2(1681.79, 3387.82),
	vec2(258.85, 2920.16)
}, { name = "Sandy" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- PALETOBAY
-----------------------------------------------------------------------------------------------------------------------------------------
local PaletoBay = PolyZone:Create({
	vec2(-529.40, 5755.14),
	vec2(-234.39, 5978.46),
	vec2(278.16, 6381.84),
	vec2(672.67, 6434.39),
	vec2(699.56, 6877.77),
	vec2(256.59, 7058.49),
	vec2(17.64, 7054.53),
	vec2(-489.45, 6449.50),
	vec2(-717.59, 6030.94)
}, { name = "Paleto" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("CEventGunShot", function(_, OtherPeds)
	local Ped = PlayerPedId()
	if Ped == OtherPeds and not LocalPlayer["state"]["Policia"] and GetGameTimer() >= ShotDelay and Weapon ~= "WEAPON_MUSKET" and Weapon ~= "WEAPON_SAUER" then
		ShotDelay = GetGameTimer() + 60000
		TriggerEvent("player:Residuals", "Resíduo de Pólvora.")

		local Coords = GetEntityCoords(Ped)
		if not IsPedCurrentWeaponSilenced(Ped) then
			if (LosSantos:isPointInside(Coords) or SandyShores:isPointInside(Coords) or PaletoBay:isPointInside(Coords)) then
				vSERVER.ShotsFired(IsPedInAnyVehicle(Ped))
				TriggerServerEvent("evidence:Drop", "Blue")
			end
		else
			if math.random(100) >= 75 and (LosSantos:isPointInside(Coords) or SandyShores:isPointInside(Coords) or PaletoBay:isPointInside(Coords)) then
				vSERVER.ShotsFired(IsPedInAnyVehicle(Ped))
				TriggerServerEvent("evidence:Drop", "Blue")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TINTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tints",function()
	if not IsPauseMenuActive() then
		if IsPedArmed(GetPlayerPed(-1), 7) and IsPedArmed(GetPlayerPed(-1), 4) then
			if LocalPlayer["state"]["Active"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and MumbleIsConnected() then
				if LocalPlayer["state"]["Premium"] then
					exports["dynamic"]:AddButton("Padrão","Clique alterar seu armamento.","inventory:ChooseTint",0,false,false)

					if CheckNormal(Weapon) then
						exports["dynamic"]:SubMenu("Normais","Para armas <b>Normais</b>.","Normal")
						exports["dynamic"]:AddButton("Green","Clique alterar seu armamento.","inventory:ChooseTint",1,"Normal",false)
						exports["dynamic"]:AddButton("Gold","Clique alterar seu armamento.","inventory:ChooseTint",2,"Normal",false)
						exports["dynamic"]:AddButton("Pink","Clique alterar seu armamento.","inventory:ChooseTint",3,"Normal",false)
						exports["dynamic"]:AddButton("Army","Clique alterar seu armamento.","inventory:ChooseTint",4,"Normal",false)
						exports["dynamic"]:AddButton("LSPD","Clique alterar seu armamento.","inventory:ChooseTint",5,"Normal",false)
						exports["dynamic"]:AddButton("Orange","Clique alterar seu armamento.","inventory:ChooseTint",6,"Normal",false)
						exports["dynamic"]:AddButton("Platinum","Clique alterar seu armamento.","inventory:ChooseTint",7,"Normal",false)
					elseif CheckSpecial(Weapon) then
						exports["dynamic"]:SubMenu("Especiais","Para armas <b>MK2</b>.","MK2")
						exports["dynamic"]:AddButton("Classic Gray","Clique alterar seu armamento.","inventory:ChooseTint",1,"MK2",false)
						exports["dynamic"]:AddButton("Classic Two-Tone","Clique alterar seu armamento.","inventory:ChooseTint",2,"MK2",false)
						exports["dynamic"]:AddButton("Classic White","Clique alterar seu armamento.","inventory:ChooseTint",3,"MK2",false)
						exports["dynamic"]:AddButton("Classic Beige","Clique alterar seu armamento.","inventory:ChooseTint",4,"MK2",false)
						exports["dynamic"]:AddButton("Classic Green","Clique alterar seu armamento.","inventory:ChooseTint",5,"MK2",false)
						exports["dynamic"]:AddButton("Classic Blue","Clique alterar seu armamento.","inventory:ChooseTint",6,"MK2",false)
						exports["dynamic"]:AddButton("Classic Earth","Clique alterar seu armamento.","inventory:ChooseTint",7,"MK2",false)
						exports["dynamic"]:AddButton("Classic Brown & Black","Clique alterar seu armamento.","inventory:ChooseTint",8,"MK2",false)
						exports["dynamic"]:AddButton("Red Contrast","Clique alterar seu armamento.","inventory:ChooseTint",9,"MK2",false)
						exports["dynamic"]:AddButton("Blue Contrast","Clique alterar seu armamento.","inventory:ChooseTint",10,"MK2",false)
						exports["dynamic"]:AddButton("Yellow Contrast","Clique alterar seu armamento.","inventory:ChooseTint",11,"MK2",false)
						exports["dynamic"]:AddButton("Orange Contrast","Clique alterar seu armamento.","inventory:ChooseTint",12,"MK2",false)
						exports["dynamic"]:AddButton("Bold Pink","Clique alterar seu armamento.","inventory:ChooseTint",13,"MK2",false)
						exports["dynamic"]:AddButton("Bold Purple & Yellow","Clique alterar seu armamento.","inventory:ChooseTint",14,"MK2",false)
						exports["dynamic"]:AddButton("Bold Orange","Clique alterar seu armamento.","inventory:ChooseTint",15,"MK2",false)
						exports["dynamic"]:AddButton("Bold Green & Purple","Clique alterar seu armamento.","inventory:ChooseTint",16,"MK2",false)
						exports["dynamic"]:AddButton("Bold Red Features","Clique alterar seu armamento.","inventory:ChooseTint",17,"MK2",false)
						exports["dynamic"]:AddButton("Bold Green Features","Clique alterar seu armamento.","inventory:ChooseTint",18,"MK2",false)
						exports["dynamic"]:AddButton("Bold Cyan Features","Clique alterar seu armamento.","inventory:ChooseTint",19,"MK2",false)
						exports["dynamic"]:AddButton("Bold Yellow Features","Clique alterar seu armamento.","inventory:ChooseTint",20,"MK2",false)
						exports["dynamic"]:AddButton("Bold Red & White","Clique alterar seu armamento.","inventory:ChooseTint",21,"MK2",false)
						exports["dynamic"]:AddButton("Bold Blue & White","Clique alterar seu armamento.","inventory:ChooseTint",22,"MK2",false)
						exports["dynamic"]:AddButton("Metallic Gold","Clique alterar seu armamento.","inventory:ChooseTint",23,"MK2",false)
						exports["dynamic"]:AddButton("Metallic Platinum","Clique alterar seu armamento.","inventory:ChooseTint",24,"MK2",false)
						exports["dynamic"]:AddButton("Metallic Gray & Lilac","Clique alterar seu armamento.","inventory:ChooseTint",25,"MK2",false)
						exports["dynamic"]:AddButton("Metallic Purple & Lime","Clique alterar seu armamento.","inventory:ChooseTint",26,"MK2",false)
						exports["dynamic"]:AddButton("Metallic Red","Clique alterar seu armamento.","inventory:ChooseTint",27,"MK2",false)
						exports["dynamic"]:AddButton("Metallic Green","Clique alterar seu armamento.","inventory:ChooseTint",28,"MK2",false)
						exports["dynamic"]:AddButton("Metallic Blue","Clique alterar seu armamento.","inventory:ChooseTint",29,"MK2",false)
						exports["dynamic"]:AddButton("Metallic White & Aqua","Clique alterar seu armamento.","inventory:ChooseTint",30,"MK2",false)
						exports["dynamic"]:AddButton("Metallic Orange & Yellow","Clique alterar seu armamento.","inventory:ChooseTint",31,"MK2",false)
						exports["dynamic"]:AddButton("Mettalic Red and Yellow","Clique alterar seu armamento.","inventory:ChooseTint",32,"MK2",false)
					end

					exports["dynamic"]:openMenu()
				else
					TriggerEvent("Notify", "amarelo", "Você precisa ser <b>Premium</b>.", "Atenção", 5000)
				end
			end
		else
			TriggerEvent("Notify", "default", "Você precisa estar armado.", false, 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CHOOSETINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:ChooseTint")
AddEventHandler("inventory:ChooseTint", function(Tint)
	if Weapon ~= "" then
		local Ped = PlayerPedId()
		SetPedWeaponTintIndex(PlayerPedId(), Weapon, parseInt(Tint))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKNORMAL
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckNormal(Name)
	local Weapon = SplitOne(Name)

	if NormalWeaponsTints[Weapon] then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSPECIAL
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckSpecial(Name)
	local Weapon = SplitOne(Name)

	if SpecialWeaponsTints[Weapon] then
		return true
	end

	return false
end