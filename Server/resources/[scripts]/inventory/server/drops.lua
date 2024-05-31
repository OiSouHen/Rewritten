-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Amounts = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTICK
-----------------------------------------------------------------------------------------------------------------------------------------
local function ThreadTick()
	for Route,Table in pairs(Drops) do
		for Number,v in pairs(Table) do
			if Drops[Route] and Drops[Route][Number] and os.time() >= v["Timer"] then
				TriggerClientEvent("inventory:DropsRemover",-1,Route,Number)
				Drops[Route][Number] = nil
			end
		end
	end

	SetTimeout(60000,ThreadTick)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTICKINIT
-----------------------------------------------------------------------------------------------------------------------------------------
ThreadTick()
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Drops(Item,Slot,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	local Route = GetPlayerRoutingBucket(source)
	if Passport and not Active[Passport] and Amount > 0 and not itemBlock(Item) and not BlockDrops(Item) and not Player(source)["state"]["Handcuff"] and not exports["hud"]:Wanted(Passport) and not vRPC.InsideVehicle(source) then
		Active[Passport] = true

		if vRP.CheckDamaged(Item) then
			TriggerClientEvent("Notify", source, "amarelo", "Utilize as <b>Lixeiras</b> para jogar itens vencidos.", "Atenção", 5000)
			TriggerClientEvent("inventory:Update",source,"Backpack")
			Active[Passport] = nil

			return false
		end

		if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
			Amounts = Amounts + 1

			if not Drops[Route] then
				Drops[Route] = {}
			end

			local Number = tostring(Amounts)
			Drops[Route][Number] = {
				["Key"] = Item,
				["Route"] = Route,
				["Amount"] = Amount,
				["Id"] = Number,
				["Peso"] = itemWeight(Item),
				["Index"] = itemIndex(Item),
				["Name"] = itemName(Item),
				["Coords"] = vCLIENT.EntityCoordsZ(source),
				["Timer"] = os.time() + 600
			}

			TriggerClientEvent("inventory:DropsAdicionar",-1,Route,Number,Drops[Route][Number])
			TriggerClientEvent("inventory:Update",source,"Backpack")
		end

		Active[Passport] = nil
	else
		TriggerClientEvent("inventory:Update",source,"Backpack")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Drops",function(Passport,source,Item,Amount)
	local Amount = parseInt(Amount,true)
	local Route = GetPlayerRoutingBucket(source)

	Amounts = Amounts + 1
	if not Drops[Route] then
		Drops[Route] = {}
	end

	local Number = tostring(Amounts)
	Drops[Route][Number] = {
		["Key"] = Item,
		["Route"] = Route,
		["Amount"] = Amount,
		["Id"] = Number,
		["Peso"] = itemWeight(Item),
		["Index"] = itemIndex(Item),
		["Name"] = itemName(Item),
		["Coords"] = vCLIENT.EntityCoordsZ(source),
		["Timer"] = os.time() + 600
	}

	TriggerClientEvent("inventory:DropsAdicionar",-1,Route,Number,Drops[Route][Number])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Pickup(Number,Route,Target,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Drops[Route] and Drops[Route][Number] and Drops[Route][Number]["Timer"] > os.time() then
		Active[Passport] = true

		if (vRP.InventoryWeight(Passport) + itemWeight(Drops[Route][Number]["Key"]) * Amount) <= vRP.GetWeight(Passport) then
			if vRP.MaxItens(Passport,Drops[Route][Number]["Key"],Amount) then
				TriggerClientEvent("Notify",source,"amarelo","Limite atingido.","Atenção",5000)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				Active[Passport] = nil

				return false
			end

			if not Drops[Route] or not Drops[Route][Number] or Drops[Route][Number]["Amount"] < Amount then
				TriggerClientEvent("inventory:Update",source,"Backpack")
				Active[Passport] = nil

				return false
			end

			local Inv = vRP.Inventory(Passport)
			if Inv[Target] then
				if Inv[Target]["item"] == Drops[Route][Number]["Key"] then
					vRP.GiveItem(Passport,Drops[Route][Number]["Key"],Amount,false,Target)
				end
			else
				vRP.GiveItem(Passport,Drops[Route][Number]["Key"],Amount,false,Target)
			end

			Drops[Route][Number]["Amount"] = Drops[Route][Number]["Amount"] - Amount
			if Drops[Route][Number]["Amount"] <= 0 then
				TriggerClientEvent("inventory:DropsRemover",-1,Route,Number)
				Drops[Route][Number] = nil
			else
				TriggerClientEvent("inventory:DropsAtualizar",-1,Route,Number,Drops[Route][Number]["Amount"])
			end

			TriggerClientEvent("inventory:Update",source,"Backpack")
		else
			TriggerClientEvent("inventory:Update",source,"Backpack")
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
		end

		Active[Passport] = nil
	else
		TriggerClientEvent("inventory:Update",source,"Backpack")
	end
end