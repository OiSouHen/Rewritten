-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Sources = {}
Characters = {}
CharactersArena = {}
GlobalState["Players"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Timer = {}
local Party = {}
local Global = {}
local Salary = {}
local SrvData = {}
local SelfReturn = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Objects = {}
Party["Room"] = {}
Party["Users"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERIES
-----------------------------------------------------------------------------------------------------------------------------------------
local Prepares = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Prepare(Name, Query)
	Prepares[Name] = Query
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Query(Name, Params)
	return exports.oxmysql:query_async(Prepares[Name], Params)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTITIES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Identities(source)
	local Result = false

	local Identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(Identifiers) do
		if string.find(v, BaseMode) then
			local SplitName = splitString(v, ":")
			Result = SplitName[2]
			break
		end
	end

	return Result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARCHIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Archive(Archive,Text)
	Archive = io.open(Archive,"a")

	if Archive then
		Archive.write(Archive,Text.."\n")
	end

	Archive.close(Archive)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Banned(License)
	local Consult = vRP.Query("banneds/GetBanned",{ License = License })
	if Consult and Consult[1] then
		if Consult[1]["Time"] <= os.time() then
			vRP.Query("banneds/RemoveBanned",{ License = License })
			return false
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTOKEN
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckToken(source, License)
	local Token = GetPlayerTokens(source)
	for k,v in pairs(Token) do
		local Consult = vRP.Query("banneds/GetToken",{ Token = v })
		if Consult[1] then
			return false
		end

		vRP.Query("banneds/InsertToken",{ License = License, Token = v })
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Account(License)
	return vRP.Query("accounts/Account",{ License = License })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserData(Passport, Value)
	local Consult = vRP.Query("playerdata/GetData",{ Passport = Passport, Name = Value })
	if Consult and Consult[1] then
		return json.decode(Consult[1]["Information"])
	else
		return {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSIDEPROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InsidePropertys(Passport, Coords)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		HensaTable["Pos"] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]) }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Inventory(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		if not HensaTable["Inventory"] then
			HensaTable["Inventory"] = {}
		end

		return HensaTable["Inventory"]
	end

	return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVETEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SaveTemporary(Passport, source, Route)
	local HensaTable = vRP.Datatable(Passport)
	if not CharactersArena[Passport] and HensaTable then
		CharactersArena[Passport] = {}
		CharactersArena[Passport]["Inventory"] = HensaTable["Inventory"]
		CharactersArena[Passport]["Health"] = GetEntityHealth(GetPlayerPed(source))
		CharactersArena[Passport]["Armour"] = GetPedArmour(GetPlayerPed(source))
		CharactersArena[Passport]["Stress"] = HensaTable["Stress"]
		CharactersArena[Passport]["Hunger"] = HensaTable["Hunger"]
		CharactersArena[Passport]["Thirst"] = HensaTable["Thirst"]
		CharactersArena[Passport]["route"] = Route

		SetPedArmour(GetPlayerPed(source), 100)

		vRPC.SetHealth(source, 200)

		vRP.UpgradeHunger(Passport, 100)
		vRP.UpgradeThirst(Passport, 100)
		vRP.DowngradeStress(Passport, 100)

		TriggerEvent("inventory:saveTemporary", Passport)

		HensaTable["Inventory"] = {}

		for Number,v in pairs(ArenaItens) do
			vRP.GenerateItem(Passport, Number, v, false)
		end

		TriggerEvent("vRP:BucketServer", source, "Enter", Route)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYTEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ApplyTemporary(Passport, source)
	local HensaTable = vRP.Datatable(Passport)
	if CharactersArena[Passport] and HensaTable then
		HensaTable["Inventory"] = {}
		HensaTable["Inventory"] = CharactersArena[Passport]["Inventory"]
		HensaTable["Stress"] = CharactersArena[Passport]["Stress"]
		HensaTable["Hunger"] = CharactersArena[Passport]["Hunger"]
		HensaTable["Thirst"] = CharactersArena[Passport]["Thirst"]

		TriggerClientEvent("hud:Cough", source, HensaTable["Cough"])
		TriggerClientEvent("hud:Thirst", source, HensaTable["Thirst"])
		TriggerClientEvent("hud:Hunger", source, HensaTable["Hunger"])
		TriggerClientEvent("hud:Stress", source, HensaTable["Stress"])
		TriggerClientEvent("hud:Oxigen", source, HensaTable["Oxigen"])

		SetPedArmour(GetPlayerPed(source), CharactersArena[Passport]["Armour"])
		vRPC.SetHealth(source, CharactersArena[Passport]["Health"])
		TriggerEvent("inventory:applyTemporary", Passport)
		TriggerEvent("vRP:BucketServer", source, "Exit")

		CharactersArena[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SkinCharacter(Passport, Hash)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		HensaTable["Skin"] = Hash
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Passport(source)
	if Characters[source] then
		return Characters[source]["id"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Players()
	return Sources
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Source(Passport)
	return Sources[parseInt(Passport)]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATATABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Datatable(Passport)
	if Characters[Sources[parseInt(Passport)]] then
		return Characters[Sources[parseInt(Passport)]]["table"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Kick(source, Reason)
	DropPlayer(source, Reason)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped", function(Reason)
	if Characters[source] and DoesEntityExist(GetPlayerPed(source)) then
		Disconnect(source, GetEntityHealth(GetPlayerPed(source)), GetPedArmour(GetPlayerPed(source)), GetEntityCoords(GetPlayerPed(source)), Reason)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function Disconnect(source, Health, Armour, Coords, Reason)
	local Passport = vRP.Passport(source)
	local HensaTable = vRP.Datatable(Passport)
	if Passport then
		exports["vrp"]:Embed("Disconnect","**Source:** "..source.."\n**Passaporte:** "..vRP.Passport(source).."\n**Health:** "..Health.."\n**Armour:** "..Armour.."\n**Cds:** "..Coords.."\n**Motivo:** "..Reason,3092790)

		if HensaTable then
			if CharactersArena[Passport] then
				HensaTable["Stress"] = CharactersArena[Passport]["Stress"]
				HensaTable["Hunger"] = CharactersArena[Passport]["Hunger"]
				HensaTable["Thirst"] = CharactersArena[Passport]["Thirst"]
				HensaTable["Armour"] = CharactersArena[Passport]["Armour"]
				HensaTable["Health"] = CharactersArena[Passport]["Health"]
				HensaTable["Inventory"] = CharactersArena[Passport]["Inventory"]
				HensaTable["Pos"] = { x = BackArenaPos["x"], y = BackArenaPos["y"], z = BackArenaPos["z"] }
				TriggerEvent("arena:Players", "-", CharactersArena[Passport]["route"])
				CharactersArena[Passport] = nil
			else
				HensaTable["Health"] = Health
				HensaTable["Armour"] = Armour
				HensaTable["Pos"] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]) }
			end

			if HensaTable["Health"] <= 100 then
				TriggerClientEvent("hud:Textform", -1, Coords, "<b>Passaporte:</b> " .. Passport .. "<br><b>Motivo:</b> " .. Reason, CombatLogMinutes * 60000)
			end

			TriggerEvent("Disconnect", Passport, source)
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Datatable", Information = json.encode(HensaTable) })
			Characters[source] = nil
			Sources[Passport] = nil

			if GlobalState["Players"][source] then
				GlobalState["Players"][source] = nil
				GlobalState:set("Players", GlobalState["Players"], true)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer", function()
	for k,v in pairs(Sources) do
		local HensaTable = vRP.Datatable(k)
		if HensaTable then
			vRP.Query("playerdata/SetData",{ Passport = k, Name = "Datatable", Information = json.encode(HensaTable) })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Queue:Connecting", function(source, identifiers, deferrals)
	deferrals.defer()

	local Identities = vRP.Identities(source)
	if Identities then
		local Account = vRP.Account(Identities)
		if not Account then
			vRP.Query("accounts/NewAccount",{ License = Identities })
		end

		if Maintenance then
			if MaintenanceLicenses[Identities] then
				deferrals.done()
			else
				deferrals.done(MaintenanceText)
			end
		elseif not vRP.Banned(Identities) then
			if Whitelisted then
				local Account = vRP.Account(Identities)
				if Account["Whitelist"] then
					deferrals.done()
				else
					deferrals.done(ReleaseText..": "..Account["id"])
				end
			else
				deferrals.done()
			end
		else
			CheckToken(Identities)
			deferrals.done(BannedText..".")
		end
	else
		deferrals.done("Conexão perdida.")
	end

	TriggerEvent("Queue:Remove", identifiers)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSENCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChosenCharacter(source, Passport, Model)
	Sources[Passport] = source
	if not Characters[source] then
		local Consult = vRP.Query("characters/Person",{ id = Passport })
		local Identities = vRP.Identities(source)
		local Account = vRP.Account(Identities)
		if #Consult > 0 then
			Characters[source] = {}

			Characters[source]["id"] = Consult[1]["id"]
			Characters[source]["License"] = Consult[1]["License"]
			Characters[source]["Phone"] = Consult[1]["Phone"]
			Characters[source]["Name"] = Consult[1]["Name"]
			Characters[source]["Lastname"] = Consult[1]["Lastname"]
			Characters[source]["Sex"] = Consult[1]["Sex"]
			Characters[source]["Skin"] = Consult[1]["Skin"]
			Characters[source]["Bank"] = Consult[1]["Bank"]
			Characters[source]["Fines"] = Consult[1]["Fines"]
			Characters[source]["Taxs"] = Consult[1]["Taxs"]
			Characters[source]["Blood"] = Consult[1]["Blood"]
			Characters[source]["Prison"] = Consult[1]["Prison"]
			Characters[source]["Gun"] = Consult[1]["Gun"]
			Characters[source]["Avatar"] = Consult[1]["Avatar"]
			Characters[source]["Likes"] = Consult[1]["Likes"]
			Characters[source]["Unlikes"] = Consult[1]["Unlikes"]
			Characters[source]["Badge"] = Consult[1]["Badge"]
			Characters[source]["Driver"] = Consult[1]["Driver"]
			Characters[source]["Mode"] = Consult[1]["Mode"]
			Characters[source]["Work"] = Consult[1]["Work"]
			Characters[source]["Created"] = Consult[1]["Created"]
			Characters[source]["Deleted"] = Consult[1]["Deleted"]
			Characters[source]["Rolepass"] = Account["Rolepass"]
			Characters[source]["Premium"] = Account["Premium"]
			Characters[source]["Discord"] = Account["Discord"]
			Characters[source]["Characters"] = Account["Characters"]
			Characters[source]["table"] = vRP.UserData(Passport,"Datatable")

			GlobalState["Players"][source] = Passport
			GlobalState:set("Players",GlobalState["Players"], true)
		end

		if Model then
			Characters[source]["table"]["Skin"] = Model
			Characters[source]["table"]["Inventory"] = {}

			for k,v in pairs(CharacterItens) do
				vRP.GenerateItem(Passport,k,v,false)
			end

			if NewItemIdentity then
				vRP.GenerateItem(Passport,"identity-"..Passport,1,false)
			end

			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Barbershop", Information = json.encode({ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) })
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Clothings", Information = json.encode(StartClothes[Model]) })
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Datatable", Information = json.encode(Characters[source]["table"]) })
		end

		if Account["Gemstone"] > 0 then
			TriggerClientEvent("hud:AddGemstone",source,Account["Gemstone"])
		end

		exports["vrp"]:Embed("Connect","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Nome:** "..vRP.FullName(Passport).."\n**Address:** "..GetPlayerEndpoint(source),3092790)
	end

	TriggerEvent("ChosenCharacter",Passport,source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetMapName(ServerName)
	SetGameType(ServerName)
	SetRoutingBucketEntityLockdownMode(0, EntityLockdown)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REWARDS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:Rewards", function(source)
	if Characters[source] and Characters[source]["Rolepass"] > 0 and parseInt(os.date("%d")) > Characters[source]["Rolepass"] and Rewards[parseInt(os.date("%d"))] then
		vRP.GenerateItem(Characters[source]["id"], Rewards[parseInt(os.date("%d"))]["item"], Rewards[parseInt(os.date("%d"))]["amount"], false)
		TriggerClientEvent("inventory:Update", source, "Backpack")

		if parseInt(os.date("%d")) >= 30 then
			vRP.UpdateRolepass(source, 0)
		else
			vRP.UpdateRolepass(source, parseInt(os.date("%d")))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:ActivePass", function(source)
	if Characters[source] then
		for i = 1, parseInt(os.date("%d")) do
			if Rewards[parseInt(os.date("%d"))] then
				vRP.GenerateItem(Characters[source]["id"], Rewards[i]["item"], Rewards[i]["amount"], false)
				TriggerClientEvent("inventory:Update", source, "Backpack")
			end
		end

		if parseInt(os.date("%d")) >= 30 then
			vRP.UpdateRolepass(source, 0)
		else
			vRP.UpdateRolepass(source, parseInt(os.date("%d")))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function getQueue(ids, trouble, source, connect)
	for k,v in ipairs(connect and Queue.Connecting or Queue.List) do
		local inQueue = false

		if not source then
			for _, i in ipairs(v["ids"]) do
				if inQueue then
					break
				end

				for _, o in ipairs(ids) do
					if o == i then
						inQueue = true
						break
					end
				end
			end
		else
			inQueue = ids == v["source"]
		end

		if inQueue then
			if trouble then
				return k, connect and Queue.Connecting[k] or Queue.List[k]
			end

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSERUNNING
-----------------------------------------------------------------------------------------------------------------------------------------
function LicenseRunning(source)
	local result = false
	local identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(identifiers) do
		if string.find(v, BaseMode) then
			result = true
			break
		end
	end

	return result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPRIORITY
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckPriority(player)
	for _,identifier in pairs(GetPlayerIdentifiers(player)) do
		if string.find(identifier, BaseMode) and vRP.LicensePremium(splitString(identifier, ":")[2]) then
			break
		end
	end

	return 10
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function addQueue(ids, connectTime, name, source, deferrals)
	if getQueue(ids) then
		return
	end

	local tmp = {
		source = source,
		ids = ids,
		name = name,
		firstconnect = connectTime,
		priority = CheckPriority(ids),
		timeout = 0,
		deferrals = deferrals
	}

	local _pos = false
	local queueCount = #Queue.List + 1

	for k,v in ipairs(Queue.List) do
		if tmp["priority"] then
			if not v["priority"] then
				_pos = k
			else
				if tmp["priority"] > v["priority"] then
					_pos = k
				end
			end

			if _pos then
				break
			end
		end
	end

	if not _pos then
		_pos = #Queue.List + 1
	end

	table.insert(Queue.List, _pos, tmp)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function removeQueue(ids, source)
	if getQueue(ids, false, source) then
		local pos, data = getQueue(ids, true, source)
		table.remove(Queue.List, pos)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function isConnect(ids, source, refresh)
	local k,v = getQueue(ids, refresh and true or false, source and true or false, true)

	if not k then
		return false
	end

	if refresh and k and v then
		Queue.Connecting[k]["timeout"] = 0
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVECONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function removeConnect(ids, source)
	for k,v in ipairs(Queue.Connecting) do
		local connect = false

		if not source then
			for _, i in ipairs(v["ids"]) do
				if connect then
					break
				end

				for _, o in ipairs(ids) do
					if o == i then
						connect = true
						break
					end
				end
			end
		else
			connect = ids == v["source"]
		end

		if connect then
			table.remove(Queue.Connecting, k)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function addConnect(ids, ignorePos, autoRemove, done)
	local function removeFromQueue()
		if not autoRemove then
			return
		end

		done(Lang.Error)
		removeConnect(ids)
		removeQueue(ids)
	end

	if #Queue.Connecting >= 100 then
		removeFromQueue()
		return false
	end

	if isConnect(ids) then
		removeConnect(ids)
	end

	local pos, data = getQueue(ids, true)
	if not ignorePos and (not pos or pos > 1) then
		removeFromQueue()
		return false
	end

	table.insert(Queue.Connecting, data)
	removeQueue(ids)

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEAMIDS
-----------------------------------------------------------------------------------------------------------------------------------------
function steamIds(source)
	return GetPlayerIdentifiers(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function updateData(source, ids, deferrals)
	local pos, data = getQueue(ids, true)
	Queue.List[pos]["ids"] = ids
	Queue.List[pos]["timeout"] = 0
	Queue.List[pos]["source"] = source
	Queue.List[pos]["deferrals"] = deferrals
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function notFull(firstJoin)
	local canJoin = Queue.Counts + #Queue.Connecting < Queue.Max and #Queue.Connecting < 100
	if firstJoin and canJoin then
		canJoin = #Queue.List <= 1
	end

	return canJoin
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function setPosition(ids, newPos)
	local pos, data = getQueue(ids, true)
	table.remove(Queue.List, pos)
	table.insert(Queue.List, newPos, data)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUETHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local function playerConnect(name, setKickReason, deferrals)
		local source = source
		local ids = steamIds(source)
		local connecting = true
		local connectTime = os.time()
		deferrals.defer()

		CreateThread(function()
			while connecting do
				Wait(500)
				if not connecting then
					return
				end

				deferrals.update(Lang.Connecting)
			end
		end)

		Wait(1000)
		local function done(message)
			connecting = false
			CreateThread(function()
				if message then
					deferrals.update(tostring(message) and tostring(message) or "")
				end

				Wait(1000)

				if message then
					deferrals.done(tostring(message) and tostring(message) or "")
					CancelEvent()
				end
			end)
		end

		local function update(message)
			connecting = false
			deferrals.update(tostring(message) and tostring(message) or "")
		end

		if not LicenseRunning(source) then
			done("Você esta sem sua steam ou algum dos nossos identificadores abertos.")
			CancelEvent()
			return
		end

		local reason = "Removido da fila."

		local function setReason(message)
			reason = tostring(message)
		end

		TriggerEvent("Queue:playerJoinQueue", source, setReason)

		if WasEventCanceled() then
			done(reason)

			removeQueue(ids)
			removeConnect(ids)

			CancelEvent()
			return
		end

		if getQueue(ids) then
			rejoined = true
			updateData(source, ids, deferrals)
		else
			addQueue(ids, connectTime, name, source, deferrals)
		end

		if isConnect(ids, false, true) then
			removeConnect(ids)

			if notFull() then
				local added = addConnect(ids, true, true, done)
				if not added then
					CancelEvent()
					return
				end

				done()
				TriggerEvent("Queue:Connecting", source, ids, deferrals)

				return
			else
				addQueue(ids, connectTime, name, source, deferrals)
				setPosition(ids, 1)
			end
		end

		local pos, data = getQueue(ids, true)

		if not pos or not data then
			done(Lang.Error)
			RemoveFromQueue(ids)
			RemoveFromConnecting(ids)
			CancelEvent()
			return
		end

		if notFull(true) then
			local added = addConnect(ids, true, true, done)
			if not added then
				CancelEvent()
				return
			end

			done()

			TriggerEvent("Queue:Connecting", source, ids, deferrals)

			return
		end

		update(string.format(Lang.Position, pos, #Queue.List))

		CreateThread(function()
			if rejoined then
				return
			end

			Queue.Threads = Queue.Threads + 1
			local dotCount = 0

			while true do
				Wait(1000)
				local dots = ""

				dotCount = dotCount + 1
				if dotCount > 3 then
					dotCount = 0
				end

				for i = 1, dotCount do
					dots = dots .. "."
				end

				local pos, data = getQueue(ids, true)

				if not pos or not data then
					if data and data.deferrals then
						data.deferrals.done(Lang.Error)
					end

					CancelEvent()
					removeQueue(ids)
					removeConnect(ids)
					Queue.Threads = Queue.Threads - 1
					return
				end

				if pos <= 1 and notFull() then
					local added = addConnect(ids)
					data.deferrals.update(Lang.Join)
					Wait(500)

					if not added then
						data.deferrals.done(Lang.Error)
						CancelEvent()
						Queue.Threads = Queue.Threads - 1
						return
					end

					data.deferrals.update("Carregando conexão com o servidor.")

					removeQueue(ids)
					Queue.Threads = Queue.Threads - 1

					TriggerEvent("Queue:Connecting", source, data.ids, data.deferrals)

					return
				end

				local message = string.format("Base Hensa\n\n"..Lang.Position.."%s\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, deixe sua sugestão em nosso discord.", pos, #Queue.List, dots)
				data.deferrals.update(message)
			end
		end)
	end

	AddEventHandler("playerConnecting", playerConnect)

	local function checkTimeOuts()
		local i = 1

		while i <= #Queue.List do
			local data = Queue.List[i]
			local lastMsg = GetPlayerLastMsg(data.source)

			if lastMsg == 0 or lastMsg >= 30000 then
				data.timeout = data.timeout + 1
			else
				data.timeout = 0
			end

			if not data.ids or not data.name or not data.firstconnect or data.priority == nil or not data.source then
				data.deferrals.done(Lang.Error)
				table.remove(Queue.List, i)
			elseif (data.timeout >= 120) and os.time() - data.firstconnect > 5 then
				data.deferrals.done(Lang.Error)
				removeQueue(data.source, true)
				removeConnect(data.source, true)
			else
				i = i + 1
			end
		end

		i = 1

		while i <= #Queue.Connecting do
			local data = Queue.Connecting[i]
			local lastMsg = GetPlayerLastMsg(data.source)
			data.timeout = data.timeout + 1

			if ((data.timeout >= 300 and lastMsg >= 35000) or data.timeout >= 340) and os.time() - data.firstconnect > 5 then
				removeQueue(data.source, true)
				removeConnect(data.source, true)
			else
				i = i + 1
			end
		end

		SetTimeout(1000, checkTimeOuts)
	end

	checkTimeOuts()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUE:CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Queue:Connect")
AddEventHandler("Queue:Connect", function()
	local source = source
	if not Queue.Players[source] then
		local ids = steamIds(source)
		Queue.Counts = Queue.Counts + 1
		Queue.Players[source] = true
		removeQueue(ids)
		removeConnect(ids)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECTING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnecting", function()
	local Identifiers = GetPlayerIdentifiers(source)
	local RockstarLicense = ""
	local DiscordID = ""

	for _, Identifier in ipairs(Identifiers) do
		if string.find(Identifier, "License:") then
			RockstarLicense = string.gsub(Identifier, "License:", "")
		elseif string.find(Identifier, "Discord:") then
			DiscordID = string.gsub(Identifier, "Discord:", "")
		end

		if RockstarLicense ~= "" and DiscordID ~= "" then
			break
		end
	end

	if RockstarLicense ~= "" then
		exports["oxmysql"]:update("UPDATE accounts SET Discord = ? WHERE License LIKE ?", {DiscordID, "%"..RockstarLicense} )
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped", function()
	if Queue.Players[source] then
		local ids = steamIds(source)
		Queue.Counts = Queue.Counts - 1
		Queue.Players[source] = nil
		removeQueue(ids)
		removeConnect(ids)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUE:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Queue:remove", function(ids)
	removeQueue(ids)
	removeConnect(ids)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEEDRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WeedReturn(Passport)
	if Timer[Passport] then
		if os.time() < Timer[Passport] then
			return parseInt(Timer[Passport] - os.time())
		else
			Timer[Passport] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEEDTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WeedTimer(Passport, Time)
	if Timer[Passport] then
		Timer[Passport] = Timer[Passport] + Time * 60
	else
		Timer[Passport] = os.time() + Time * 60
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChemicalReturn(Passport)
	if Timer[Passport] then
		if os.time() < Timer[Passport] then
			return parseInt(Timer[Passport] - os.time())
		else
			Timer[Passport] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChemicalTimer(Passport, Time)
	if Timer[Passport] then
		Timer[Passport] = Timer[Passport] + Time * 60
	else
		Timer[Passport] = os.time() + Time * 60
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALCOHOLRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.AlcoholReturn(Passport)
	if Timer[Passport] then
		if os.time() < Timer[Passport] then
			return parseInt(Timer[Passport] - os.time())
		else
			Timer[Passport] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALCOHOLTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.AlcoholTimer(Passport, Time)
	if Timer[Passport] then
		Timer[Passport] = Timer[Passport] + Time * 60
	else
		Timer[Passport] = os.time() + Time * 60
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FALSEIDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.FalseIdentity(Passport)
	return vRP.Query("fidentity/Result",{ id = Passport })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Identity(Passport)
	local Source = vRP.Source(Passport)
	if Characters[Source] then
		return Characters[Source] or false
	else
		return vRP.Query("characters/Person",{ id = Passport })[1] or false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FULLNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.FullName(Passport)
	local Source = vRP.Source(Passport)
	if Characters[Source] then
		return Characters[Source]["Name"].." "..Characters[Source]["Lastname"]
	else
		return "Hensa Rewritten"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetWork(Passport)
	local Source = vRP.Source(Passport)
	if Characters[Source] then
		return Characters[Source]["Work"]
	else
		return "Nenhum"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEWORK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChangeWork(Passport, Work)
	local Source = vRP.Source(Passport)
	vRP.Query("characters/UpdateWork",{ Work = Work, Passport = Passport })

	if Characters[Source] then
		Characters[Source]["Work"] = Work

		if Work == "Nenhum" then
			Player(Source)["state"]["Work"] = false
			TriggerClientEvent("Notify", Source, "verde", "Você se demitiu do seu emprego atual.", "Sucesso", 5000)
		else
			Player(Source)["state"]["Work"] = true
			TriggerClientEvent("Notify", Source, "amarelo", "Você se registrou em um novo emprego.", ClassWork(Work), 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVELIKES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveLikes(Passport,Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/AddLikes",{ Likes = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Likes"] = Characters[Source]["Likes"] + parseInt(Amount)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEUNLIKES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveUnLikes(Passport,Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/AddUnlikes",{ Unlikes = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Unlikes"] = Characters[Source]["Unlikes"] + parseInt(Amount)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETLIKES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetLikes(Passport)
	return vRP.Identity(Passport)["Likes"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUNLIKES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetUnLikes(Passport)
	return vRP.Identity(Passport)["Unlikes"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSTATS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetStats(Passport)
	return { vRP.Identity(Passport)["Likes"], vRP.Identity(Passport)["Unlikes"] }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InitPrison(Passport, Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/InsertPrison",{ Prison = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Prison"] = Characters[Source]["Prison"] + parseInt(Amount)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdatePrison(Passport,Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/ReducePrison",{ Prison = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Prison"] = Characters[Source]["Prison"] - parseInt(Amount)

			if 0 >= Characters[Source]["Prison"] then
				exports["markers"]:Exit(Source)
				Characters[Source]["Prison"] = 0
				TriggerClientEvent("police:Prisioner",Source,false)
				vRP.Teleport(Source,BackPrison["x"],BackPrison["y"],BackPrison["z"])
				TriggerClientEvent("Notify",Source,"verde","Serviços finalizados.","Sucesso",5000)
			else
				TriggerClientEvent("Notify",Source,"azul","Restam <b>"..Characters[Source]["Prison"].." serviços</b>.","Sistema Penitenciário",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ClearPrison(OtherPassport)
	local Source = vRP.Source(OtherPassport)
	vRP.Query("characters/CleanPrison",{ Passport = OtherPassport })

	if Characters[Source] then
		Characters[Source]["Prison"] = 0
		TriggerClientEvent("Notify", Source, "verde", CleanPrisonNotify, "Sucesso", 5000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEGUNLICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdateGunlicense(Passport, Gun)
	local Source = vRP.Source(Passport)
	vRP.Query("characters/UpdateGun",{ Gun = parseInt(Gun), Passport = Passport })

	if Characters[Source] then
		Characters[Source]["Gun"] = parseInt(Gun)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETDRIVERLICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetDriverLicense(Passport)
	local Source = vRP.Source(Passport)
	if Characters[Source] then
		return Characters[Source]["Driver"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDRIVERLICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdateDriverLicense(Passport, Driver)
	local Source = vRP.Source(Passport)
	vRP.Query("characters/UpdateDriver",{ Driver = parseInt(Driver), Passport = Passport })

	if Characters[Source] then
		Characters[Source]["Driver"] = parseInt(Driver)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECHARS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeChars(source)
	if Characters[source] then
		vRP.Query("accounts/UpdateCharacters",{ License = Characters[source]["License"] })
		Characters[source]["Characters"] = Characters[source]["Characters"] + 1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserGemstone(License)
	return vRP.Account(License)["Gemstone"] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeGemstone(Passport, Amount)
	local Source = vRP.Source(Passport)
	local Identity = vRP.Identity(Passport)
	if parseInt(Amount) > 0 and Identity then
		vRP.Query("accounts/AddGemstone",{ Gemstone = parseInt(Amount), License = Identity["License"] })

		if Characters[Source] then
			TriggerClientEvent("hud:AddGemstone", Source, parseInt(Amount))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADENAMES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeNames(Passport,Name,Lastname)
	local Source = vRP.Source(Passport)
	vRP.Query("characters/UpdateName",{ Name = Name, Lastname = Lastname, Passport = Passport })

	if Characters[Source] then
		Characters[Source]["Name"] = Name
		Characters[Source]["Lastname"] = Lastname
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradePhone(Passport,Phone)
	local Source = vRP.Source(Passport)
	vRP.Query("characters/UpdatePhone",{ Phone = Phone, Passport = Passport })

	if Characters[Source] then
		Characters[Source]["Phone"] = Phone
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPhone(Phone)
	return vRP.Query("characters/Phone",{ Phone = Phone })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetPhone(Passport)
	if UsingLbPhone then
		local LBPhone = vRP.Query("lb-phone/GetPhone",{ id = Passport, owner = Passport})
		if LBPhone[1] then
			return exports["lb-phone"]:FormatNumber(LBPhone[1]["phone_number"])
		end
	else
		local Smartphone = vRP.Query("characters/Person",{ id = Passport })
		if Smartphone[1] then
			return Smartphone[1]["Phone"]
		end
	end

	return "Sem Sinal"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PassportPlate(Plate)
	return vRP.Query("vehicles/plateVehicles",{ plate = Plate })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GenerateString(Format)
	local Number = ""
	for i = 1, #Format do
		if string.sub(Format, i, i) == "D" then
			Number = Number..string.char(string.byte("0") + math.random(0, 9))
		elseif "L" == string.sub(Format, i, i) then
			Number = Number..string.char(string.byte("A") + math.random(0, 25))
		else
			Number = Number..string.sub(Format, i, i)
		end
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GeneratePlate()
	local Passport = nil
	local Serial = ""
	repeat
		Passport = vRP.PassportPlate(vRP.GenerateString("DDLLLDDD"))
		Serial = vRP.GenerateString("DDLLLDDD")
	until not Passport

	return Serial
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GeneratePhone()
	local Passport = nil
	local Phone = ""
	repeat
		Passport = vRP.UserPhone(vRP.GenerateString("DDD-DDD"))
		Phone = vRP.GenerateString("DDD-DDD")
	until not Passport

	return Phone
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ConsultItem(Passport, Item, Amount)
	if vRP.Source(Passport) then
		if Amount > vRP.InventoryItemAmount(Passport, Item)[1] then
			return false
		elseif vRP.CheckDamaged(vRP.InventoryItemAmount(Passport, Item)[2]) then
			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetWeight(Passport)
	local Source = vRP.Source(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Source and Datatable then
		if not Datatable["Weight"] then
			Datatable["Weight"] = BackpackWeightDefault
		end

		return Datatable["Weight"]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetWeight(Passport, Amount)
	local Source = vRP.Source(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Source and Datatable then
		if not Datatable["Weight"] then
			Datatable["Weight"] = BackpackWeightDefault
		end

		Datatable["Weight"] = Datatable["Weight"] + Amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveWeight(Passport, Amount)
	local Source = vRP.Source(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Source and Datatable then
		if not Datatable["Weight"] then
			Datatable["Weight"] = BackpackWeightDefault
		end

		Datatable["Weight"] = Datatable["Weight"] - Amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWAPSLOT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SwapSlot(Passport, Slot, Target)
	local Source = vRP.Source(Passport)
	local Inventory = vRP.Inventory(Passport)
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	if Source and Inventory then
		Inventory[Target], Inventory[Slot] = Inventory[Slot], Inventory[Target]

		if parseInt(Target) <= 5 then
			if parseInt(Slot) > 5 then
				if "Armamento" == itemType(Inventory[Target]["item"]) then
					TriggerClientEvent("inventory:RemoveWeapon", Source, Inventory[Target]["item"])
				end

				if "Armamento" == itemType(Inventory[Slot]["item"]) then
					TriggerClientEvent("inventory:CreateWeapon", Source, Inventory[Slot]["item"])
				end
			end
		elseif parseInt(Slot) <= 5 and parseInt(Target) > 5 and "Armamento" == itemType(Inventory[Slot]["item"]) then
			TriggerClientEvent("inventory:RemoveWeapon", Source, Inventory[Slot]["item"])

			if "Armamento" == itemType(Inventory[Target]["item"]) then
				TriggerClientEvent("inventory:CreateWeapon", Source, Inventory[Target]["item"])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryWeight(Passport)
	local Weight = 0
	local source = vRP.Source(Passport)
	if source then
		local Inventory = vRP.Inventory(Passport)
		for k,v in pairs(Inventory) do
			Weight = Weight + itemWeight(v["item"]) * v["amount"]
		end
	end

	return Weight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDAMAGED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CheckDamaged(Item)
	if itemDurability(Item) and splitString(Item, "-")[2] and parseInt((3600 * itemDurability(Item) - parseInt(os.time() - splitString(Item, "-")[2])) / (3600 * itemDurability(Item)) * 100) <= 1 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChestWeight(items)
	local Weight = 0
	for k,v in pairs(items) do
		Weight = Weight + (itemWeight(v["item"]) * v["amount"])
	end

	return Weight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryItemAmount(Passport, Item)
	if vRP.Source(Passport) then
		local Inventory = vRP.Inventory(Passport)
		for k,v in pairs(Inventory) do
			local splitName01 = splitString(Item, "-")
			local splitName02 = splitString(v["item"], "-")
			if splitName01[1] == splitName02[1] then
				return { parseInt(v["amount"]), v["item"] }
			end
		end
	end

	return { 0, "" }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryFull(Passport, Item)
	if vRP.Source(Passport) then
		local Inventory = vRP.Inventory(Passport)
		for k,v in pairs(Inventory) do
			if v["item"] == Item then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ItemAmount(Passport, Item)
	if vRP.Source(Passport) then
		local Inventory = vRP.Inventory(Passport)
		for k,v in pairs(Inventory) do
			if splitString(v["item"], "-")[1] == splitString(Item, "-")[1] then
				return v["amount"]
			end
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveItem(Passport, Item, Amount, Notify, Slot)
	local Source = vRP.Source(Passport)
	if Source and parseInt(Amount) > 0 then
		local Inventory = vRP.Inventory(Passport)
		if not Slot then
			local NewSlot = 0

			repeat
				NewSlot = NewSlot + 1
			until Inventory[tostring(NewSlot)] == nil or Inventory[tostring(NewSlot)] and Inventory[tostring(NewSlot)]["item"] == Item

			if not Inventory[tostring(NewSlot)] then
				Inventory[tostring(NewSlot)] = { amount = parseInt(Amount), item = Item }

				if parseInt(tostring(NewSlot)) <= 5 and "Armamento" == itemType(Item) then
					TriggerClientEvent("inventory:CreateWeapon", Source, Item)
				end
			elseif Inventory[tostring(NewSlot)] and Inventory[tostring(NewSlot)]["item"] == Item then
				Inventory[tostring(NewSlot)]["amount"] = Inventory[tostring(NewSlot)]["amount"] + parseInt(Amount)
			end

			if Notify and itemBody(Item) then
				TriggerClientEvent("NotifyItens", Source, { "+", itemIndex(Item), parseInt(Amount), itemName(Item) })
			end
		else
			Slot = tostring(Slot)

			if Inventory[Slot] then
				if Inventory[Slot]["item"] == Item then
					Inventory[Slot]["amount"] = Inventory[Slot]["amount"] + parseInt(Amount)
				end
			else
				Inventory[Slot] = { amount = parseInt(Amount), item = Item }

				if parseInt(Slot) <= 5 and "Armamento" == itemType(Item) then
					TriggerClientEvent("inventory:CreateWeapon", Source, Item)
				end
			end

			if Notify and itemBody(Item) then
				TriggerClientEvent("NotifyItens", Source, { "+", itemIndex(Item), parseInt(Amount), itemName(Item) })
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GenerateItem(Passport, Item, Amount, Notify, Slot)
	local Source = vRP.Source(Passport)
	if Source and parseInt(Amount) > 0 then
		local Inventory = vRP.Inventory(Passport)
		if itemDurability(Item) then
			if itemType(Item) == "Armamento" then
				Item = Item.."-"..os.time().."-"..Passport.."-Hensa"
			elseif itemMode(Item) == "Chest" then
				Item = Item.."-"..os.time().."-"..(math.random(1000,5000) + Passport)
			else
				Item = Item.."-"..os.time()
			end
		elseif itemCharges(Item) then
			Item = Item.."-"..itemCharges(Item)
		end

		if not Slot then
			local NewSlot = 0

			repeat
				NewSlot = NewSlot + 1
			until Inventory[tostring(NewSlot)] == nil or Inventory[tostring(NewSlot)] and Inventory[tostring(NewSlot)]["item"] == Item

			if not Inventory[tostring(NewSlot)] then
				Inventory[tostring(NewSlot)] = { amount = parseInt(Amount), item = Item }

				if parseInt(tostring(i)) <= 5 and "Armamento" == itemType(Item) then
					TriggerClientEvent("inventory:CreateWeapon", Source, Item)
				end
			elseif Inventory[tostring(NewSlot)] and Inventory[tostring(NewSlot)]["item"] == Item then
				Inventory[tostring(NewSlot)]["amount"] = Inventory[tostring(NewSlot)]["amount"] + parseInt(Amount)
			end

			if Notify and itemBody(Item) then
				TriggerClientEvent("NotifyItens", Source, { "+", itemIndex(Item), parseInt(Amount), itemName(Item) })
			end
		else
			Slot = tostring(Slot)

			if Inventory[Slot] then
				if Inventory[Slot]["item"] == Item then
					Inventory[Slot]["amount"] = Inventory[Slot]["amount"] + parseInt(Amount)
				end
			else
				Inventory[Slot] = { amount = parseInt(Amount), item = Item }

				if parseInt(Slot) <= 5 and "Armamento" == itemType(Item) then
					TriggerClientEvent("inventory:CreateWeapon", Source, Item)
				end
			end

			if Notify and itemBody(Item) then
				TriggerClientEvent("NotifyItens", Source, { "+", itemIndex(Item), parseInt(Amount), itemName(Item) })
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAXITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.MaxItens(Passport, Item, Amount)
	if itemBody(Item) and vRP.Source(Passport) and itemMaxAmount(Item) then
		if vRP.HasGroup(Passport, "Restaurantes") then
			if itemScape(Item) and vRP.ItemAmount(Passport, Item) + parseInt(Amount) > itemMaxAmount(Item) * 5 then
				return true
			end
		elseif vRP.ItemAmount(Passport, Item) + parseInt(Amount) > itemMaxAmount(Item) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.TakeItem(Passport, Item, Amount, Notify, Slot)
	SelfReturn[Passport] = false

	local Source = vRP.Source(Passport)
	if Source and parseInt(Amount) > 0 then
		local Inventory = vRP.Inventory(Passport)
		if not Slot then
			for k,v in pairs(Inventory) do
				if v["item"] == Item and parseInt(Amount) <= v["amount"] then
					v["amount"] = v["amount"] - parseInt(Amount)

					if v["amount"] <= 0 then
						if "Armamento" == itemType(Item) or "Throwing" ~= itemType(Item) then
							TriggerClientEvent("inventory:verifyWeapon", Source, Item)
						end

						if parseInt(k) <= 5 then
							TriggerClientEvent("inventory:RemoveWeapon", Source, Item)
						end

						Inventory[k] = nil
					end

					if Notify and itemBody(Item) then
						TriggerClientEvent("NotifyItens", Source, { "-", itemIndex(Item), parseInt(Amount), itemName(Item) })
					end

					SelfReturn[Passport] = true

					break
				end
			end
		elseif Inventory[Slot] and Inventory[Slot]["item"] == Item and parseInt(Amount) <= Inventory[Slot]["amount"] then
			Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - parseInt(Amount)

			if 0 >= Inventory[Slot]["amount"] then
				if "Armamento" == itemType(Item) or "Throwing" ~= itemType(Item) then
					TriggerClientEvent("inventory:verifyWeapon", Source, Item)
				end

				if 5 >= parseInt(Slot) then
					TriggerClientEvent("inventory:RemoveWeapon", Source, Item)
				end

				Inventory[Slot] = nil
			end

			if Notify and itemBody(Item) then
				TriggerClientEvent("NotifyItens", Source, { "-", itemIndex(Item), parseInt(Amount), itemName(Item) })
			end

			SelfReturn[Passport] = true
		end
	end

	local splitName = splitString(Item, "-")
	if itemType(splitName[1]) == "Animal" then
		TriggerClientEvent("dynamic:animalFunctions", source, "destroy")
	end

	return SelfReturn[Passport]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveItem(Passport, Item, Amount, Notify)
	local Source = vRP.Source(Passport)
	if Source and parseInt(Amount) > 0 then
		local Inventory = vRP.Inventory(Passport)
		for k,v in pairs(Inventory) do
			if v["item"] == Item and parseInt(Amount) <= v["amount"] then
				v["amount"] = v["amount"] - parseInt(Amount)

				if v["amount"] <= 0 then
					if "Armamento" == itemType(Item) or "Throwing" ~= itemType(Item) then
						TriggerClientEvent("inventory:verifyWeapon", Source, Item)
					end

					if parseInt(k) <= 5 then
						TriggerClientEvent("inventory:RemoveWeapon", Source, Item)
					end

					Inventory[k] = nil
				end

				if Notify and itemBody(Item) then
					TriggerClientEvent("NotifyItens", Source, { "-", itemIndex(Item), parseInt(Amount), itemName(Item) })
				end

				break
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSERVERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetServerData(Key)
	if SrvData[Key] == nil then
		local Rows = vRP.Query("entitydata/GetData", { Name = Key })
		if parseInt(#Rows) > 0 then
			SrvData[Key] = { data = json.decode(Rows[1]["Information"]), timer = 180 }
		else
			SrvData[Key] = { data = {}, timer = 180 }
		end
	end

	return SrvData[Key]["data"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSERVERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetServerData(Key, Data)
	SrvData[Key] = { data = Data, timer = 180 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVESERVERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveServerData(Key)
	SrvData[Key] = { data = {}, timer = 180 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SRVDATATHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k, v in pairs(SrvData) do
			if v["timer"] > 0 then
				v["timer"] = v["timer"] - 1

				if v["timer"] <= 0 then
					vRP.Query("entitydata/SetData",{ Name = k, Information = json.encode(v["data"]) })
					SrvData[k] = nil
				end
			end
		end

		Wait(60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer", function(Save)
	for k,v in pairs(SrvData) do
		if json.encode(v["data"]) == "[]" or json.encode(v["data"]) == "{}" then
			vRP.Query("entitydata/RemoveData",{ Name = k })
		else
			vRP.Query("entitydata/SetData",{ Name = k, Information = json.encode(v["data"]) })
		end
	end

	if not Save then
		print("O resource ^2vRP^7 salvou os dados.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.TakeChest(Passport,Data,Amount,Slot,Target)
	local Source = vRP.Source(Passport)
	local Datatable = vRP.GetServerData(Data)
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	if Source and parseInt(Amount) > 0 and Datatable[Slot] then
		local Inventory = vRP.Inventory(Passport)
		if vRP.MaxItens(Passport,Datatable[Slot]["item"],parseInt(Amount)) then
			TriggerClientEvent("Notify",Source,"vermelho","Limite atingido.","Aviso",5000)
			return true
		end

		if vRP.InventoryWeight(Passport) + itemWeight(Datatable[Slot]["item"]) * parseInt(Amount) <= vRP.GetWeight(Passport) then
			if Inventory[Target] then
				if Datatable[Slot] and Inventory[Target]["item"] == Datatable[Slot]["item"] and parseInt(Amount) <= Datatable[Slot]["amount"] then
					Inventory[Target]["amount"] = Inventory[Target]["amount"] + parseInt(Amount)
					Datatable[Slot]["amount"] = Datatable[Slot]["amount"] - parseInt(Amount)

					if 0 >= Datatable[Slot]["amount"] then
						Datatable[Slot] = nil
					end
				end
			elseif Datatable[Slot] and parseInt(Amount) <= Datatable[Slot]["amount"] then
				Inventory[Target] = { amount = parseInt(Amount), item = Datatable[Slot]["item"] }
				Datatable[Slot]["amount"] = Datatable[Slot]["amount"] - parseInt(Amount)

				if parseInt(Target) <= 5 and "Armamento" == itemType(Datatable[Slot]["item"]) then
					TriggerClientEvent("inventory:CreateWeapon",Source,Datatable[Slot]["item"])
				end

				if 0 >= Datatable[Slot]["amount"] then
					Datatable[Slot] = nil
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.StoreChest(Passport,Data,Amount,Weight,Slot,Target)
	local Inventory = vRP.Inventory(Passport)
	local Datatable = vRP.GetServerData(Data)
	local Source = vRP.Source(Passport)
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	if Source and parseInt(Amount) > 0 and Inventory[Slot] and Weight >= vRP.ChestWeight(Datatable) + itemWeight(Inventory[Slot]["item"]) * parseInt(Amount) then
		if Datatable[Target] then
			if Inventory[Slot] then
				if Inventory[Slot]["item"] ~= Datatable[Target]["item"] then
					return
				end

				if not (parseInt(Amount) <= Inventory[Slot]["amount"]) then
					return
				end

				Datatable[Target]["amount"] = Datatable[Target]["amount"] + parseInt(Amount)
				Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - parseInt(Amount)

				if 0 >= Inventory[Slot]["amount"] then
					if "Armamento" == itemType(Inventory[Slot]["item"]) or "Throwing" ~= itemType(Inventory[Slot]["item"]) then
						TriggerClientEvent("inventory:verifyWeapon",Source,Inventory[Slot]["item"])

						if parseInt(Slot) <= 5 then
							TriggerClientEvent("inventory:RemoveWeapon",Source,Inventory[Slot]["item"])
						end
					end

					Inventory[Slot] = nil
				end
			end
		elseif Inventory[Slot] and parseInt(Amount) <= Inventory[Slot]["amount"] then
			Datatable[Target] = { amount = parseInt(Amount), item = Inventory[Slot]["item"] }
			Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - parseInt(Amount)

			if 0 >= Inventory[Slot]["amount"] then
				if "Armamento" == itemType(Inventory[Slot]["item"]) or "Throwing" ~= itemType(Inventory[Slot]["item"]) then
					TriggerClientEvent("inventory:verifyWeapon",Source,Inventory[Slot]["item"])

					if parseInt(Slot) <= 5 then
						TriggerClientEvent("inventory:RemoveWeapon",Source,Inventory[Slot]["item"])
					end
				end

				Inventory[Slot] = nil
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdateChest(Passport,Data,Slot,Target,Amount)
	local Datatable = vRP.GetServerData(Data)
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	if vRP.Source(Passport) and parseInt(Amount) > 0 and Datatable[Slot] then
		if Datatable[Target] then
			if Datatable[Slot] then
				if Datatable[Slot]["item"] == Datatable[Target]["item"] then
					if parseInt(Amount) <= Datatable[Slot]["amount"] then
						Datatable[Slot]["amount"] = Datatable[Slot]["amount"] - parseInt(Amount)

						if 0 >= Datatable[Slot]["amount"] then
							Datatable[Slot] = nil
						end

						Datatable[Target]["amount"] = Datatable[Target]["amount"] + parseInt(Amount)
					end
				else
					Datatable[Target], Datatable[Slot] = Datatable[Slot], Datatable[Target]
				end
			end
		elseif Datatable[Slot] and parseInt(Amount) <= Datatable[Slot]["amount"] then
			Datatable[Slot]["amount"] = Datatable[Slot]["amount"] - parseInt(Amount)
			Datatable[Target] = { item = Datatable[Slot]["item"], amount = parseInt(Amount) }

			if 0 >= Datatable[Slot]["amount"] then
				Datatable[Slot] = nil
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIRECTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DirectChest(Chest,Slot,Amount)
	local Datatable = vRP.GetServerData("Chest:"..Chest)
	if Datatable[Slot] then
		if Datatable[Slot]["item"] == DefaultDollars1 then
			Datatable[Slot]["amount"] = Datatable[Slot]["amount"] + parseInt(Amount)
		else
			Datatable[Slot] = { item = DefaultDollars1, amount = parseInt(Amount) }
		end
	else
		Datatable[Slot] = { item = DefaultDollars1, amount = parseInt(Amount) }, parseInt(Amount)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChestPremium(Chest)
	local Consult = vRP.Query("chests/GetChests",{ Name = Chest })
	if Consult[1]["Premium"] > 0 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.UpdateInventory(Slot,Target,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Amount) > 0 then
		SelfReturn[Passport] = true

		local Inventory = vRP.Inventory(Passport)
		local Slot = tostring(Slot)
		local Target = tostring(Target)
		if Inventory[Slot] then
			if Inventory[Target] then
				if Inventory[Slot]["item"] == Inventory[Target]["item"] then
					if parseInt(Amount) <= Inventory[Slot]["amount"] then
						Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - parseInt(Amount)
						Inventory[Target]["amount"] = Inventory[Target]["amount"] + parseInt(Amount)

						if Inventory[Slot]["amount"] <= 0 then
							if parseInt(Slot) <= 5 and "Armamento" == itemType(Inventory[Slot]["item"]) then
								TriggerClientEvent("inventory:RemoveWeapon",source,Inventory[Slot]["item"])
							end

							Inventory[Slot] = nil
						end

						SelfReturn[Passport] = false
					end
				else
					if Inventory[Slot]["item"] and Inventory[Target]["item"] then
						if Inventory[Slot]["item"] == "repairkit0"..string.sub(Inventory[Slot]["item"],11,12) then
							if vRP.CheckDamaged(Inventory[Target]["item"]) and Inventory[Target]["amount"] == 1 then
								if Inventory[Slot]["item"] == "repairkit0"..string.sub(Inventory[Slot]["item"],11,12) then
									if itemRepair(Inventory[Target]["item"]) then
										if itemRepair(Inventory[Target]["item"]) == Inventory[Slot]["item"] then
											if vRP.TakeItem(Passport,Inventory[Slot]["item"],1,false,Slot) then
												if splitString(Inventory[Target]["item"],"-")[3] then
													Inventory[Target]["item"] = splitString(Inventory[Target]["item"],"-")[1].."-"..os.time().."-"..splitString(Inventory[Target]["item"],"-")[3]
													TriggerClientEvent("Notify",source,"verde","Reparado.","Sucesso",5000)
												else
													Inventory[Target]["item"] = splitString(Inventory[Target]["item"],"-")[1].."-"..os.time()
													TriggerClientEvent("Notify",source,"verde","Reparado.","Sucesso",5000)
												end
											end
										else
											TriggerClientEvent("Notify",source,"amarelo","Use <b>1x "..itemName(itemRepair(Inventory[Target]["item"])).."</b>.","Atenção",5000)
										end
									end
								end
							end
						else
							Inventory[Target], Inventory[Slot] = Inventory[Slot], Inventory[Target]

							if parseInt(Target) <= 5 then
								if parseInt(Slot) > 5 then
									if "Armamento" == itemType(Inventory[Target]["item"]) then
										TriggerClientEvent("inventory:RemoveWeapon",source,Inventory[Target]["item"])
									end

									if "Armamento" == itemType(Inventory[Slot]["item"]) then
										TriggerClientEvent("inventory:CreateWeapon",source,Inventory[Slot]["item"])
									end
								end
							elseif parseInt(Slot) <= 5 and parseInt(Target) > 5 then
								if "Armamento" == itemType(Inventory[Slot]["item"]) then
									TriggerClientEvent("inventory:RemoveWeapon",source,Inventory[Slot]["item"])
								end

								if "Armamento" == itemType(Inventory[Target]["item"]) then
									TriggerClientEvent("inventory:CreateWeapon",source,Inventory[Target]["item"])
								end
							end

							SelfReturn[Passport] = false
						end
					end
				end
			elseif Inventory[Slot] and parseInt(Amount) <= Inventory[Slot]["amount"] then
				Inventory[Target] = { item = Inventory[Slot]["item"], amount = parseInt(Amount) }
				Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - parseInt(Amount)

				if Inventory[Slot]["amount"] <= 0 then
					if parseInt(Slot) <= 5 and parseInt(Target) > 5 and itemType(Inventory[Slot]["item"]) == "Armamento" then
						TriggerClientEvent("inventory:RemoveWeapon",source,Inventory[Slot]["item"])
					end

					if parseInt(Target) <= 5 and parseInt(Slot) > 5 and itemType(Inventory[Slot]["item"]) == "Armamento" then
						TriggerClientEvent("inventory:CreateWeapon",source,Inventory[Slot]["item"])
					end

					Inventory[Slot] = nil
				end

				SelfReturn[Passport] = false
			end
		else
			TriggerClientEvent("inventory:Update",source,"Backpack")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetPremium(source)
	if Characters[source] then
		vRP.Query("accounts/SetPremium",{ Premium = os.time() + 2592000, License = Characters[source]["License"] })
		Characters[source]["Premium"] = parseInt(os.time() + 2592000)
		vRP.SetWeight(vRP.Passport(source),BackpackWeightPremiumDefault)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradePremium(source)
	if Characters[source] then
		vRP.Query("accounts/UpgradePremium",{ License = Characters[source]["License"] })
		Characters[source]["Premium"] = Characters[source]["Premium"] + 2592000
		vRP.SetWeight(vRP.Passport(source),BackpackWeightPremiumDefault)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPremium(Passport)
	local Source = vRP.Source(Passport)
	local Permission = vRP.HasPermission(Passport,"Premium")
	if Characters[Source] then
		if Characters[Source]["Premium"] < os.time() then
			if Permission then
				vRP.RemovePermission(Passport,"Premium")
			end
		elseif not Permission then
			vRP.SetWeight(Passport,BackpackWeightPremiumDefault)
			vRP.SetPermission(Passport,"Premium")
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.LicensePremium(License)
	local Account = vRP.Account(License)
	if Account and Account["Premium"] >= os.time() then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEROLEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdateRolepass(source, Day)
	if Characters[source] then
		vRP.Query("accounts/Rolepass",{ Rolepass = Day, License = Characters[source]["License"] })
		Characters[source]["Rolepass"] = Day
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROLEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CheckRolepass(source)
	if Characters[source] and Characters[source]["Rolepass"] > 0 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("CleanVehicle")
AddEventHandler("CleanVehicle", function(entIndex)
	if DoesEntityExist(NetworkGetEntityFromNetworkId(entIndex)) and not IsPedAPlayer(NetworkGetEntityFromNetworkId(entIndex)) and 2 == GetEntityType(NetworkGetEntityFromNetworkId(entIndex)) then
		SetVehicleDirtLevel(NetworkGetEntityFromNetworkId(entIndex), 0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMBED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Embed", function(Webhook, Message, Color)
	PerformHttpRequest(Discords[Webhook], function(err, text, headers) end, "POST", json.encode({ avatar_url = "https://raw.githubusercontent.com/OiSouHen/OiSouHen/main/images/Hensa-rainbow.png", username = ServerName, embeds = { { color = Color, description = Message } } }), { ["Content-Type"] = "application/json" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Create(source, Passport, Message)
	if Message and not Party["Users"][Passport] and not Party["Room"][Message] then
		Party["Room"][Message] = {}
		Party["Users"][Passport] = Message
		Party["Room"][Message][Passport] = source
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Add(source, Passport, Message)
	if not Party["Users"][Passport] and not Party["Room"][Message][Passport] then
		Party["Users"][Passport] = Message
		Party["Room"][Party["Users"][Passport]][Passport] = source
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Rem(source, Passport, Message)
	if Party["Users"][Passport] and Party["Room"][Message][Passport] then
		Party["Users"][Passport] = nil
		Party["Room"][Message][Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Leave(source, Passport)
	if Party["Users"][Passport] then
		vRP.Rem(source, Passport, Party["Users"][Passport])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Party(Passport)
	if Passport then
		if Party["Users"][Passport] and Party["Room"][Party["Users"][Passport]] then
			for k,v in pairs(Party["Room"][Party["Users"][Passport]]) do
				return "#"..k.." "..vRP.FullName(k).."<br>"
			end
		end

		return false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Party", function(Passport, source, Distance)
	local Partys = {}
	if Party["Users"][Passport] and Party["Room"][Party["Users"][Passport]] then
		for k,v in pairs(Party["Room"][Party["Users"][Passport]]) do
			if Distance >= #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(v))) then
				Partys[#Partys + 1] = {
					["Passport"] = k,
					["Source"] = source
				}
			end
		end
	end

	return Partys
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GANGBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GangBank(Mode, Value, Gang)
	if parseInt(Value) > 0 then
		if Mode == "Add" then
			vRP.Query("gang/AddValue",{ Value = parseInt(Value), Gang = Gang })
		elseif Mode == "Rem" then
			vRP.Query("gang/RemValue",{ Value = parseInt(Value), Gang = Gang })
		end
	elseif not Value then
		if Mode == "See" then
			local Infos = vRP.Query("gang/GetInformations",{ Gang = Gang })
			if Infos then
				return Infos[1]["Bank"]
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveBank(Passport, Amount)
	local source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/AddBank",{ Bank = parseInt(Amount), Passport = Passport })

		if NewBank then
			exports["bank"]:AddTransactions(Passport, "entry", parseInt(Amount))
		end

		if Characters[source] then
			Characters[source]["Bank"] = Characters[source]["Bank"] + parseInt(Amount)
			TriggerClientEvent("NotifyItens", source, { "+", DefaultDollars1, parseInt(Amount), itemName(DefaultDollars1) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveBank(Passport, Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/RemBank",{ Bank = parseInt(Amount), Passport = Passport })

		if NewBank then
			exports["bank"]:AddTransactions(Passport, "exit", parseInt(Amount))
		end

		if Characters[Source] then
			Characters[Source]["Bank"] = Characters[Source]["Bank"] - parseInt(Amount)

			if Characters[Source]["Bank"] <= 0 then
				Characters[Source]["Bank"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetBank(source)
	if Characters[source] then
		return Characters[source]["Bank"]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetFine(source)
	if Characters[source] then
		return Characters[source]["Fines"]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveFine(Passport, Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/AddFines",{ Fines = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Fines"] = Characters[Source]["Fines"] + parseInt(Amount)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveFine(Passport, Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/RemFines",{ Fines = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Fines"] = Characters[Source]["Fines"] - parseInt(Amount)

			if Characters[Source]["Fines"] <= 0 then
				Characters[Source]["Fines"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETTAX
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetTax(source)
	if Characters[source] then
		return Characters[source]["Taxs"]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVETAX
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveTax(Passport, Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/AddTaxs",{ Taxs = parseInt(Amount), Passport = Passport})

		if Characters[Source] then
			Characters[Source]["Taxs"] = Characters[Source]["Taxs"] + parseInt(Amount)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETAX
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveTax(Passport, Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/RemTaxs",{ Taxs = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Taxs"] = Characters[Source]["Taxs"] - parseInt(Amount)

			if Characters[Source]["Taxs"] <= 0 then
				Characters[Source]["Taxs"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEMODE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChangeMode(Passport, Mode)
	local Source = vRP.Source(Passport)
	vRP.Query("characters/ChangeMode",{ Mode = Mode, Passport = Passport })

	if Characters[Source] then
		Characters[Source]["Mode"] = Mode
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentService(Passport, Amount, Mode, Silenced)
	local source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		if Mode == "Legal" then
			vRP.GenerateItem(Passport, DefaultDollars1, Amount, Silenced)
		elseif Mode == "Ilegal" then
			vRP.GenerateItem(Passport, DefaultDollars2, Amount, Silenced)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTGEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentGems(Passport,Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 and Characters[Source] and parseInt(Amount) <= vRP.UserGemstone(Characters[Source]["License"]) then
		vRP.Query("accounts/RemoveGemstone",{ Gemstone = parseInt(Amount), License = Characters[Source]["License"] })
		TriggerClientEvent("hud:RemoveGemstone",Source,parseInt(Amount))

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentBank(Passport,Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 and Characters[Source] and parseInt(Amount) <= Characters[Source]["Bank"] then
		vRP.RemoveBank(Passport, parseInt(Amount))
		TriggerClientEvent("NotifyItens",Source,{ "-", DefaultDollars1, parseInt(Amount), itemName(DefaultDollars1) })
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentFull(Passport,Amount)
	local Amount = parseInt(Amount)
	local Source = vRP.Source(Passport)
	if Amount > 0 then
		if vRP.TakeItem(Passport,DefaultDollars1,Amount,true) then
			return true
		elseif vRP.TakeItem(Passport,DefaultDollars3,Amount,true) then
			TriggerEvent("Wanted",Source,Passport,60)

			local Coords = vRP.GetEntityCoords(Source)
			local Service = vRP.NumPermission("Policia")
			for Passports,Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Tentativa de Golpe", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", color = 16 })
				end)
			end

			return true
		elseif Characters[Source] and Amount <= Characters[Source]["Bank"] then
			if vRP.ConsultItem(Passport,"bankcard",1) then
				if not GlobalState["Blackout"] then
					vRP.RemoveBank(Passport,Amount)
					TriggerClientEvent("NotifyItens",Source,{ "-", DefaultDollars1, Amount, itemName(DefaultDollars1) })
					return true
				else
					TriggerClientEvent("Notify",Source,"vermelho","No momento não estamos aceitando <b>"..itemName("bankcard").."</b> pois estamos sem eletricidade.","Aviso",5000)
				end
			else
				TriggerClientEvent("Notify",Source,"vermelho","Você precisa de <b>1x "..itemName("bankcard").."</b>.","Aviso",5000)
			end
		else
			TriggerClientEvent("Notify",Source,"vermelho","<b>Saldo</b> insuficiente.","Aviso",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWCASH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WithdrawCash(Passport,Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 and Characters[Source] and parseInt(Amount) <= Characters[Source]["Bank"] then
		vRP.GenerateItem(Passport,DefaultDollars1,parseInt(Amount),true)
		vRP.RemoveBank(Passport,parseInt(Amount))

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSENCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("ChosenCharacter", function(Passport, source)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		if HensaTable["Pos"] then
			if not (HensaTable["Pos"]["x"] and HensaTable["Pos"]["y"] and HensaTable["Pos"]["z"]) then
				HensaTable["Pos"] = { x = SpawnCoords["x"], y = SpawnCoords["y"], z = SpawnCoords["z"] }
			end
		else
			HensaTable["Pos"] = { x = SpawnCoords["x"], y = SpawnCoords["y"], z = SpawnCoords["z"] }
		end

		if not HensaTable["Skin"] then
			HensaTable["Skin"] = "mp_m_freemode_01"
		end

		if not HensaTable["Inventory"] then
			HensaTable["Inventory"] = {}
		end

		if not HensaTable["Health"] then
			HensaTable["Health"] = 200
		end

		if not HensaTable["Armour"] then
			HensaTable["Armour"] = 0
		end

		if not HensaTable["Stress"] then
			HensaTable["Stress"] = 0
		end

		if not HensaTable["Cough"] then
			HensaTable["Cough"] = 0
		end

		if not HensaTable["Hunger"] then
			HensaTable["Hunger"] = 100
		end

		if not HensaTable["Thirst"] then
			HensaTable["Thirst"] = 100
		end

		if not HensaTable["Oxigen"] then
			HensaTable["Oxigen"] = 100
		end

		if not HensaTable["Weight"] then
			HensaTable["Weight"] = BackpackWeightDefault
		end

		vRPC.Skin(source, HensaTable["Skin"])
		vRP.SetArmour(source, HensaTable["Armour"])
		vRPC.SetHealth(source, HensaTable["Health"])
		vRP.Teleport(source, HensaTable["Pos"]["x"], HensaTable["Pos"]["y"], HensaTable["Pos"]["z"])

		TriggerClientEvent("barbershop:Apply", source, vRP.UserData(Passport, "Barbershop"))
		TriggerClientEvent("skinshop:Apply", source, vRP.UserData(Passport, "Clothings"))
		TriggerClientEvent("tattooshop:Apply", source, vRP.UserData(Passport, "Tatuagens"))

		TriggerClientEvent("hud:Cough", source, HensaTable["Cough"])
		TriggerClientEvent("hud:Thirst", source, HensaTable["Thirst"])
		TriggerClientEvent("hud:Hunger", source, HensaTable["Hunger"])
		TriggerClientEvent("hud:Stress", source, HensaTable["Stress"])
		TriggerClientEvent("hud:Oxigen", source, HensaTable["Oxigen"])

		TriggerClientEvent("vRP:Active", source, Passport, vRP.FullName(Passport))

		Player(source)["state"]["Passport"] = Passport

		if vRP.Identity(Passport)["Work"] == "Nenhum" then
			Player(source)["state"]["Work"] = false
		else
			Player(source)["state"]["Work"] = true
		end

		if GetResourceMetadata("vrp", "creator") == "yes" then
			if vRP.UserData(Passport, "Creator") == 1 then
				if Global[Passport] then
					TriggerClientEvent("spawn:Finish", source, false, false)
				else
					TriggerClientEvent("spawn:Finish", source, true, vec3(HensaTable["Pos"]["x"], HensaTable["Pos"]["y"], HensaTable["Pos"]["z"]))
				end
			else
				vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Creator", Information = json.encode(1) })
				TriggerClientEvent("spawn:Finish", source, false, true)
			end
		elseif Global[Passport] then
			TriggerClientEvent("spawn:Finish", source, false, false)
		else
			TriggerClientEvent("spawn:Finish", source, true, vec3(HensaTable["Pos"]["x"], HensaTable["Pos"]["y"], HensaTable["Pos"]["z"]))
		end

		TriggerEvent("Connect", Passport, source, Global[Passport] == nil)
		Global[Passport] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ONLYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:OnlyObjects")
AddEventHandler("vRP:OnlyObjects", function()
	local source = source
	local Passport = vRP.Passport(source)
	local Inventory = vRP.Inventory(Passport)
	if Passport then
		for i = 1, 5 do
			if Inventory[tostring(i)] and itemType(Inventory[tostring(i)]["item"]) == "Armamento" then
				TriggerClientEvent("inventory:CreateWeapon", source, Inventory[tostring(i)]["item"])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:BACKPACKWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:BackpackWeight")
AddEventHandler("vRP:BackpackWeight", function(Value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Value then
			if not Global[Passport] then
				vRP.Datatable(Passport)["Weight"] = vRP.Datatable(Passport)["Weight"] + Value
				Global[Passport] = true
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DeleteObject")
AddEventHandler("DeleteObject", function(Index, Value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Value and Objects[Passport] and Objects[Passport][Value] then
			Index = Objects[Passport][Value]
			Objects[Passport][Value] = nil
		end
	end

	TriggerEvent("DeleteObjectServer", Index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECTSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DeleteObjectServer", function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 3 then
		DeleteEntity(idNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DeletePed")
AddEventHandler("DeletePed", function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 1 then
		DeleteEntity(idNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUGOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DebugObjects", function(value)
	if Objects[value] then
		for k,v in pairs(Objects[value]) do
			Objects[value][k] = nil
			TriggerEvent("DeleteObjectServer", k)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUGWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DebugWeapons", function(value)
	if Objects[value] then
		for k,v in pairs(Objects[value]) do
			TriggerEvent("DeleteObjectServer", v)
			Objects[value] = nil
		end

		Objects[value] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gg", function(source)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and GetPlayerRoutingBucket(source) < 900000 and SURVIVAL.CheckDeath(source) then
		if vRP.UserPremium(Passport) then
			if ClearInventoryPremium then
				vRP.ClearInventory(Passport)
			end
		elseif CleanDeathInventory then
			vRP.ClearInventory(Passport)
		end

		local HensaTable = vRP.Datatable(Passport)
		if WipeBackpackDeath and HensaTable and HensaTable["Weight"] then
			HensaTable["Weight"] = BackpackWeightDefault

			local Consult = vRP.GetServerData("Backpacks:"..Passport)
			if Consult["Comum"] then
				vRP.RemoveServerData("Backpacks:"..Passport)
			end
		end

		vRP.UpgradeThirst(Passport, 100)
		vRP.UpgradeHunger(Passport, 100)
		vRP.DowngradeCough(Passport, 100)
		vRP.DowngradeStress(Passport, 100)

		SURVIVAL.Respawn(source)

		TriggerClientEvent("dynamic:animalFunctions", source, "destroy")
		exports["vrp"]:Embed("Airport","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Address:** "..GetPlayerEndpoint(source),3092790)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ClearInventory(Passport)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if source and HensaTable and HensaTable["Inventory"] then
		exports["inventory"]:CleanWeapons(parseInt(Passport), true)

		TriggerEvent("DebugObjects", parseInt(Passport))
		TriggerEvent("DebugWeapons", parseInt(Passport))

		HensaTable["Inventory"] = {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeThirst(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Thirst"] then
			HensaTable["Thirst"] = 0
		end

		HensaTable["Thirst"] = HensaTable["Thirst"] + parseInt(Amount)

		if HensaTable["Thirst"] > 100 then
			HensaTable["Thirst"] = 100
		end

		TriggerClientEvent("hud:Thirst", source, HensaTable["Thirst"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeHunger(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Hunger"] then
			HensaTable["Hunger"] = 0
		end

		HensaTable["Hunger"] = HensaTable["Hunger"] + parseInt(Amount)

		if HensaTable["Hunger"] > 100 then
			HensaTable["Hunger"] = 100
		end

		TriggerClientEvent("hud:Hunger", source, HensaTable["Hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeStress(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Stress"] then
			HensaTable["Stress"] = 0
		end

		HensaTable["Stress"] = HensaTable["Stress"] + parseInt(Amount)

		if HensaTable["Stress"] > 100 then
			HensaTable["Stress"] = 100
		end

		TriggerClientEvent("hud:Stress", source, HensaTable["Stress"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECOUGH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeCough(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Cough"] then
			HensaTable["Cough"] = 0
		end

		HensaTable["Cough"] = HensaTable["Cough"] + parseInt(Amount)

		if HensaTable["Cough"] > 100 then
			HensaTable["Cough"] = 100
		end

		TriggerClientEvent("hud:Cough", source, HensaTable["Cough"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeOxigen(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Oxigen"] then
			HensaTable["Oxigen"] = 0
		end

		HensaTable["Oxigen"] = HensaTable["Oxigen"] + parseInt(Amount)

		if HensaTable["Oxigen"] > 100 then
			HensaTable["Oxigen"] = 100
		end

		TriggerClientEvent("hud:Oxigen", source, HensaTable["Oxigen"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeThirst(Passport, Amount)
	local Source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and Source then
		if not HensaTable["Thirst"] then
			HensaTable["Thirst"] = 100
		end

		HensaTable["Thirst"] = HensaTable["Thirst"] - parseInt(Amount)

		if HensaTable["Thirst"] < 0 then
			HensaTable["Thirst"] = 0
		end

		TriggerClientEvent("hud:Thirst", Source, HensaTable["Thirst"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeHunger(Passport, Amount)
	local Source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and Source then
		if not HensaTable["Hunger"] then
			HensaTable["Hunger"] = 100
		end

		HensaTable["Hunger"] = HensaTable["Hunger"] - parseInt(Amount)

		if HensaTable["Hunger"] < 0 then
			HensaTable["Hunger"] = 0
		end

		TriggerClientEvent("hud:Hunger", Source, HensaTable["Hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeStress(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Stress"] then
			HensaTable["Stress"] = 0
		end

		HensaTable["Stress"] = HensaTable["Stress"] - parseInt(Amount)

		if HensaTable["Stress"] < 0 then
			HensaTable["Stress"] = 0
		end

		TriggerClientEvent("hud:Stress", source, HensaTable["Stress"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADECOUGH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeCough(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Cough"] then
			HensaTable["Cough"] = 0
		end

		HensaTable["Cough"] = HensaTable["Cough"] - parseInt(Amount)

		if HensaTable["Cough"] < 0 then
			HensaTable["Cough"] = 0
		end

		TriggerClientEvent("hud:Cough", source, HensaTable["Cough"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeOxigen(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Oxigen"] then
			HensaTable["Oxigen"] = 0
		end

		HensaTable["Oxigen"] = HensaTable["Oxigen"] - parseInt(Amount)

		if HensaTable["Oxigen"] < 0 then
			HensaTable["Oxigen"] = 0
		end

		TriggerClientEvent("hud:Oxigen", source, HensaTable["Oxigen"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOOD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k,v in pairs(Sources) do
			local Source = vRP.Source(k)
			if Source then
				if TemperatureEffect then
					if Player(Source)["state"]["Location"] == "South" then
						if GlobalState["TemperatureS"] >= TemperatureHot then
							vRP.DowngradeHunger(k, ConsumeHunger)
							vRP.DowngradeThirst(k, ConsumeThirst * 2)
						elseif GlobalState["TemperatureS"] <= TemperatureCold then
							vRP.DowngradeHunger(k, ConsumeHunger * 2)
							vRP.DowngradeThirst(k, ConsumeThirst)
						else
							vRP.DowngradeHunger(k, ConsumeHunger)
							vRP.DowngradeThirst(k, ConsumeThirst)
						end
					elseif Player(Source)["state"]["Location"] == "North" then
						if GlobalState["TemperatureN"] >= TemperatureHot then
							vRP.DowngradeHunger(k, ConsumeHunger)
							vRP.DowngradeThirst(k, ConsumeThirst * 2)
						elseif GlobalState["TemperatureN"] <= TemperatureCold then
							vRP.DowngradeHunger(k, ConsumeHunger * 2)
							vRP.DowngradeThirst(k, ConsumeThirst)
						else
							vRP.DowngradeHunger(k, ConsumeHunger)
							vRP.DowngradeThirst(k, ConsumeThirst)
						end
					end
				else
					vRP.DowngradeHunger(k, ConsumeHunger)
					vRP.DowngradeThirst(k, ConsumeThirst)
				end
			end
		end

		Wait(CooldownHungerThrist)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOODS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Foods()
	local source = source
	local Passport = vRP.Passport(source)
	local HensaTable = vRP.Datatable(Passport)
	if source and HensaTable then
		if not HensaTable["Thirst"] then
			HensaTable["Thirst"] = 100
		end

		if not HensaTable["Hunger"] then
			HensaTable["Hunger"] = 100
		end

		if TemperatureEffect then
			if Player(source)["state"]["Location"] == "South" then
				if GlobalState["TemperatureS"] >= TemperatureHot then
					HensaTable["Hunger"] = HensaTable["Hunger"] - ConsumeHunger
					HensaTable["Thirst"] = HensaTable["Thirst"] - ConsumeThirst * 2
				elseif GlobalState["TemperatureS"] <= TemperatureCold then
					HensaTable["Hunger"] = HensaTable["Hunger"] - ConsumeHunger * 2
					HensaTable["Thirst"] = HensaTable["Thirst"] - ConsumeThirst
				else
					HensaTable["Hunger"] = HensaTable["Hunger"] - ConsumeHunger
					HensaTable["Thirst"] = HensaTable["Thirst"] - ConsumeThirst
				end
			elseif Player(source)["state"]["Location"] == "North" then
				if GlobalState["TemperatureN"] >= TemperatureHot then
					HensaTable["Hunger"] = HensaTable["Hunger"] - ConsumeHunger
					HensaTable["Thirst"] = HensaTable["Thirst"] - ConsumeThirst * 2
				elseif GlobalState["TemperatureN"] <= TemperatureCold then
					HensaTable["Hunger"] = HensaTable["Hunger"] - ConsumeHunger * 2
					HensaTable["Thirst"] = HensaTable["Thirst"] - ConsumeThirst
				else
					HensaTable["Hunger"] = HensaTable["Hunger"] - ConsumeHunger
					HensaTable["Thirst"] = HensaTable["Thirst"] - ConsumeThirst
				end
			end
		else
			HensaTable["Hunger"] = HensaTable["Hunger"] - ConsumeHunger
			HensaTable["Thirst"] = HensaTable["Thirst"] - ConsumeThirst
		end

		if HensaTable["Thirst"] < 0 then
			HensaTable["Thirst"] = 0
		end

		if HensaTable["Hunger"] < 0 then
			HensaTable["Hunger"] = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetHealth(source)
	return GetEntityHealth(GetPlayerPed(source))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ModelPlayer(source)
	if GetEntityModel(GetPlayerPed(source)) == GetHashKey("mp_f_freemode_01") then
		return "mp_f_freemode_01"
	end

	return "mp_m_freemode_01"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetExperience(Passport, Work)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and not HensaTable[Work] then
		HensaTable[Work] = 0
	end

	return HensaTable[Work] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PutExperience(Passport, Work, Number)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		if not HensaTable[Work] then
			HensaTable[Work] = 0
		end

		HensaTable[Work] = HensaTable[Work] + Number
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetArmour(source, Amount)
	if GetPedArmour(GetPlayerPed(source)) + Amount > 100 then
		Amount = 100 - GetPedArmour(GetPlayerPed(source))
	end

	SetPedArmour(GetPlayerPed(source), GetPedArmour(GetPlayerPed(source)) + Amount)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Teleport(source, x, y, z)
	SetEntityCoords(GetPlayerPed(source), x + 0.0001, y + 0.0001, z + 0.0001, false, false, false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETENTITYCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetEntityCoords(source)
	return GetEntityCoords(GetPlayerPed(source))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreatePed(Model, X, Y, Z, Heading, Type)
	local Hash = GetHashKey(Model)
	local Create = CreatePed(Type, Hash, X, Y, Z, Heading, true, false)
	local Network = NetworkGetNetworkIdFromEntity(Create)
	while true do
		if DoesEntityExist(Create) then
			break
		end

		if not (0 <= 1000) then
			break
		end

		Wait(1)
	end

	if DoesEntityExist(Create) then
		return true, Network
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreateObject(Model, x, y, z, Weapon)
	local Passport = vRP.Passport(source)
	if Passport then
		local SpawnObjects = 0
		local Hash = GetHashKey(Model)
		local Object = CreateObject(Hash, x, y, z, true, true, false)

		while not DoesEntityExist(Object) and SpawnObjects <= 1000 do
			SpawnObjects = SpawnObjects + 1
			Wait(1)
		end

		local NetworkGetNetworkIdFromEntity = NetworkGetNetworkIdFromEntity(Object)
		if DoesEntityExist(Object) then
			if Weapon then
				if not Objects[Passport] then
					Objects[Passport] = {}
				end

				Objects[Passport][Weapon] = NetworkGetNetworkIdFromEntity
			else
				if not Objects[Passport] then
					Objects[Passport] = {}
				end

				Objects[Passport][NetworkGetNetworkIdFromEntity] = true
			end

			return true, NetworkGetNetworkIdFromEntity
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUCKETCLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:BucketClient")
AddEventHandler("vRP:BucketClient", function(value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if value == "Enter" then
			Player(source)["state"]["Route"] = Passport
			SetPlayerRoutingBucket(source, Passport)
		else
			Player(source)["state"]["Route"] = 0
			SetPlayerRoutingBucket(source, 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUCKETSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:BucketServer")
AddEventHandler("vRP:BucketServer", function(source, value, bucket)
	if value == "Enter" then
		Player(source)["state"]["Route"] = bucket
		SetPlayerRoutingBucket(source, bucket)

		if bucket > 0 then
			SetRoutingBucketEntityLockdownMode(0, EntityLockdown)
			SetRoutingBucketPopulationEnabled(bucket, false)
		end
	else
		SetPlayerRoutingBucket(source, 0)
		Player(source)["state"]["Route"] = 0
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Groups()
	return Groups
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATAGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DataGroups(Permission)
	return vRP.GetServerData("Permissions:"..Permission)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetUserType(Passport,Type)
	for k,v in pairs(Groups) do
		local Datatable = vRP.GetServerData("Permissions:"..k)
		if Groups[k]["Type"] and Groups[k]["Type"] == Type and Datatable[tostring(Passport)] then
			return k
		end
	end

	return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERHIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetUserHierarchy(Passport, Permission)
	local Datatable = vRP.GetServerData("Permissions:"..Permission)
	if Datatable[tostring(Passport)] then
		return Datatable[tostring(Passport)]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGROUPSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetGroupSalary(GroupName, Hierarchy)
	if Hierarchy then
		for k,v in pairs(Groups) do
			if k == GroupName then
				return v["Salary"][Hierarchy]
			end
		end
	else
		for k,v in pairs(Groups) do
			if k == GroupName then
				return v["Salary"]
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Hierarchy(Permission)
	if Groups[Permission] and Groups[Permission]["Hierarchy"] then
		return Groups[Permission]["Hierarchy"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.NumPermission(Permission)
	local Permissions = {}
	local ServiceCount = 0
	if Groups[Permission] and Groups[Permission]["Parent"] then
		for k,v in pairs(Groups[Permission]["Parent"]) do
			if Groups[k] and Groups[k]["Service"] then
				for i,groups in pairs(Groups[k]["Service"]) do
					if groups and Characters[groups] and not Permissions[i] then
						Permissions[i] = groups
						ServiceCount = ServiceCount + 1
					end
				end
			end
		end
	end

	return Permissions, ServiceCount
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICETOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceToggle(Source, Passport, Permission, Silenced)
	local Perm = splitString(Permission, "-")
	if (Characters[Source] and Groups[Perm[1]]) and Groups[Perm[1]]["Service"] then
		if Groups[Perm[1]]["Service"][tostring(Passport)] == Source then
			vRP.ServiceLeave(Source, tostring(Passport), Perm[1], Silenced)
		else
			if vRP.HasGroup(tostring(Passport), Perm[1]) and not Groups[Perm[1]]["Service"][tostring(Passport)] then
				vRP.ServiceEnter(Source, tostring(Passport), Perm[1], Silenced)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICEENTER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceEnter(Source, Passport, Permission, Silenced)
	if Characters[Source] then
		if ClientState[Permission] then
			Player(Source)["state"][Permission] = true
			TriggerClientEvent("service:Label", Source, Permission, "Sair de Serviço")
		end

		if GroupBlips[Permission] then
			exports["markers"]:Enter(Source,Permission)
		end

		if Groups[Permission] and Groups[Permission]["Salary"] then
			TriggerEvent("Salary:Add", tostring(Passport), Permission)
		end

		Groups[Permission]["Service"][tostring(Passport)] = Source

		exports["vrp"]:Embed("Services","**Passaporte:** "..Passport.."\n**Entrou na permissão:** "..Permission,3042892)

		if not Silenced then
			TriggerClientEvent("Notify", Source, "verde", "Entrou em serviço.", false, 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICELEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceLeave(Source, Passport, Permission, Silenced)
	if Characters[Source] then
		if ClientState[Permission] then
			Player(Source)["state"][Permission] = false
			TriggerClientEvent("service:Label", Source, Permission, "Entrar em Serviço")
		end

		if GroupBlips[Permission] then
			exports["markers"]:Exit(Source)
			TriggerClientEvent("radio:RadioClean", Source)
		end

		if Groups[Permission] and Groups[Permission]["Salary"] then
			TriggerEvent("Salary:Remove", tostring(Passport), Permission)
		end

		if Groups[Permission]["Service"] and Groups[Permission]["Service"][tostring(Passport)] then
			Groups[Permission]["Service"][tostring(Passport)] = nil
		end

		
		exports["vrp"]:Embed("Services","**Passaporte:** "..Passport.."\n**Saiu da permissão:** "..Permission,3042892)

		if not Silenced then
			TriggerClientEvent("Notify", Source, "verde", "Saiu de serviço.", false, 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetPermission(Passport, Permission, Level, Mode)
	local Datatable = vRP.GetServerData("Permissions:"..Permission)
	if Groups[Permission] then
		if Mode then
			if Mode == "Demote" then
				Datatable[tostring(Passport)] = Datatable[tostring(Passport)] + 1

				if Datatable[tostring(Passport)] > #Groups[Permission]["Hierarchy"] then
					Datatable[tostring(Passport)] = #Groups[Permission]["Hierarchy"]
				end
			else
				Datatable[tostring(Passport)] = Datatable[tostring(Passport)] - 1

				if Datatable[tostring(Passport)] < 1 then
					Datatable[tostring(Passport)] = 1
				end
			end
		else
			if Level then
				Level = parseInt(Level)

				if #Groups[Permission]["Hierarchy"] < Level then
					Level = #Groups[Permission]["Hierarchy"]
					Datatable[tostring(Passport)] = Level
				else
					Datatable[tostring(Passport)] = Level
				end
			end

			if not Level then
				Datatable[tostring(Passport)] = #Groups[Permission]["Hierarchy"]
			end
		end

		vRP.ServiceEnter(vRP.Source(Passport), tostring(Passport), Permission, true)
		vRP.Query("entitydata/SetData",{ Name = "Permissions:"..Permission, Information = json.encode(Datatable) })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemovePermission(Passport, Permission)
	local Datatable = vRP.GetServerData("Permissions:"..Permission)
	if Groups[Permission] then
		if Groups[Permission]["Service"] and Groups[Permission]["Service"][tostring(Passport)] then
			Groups[Permission]["Service"][tostring(Passport)] = nil
		end

		if Datatable[tostring(Passport)] then
			Datatable[tostring(Passport)] = nil
			vRP.ServiceLeave(vRP.Source(tostring(Passport)), tostring(Passport), Permission, true)
			vRP.Query("entitydata/SetData",{ Name = "Permissions:"..Permission, Information = json.encode(Datatable) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasPermission(Passport, Permission, Level)
	local Datatable = vRP.GetServerData("Permissions:"..Permission)
	if Datatable[tostring(Passport)] then
		if not Level or not (Datatable[tostring(Passport)] > Level) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasGroup(Passport, Permission, Level)
	if Groups[Permission] then
		for k,v in pairs(Groups[Permission]["Parent"]) do
			local Datatable = vRP.GetServerData("Permissions:"..k)
			if Datatable[tostring(Passport)] then
				if not Level or not (Datatable[tostring(Passport)] > Level) then
					return true
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasService(Passport, Permission)
	if Groups[Permission] then
		for k,v in pairs(Groups[Permission]["Parent"]) do
			if Groups[k]["Service"][tostring(Passport)] then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Salary:Update")
AddEventHandler("Salary:Update",function(Passport, Amount)
	local Source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		if HensaTable["Salary"] ~= nil then
			HensaTable["Salary"] = HensaTable["Salary"] + parseInt(Amount)
		else
			HensaTable["Salary"] = parseInt(Amount)
		end

		TriggerClientEvent("Notify", Source, "amarelo", "Você recebeu <b>$"..parseFormat(Amount).."</b> "..itemName(DefaultDollars1)..".", "Atenção", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLESALARYCOOLDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
local SalaryCooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:VERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Salary:Verify")
AddEventHandler("Salary:Verify",function()
	local Source = source
	local Passport = vRP.Passport(Source)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		if HensaTable["Salary"] ~= nil then
			TriggerClientEvent("Notify", Source, "default", "Seu saldo é de: <b>$"..parseFormat(HensaTable["Salary"]).."</b> "..itemName(DefaultDollars1)..".", "Conta Salário", 5000)
		else
			TriggerClientEvent("Notify", Source, "default", "Seu saldo é de: <b>$0</b> "..itemName(DefaultDollars1)..".", "Conta Salário", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:VERIFYSPECIAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Salary:VerifySpecial")
AddEventHandler("Salary:VerifySpecial",function()
	local Source = source
	local Passport = vRP.Passport(Source)
	if Passport then
		if vRP.UserGemstone(Characters[Source]["License"]) > 0 then
			TriggerClientEvent("Notify", Source, "default", "Seu saldo especial é de: <b>"..parseFormat(vRP.UserGemstone(Characters[Source]["License"])).."x</b> "..itemName(DefaultSpecialMoney)..".", "Conta Salário Especial", 5000)
		else
			TriggerClientEvent("Notify", Source, "default", "Seu saldo especial é de: <b>0x</b> "..itemName(DefaultSpecialMoney)..".", "Conta Salário Especial", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:RECEIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Salary:Receive")
AddEventHandler("Salary:Receive",function()
	local Source = source
	local Passport = vRP.Passport(Source)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		if (not SalaryCooldown[Passport] or os.time() > SalaryCooldown[Passport]) then
			if HensaTable["Salary"] ~= nil then
				if vRP.Request(source, "Banco Central", "Você realmente deseja sacar <b>$"..parseFormat(HensaTable["Salary"]).."</b> "..itemName(DefaultDollars1).."?") then
					exports["vrp"]:Embed("Salary","**Passaporte:** "..Passport.."\n**Sacou de salário:** "..parseFormat(HensaTable["Salary"]), 0xa3c846)

					TriggerClientEvent("Notify", Source, "verde", "Você efetuou o saque de <b>$"..parseFormat(HensaTable["Salary"]).."</b> "..itemName(DefaultDollars1)..".", "Sucesso", 5000)
					vRP.GiveBank(Passport, HensaTable["Salary"])
					SalaryCooldown[Passport] = os.time() + 60
					HensaTable["Salary"] = nil
				end
			else
				TriggerClientEvent("Notify", Source, "vermelho", "Você não possuí valores para sacar.", "Aviso", 5000)
			end
		else
			local Cooldown = MinimalTimers(SalaryCooldown[Passport] - os.time())
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Salary:Add", function(Passport, Permission)
	if not Salary[Permission] then
		Salary[Permission] = {}
	end

	if not Salary[Permission][Passport] then
		Salary[Permission][Passport] = os.time() + SalarySeconds
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Salary:Remove", function(Passport, Permission)
	if Permission then
		if Salary[Permission] and Salary[Permission][Passport] then
			Salary[Permission][Passport] = nil
		end
	else
		for k,v in pairs(Salary) do
			if Salary[k][Passport] then
				Salary[k][Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(60000)

		local Users = vRP.Players()
		local ActualTime = os.time()
		for Index,Source in pairs(Users) do
			local Passport = vRP.Passport(Source)
			if Passport then
				for Group,SourceAndTime in pairs(Salary) do
					if Salary[Group][Passport] then
						if Salary[Group][Passport] <= ActualTime then
							local Hensa = vRP.GetUserHierarchy(Passport, Group)
							if Hensa then
								local GroupSalary = vRP.GetGroupSalary(Group, Hensa)
								if GroupSalary then
									if Groups[Group]["Type"] == "Work" then
										if vRP.HasService(Passport, Group) then
											TriggerEvent("Salary:Update", Passport, GroupSalary)
											Salary[Group][Passport] = os.time() + SalarySeconds
										end
									else
										TriggerEvent("Salary:Update", Passport, GroupSalary)
										Salary[Group][Passport] = os.time() + SalarySeconds
									end
								end
							end
						end
					else
						Salary[Group][Passport] = os.time() + SalarySeconds
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKOUT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Blackout()
	if GlobalState["Blackout"] then
		SetTimeout(BlackoutTime, function()
			GlobalState["Blackout"] = false
			TriggerClientEvent("Notify", -1, "azul", BlackoutText, "Central de Eletricidade", 10000)
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, Source)
	for k,v in pairs(Groups) do
		local Datatable = vRP.GetServerData("Permissions:"..k)
		if Datatable[tostring(Passport)] then
			if Groups[k]["Service"] then
				vRP.ServiceToggle(Source, Passport, k, true)
			end

			if Groups[k]["Salary"] then
				TriggerEvent("Salary:Add", tostring(Passport), k)
			end

			if vRP.HasGroup(Passport, "Admin") then
				Player(Source)["state"]["Admin"] = true
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport, Source)
	if Party["Users"][Passport] then
		if Party["Room"][Party["Users"][Passport]] and Party["Room"][Party["Users"][Passport]][Passport] then
			Party["Room"][Party["Users"][Passport]][Passport] = nil

			if #Party["Room"][Party["Users"][Passport]] <= 0 then
				Party["Room"][Party["Users"][Passport]] = nil
			end
		end

		Party["Users"][Passport] = nil
	end

	for k,v in pairs(Groups) do
		if Groups[k]["Service"][tostring(Passport)] then
			if GroupBlips[k] then
				exports["markers"]:Exit(Source)
			end

			Groups[k]["Service"][tostring(Passport)] = false
		end

		if Groups[k] and Groups[k]["Salary"] then
			TriggerEvent("Salary:Remove", tostring(Passport), k)
		end

		if vRP.HasGroup(Passport, "Admin") then
			Player(Source)["state"]["Admin"] = false
		end
	end

	TriggerEvent("DebugObjects", Passport)
	TriggerEvent("DebugWeapons", Passport)

	for k,v in pairs(Salary) do
		if Salary[k][Passport] then
			Salary[k][Passport] = nil
		end
	end
end)