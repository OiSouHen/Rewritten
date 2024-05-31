-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("inspect",Hensa)
vCLIENT = Tunnel.getInterface("inspect")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Players = {}
local Sourcers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:INSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Inspect")
AddEventHandler("police:Inspect",function(OtherSource)
	local source = source
	local Passport = vRP.Passport(source)
	local OtherPassport = vRP.Passport(OtherSource)
	if Passport and vRP.GetHealth(source) > 100 and not Players[OtherPassport] then
		Sourcers[Passport] = OtherSource
		Players[Passport] = OtherPassport

		TriggerEvent("inventory:ServerCarry",source,Passport,OtherSource,true)
		TriggerClientEvent("inventory:Close",OtherSource)
		TriggerClientEvent("inspect:Open",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Request()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Inventory = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			v["amount"] = parseInt(v["amount"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["name"] = itemName(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			v["desc"] = "<item>"..v["name"].."</item>"

			local Split = splitString(v["item"])
			local Description = itemDescription(v["item"])

			if Description then
				v["desc"] = v["desc"].."<br><description>"..Description.."</description>"
			else
				if Split[1] == "identity" or Split[1] == "fidentity" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)

					if Split[1] == "fidentity" then
						Identity = vRP.FalseIdentity(Number)
					end

					if Identity then
						v["Port"] = "Não"
						v["Passport"] = Number
						v["Premium"] = "Inativo"
						v["Rolepass"] = "Inativo"
						v["Name"] = vRP.FullName(Number)
						v["Work"] = ClassWork(Identity["Work"])
						v["Blood"] = Sanguine(Identity["Blood"])

						if Identity["Gun"] == 1 then
							v["Port"] = "Sim"
						end

						if Number == Passport and Split[1] == "identity" then
							if Identity["Premium"] > os.time() then
								v["Premium"] = MinimalTimers(Identity["Premium"] - os.time())
							end

							if Identity["Rolepass"] > 0 then
								v["Rolepass"] = "Ativo"
							end
						end

						if Split[1] == "fidentity" then
							v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Tipo Sangüineo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.</description>"
						else
							v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Emprego: <green>"..v["Work"].."</green><br>Tipo Sangüineo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.<br>Passe Mensal: <green>"..v["Rolepass"].."</green>.<br>Premium: <green>"..v["Premium"].."</green>.</description>"
						end
					end
				end

				if Split[1] == "cnh" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)
					if Identity then
						v["Passport"] = Number
						v["Driverlicense"] = "Inativa"
						v["Name"] = Identity["Name"].." "..Identity["Lastname"]

						if Number == Passport then
							if Identity["Driver"] == 1 then
								v["Driverlicense"] = "Ativa"
							elseif Identity["Driver"] == 2 then
								v["Driverlicense"] = "Apreendida"
							end
						end

						v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Habilitação: <green>"..v["Driverlicense"].."</green>.</description>"
					end
				end

				if Split[1] == "vehkey" then
					v["desc"] = v["desc"].."<br><description>Placa do Veículo: <green>"..Split[2].."</green>.</description>"
				end

				if Split[1] == "bankcard" then
					v["desc"] = v["desc"].."<br><description>Saldo bancário disponível: <green>$"..parseFormat(vRP.GetBank(source)).."</green>.</description>"
				end

				if Split[1] == "notepad" and Split[2] then
					v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
				end

				if Split[1] == "paper" and Split[2] then
					v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
				end

				if itemType(Split[1]) == "Armamento" and Split[3] then
					v["desc"] = v["desc"].."<br><description>Nome de registro: <green>"..vRP.FullName(Split[3]).."</green>.</description>"
				end

				if Split[1] == "evidence01" or Split[1] == "evidence02" or Split[1] == "evidence03" or Split[1] == "evidence04" and Split[2] then
					v["desc"] = v["desc"].."<br><description>Tipo sanguíneo encontrado: <green>"..Sanguine(vRP.Identity(Split[2])["Blood"]).."</green>.</description>"
				end

				if Split[1] == "weedclone" or Split[1] == "weedclone2" or Split[1] == "weedbud" or Split[1] == "joint" then
					local Item = "da clonagem"
					if Split[1] == "weedbud" then
						Item = "da folha"
					elseif Split[1] == "joint" then
						Item = "do baseado"
					end

					v["desc"] = v["desc"].."<br><description>A pureza "..Item.." se encontra em <green>"..(Split[2] or 0).."%</green>.</description>"
				end
			end

			local Max = itemMaxAmount(v["item"])
			if not Max then
				Max = "S/L"
			end

			v["desc"] = v["desc"].."<br><legenda>Economia: <r>"..itemEconomy(v["item"]).."</r> <s>|</s> Máximo: <r>"..Max.."</r></legenda>"

			if Split[2] then
				if itemCharges(v["item"]) then
					v["charges"] = parseInt(Split[2] * 33)
				end

				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				end
			end

			Inventory[Index] = v
		end

		local Chest = {}
		local Inv = vRP.Inventory(Players[Passport])
		for Index,v in pairs(Inv) do
			v["amount"] = parseInt(v["amount"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["name"] = itemName(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			v["desc"] = "<item>"..v["name"].."</item>"

			local Split = splitString(v["item"])
			local Description = itemDescription(v["item"])

			if Description then
				v["desc"] = v["desc"].."<br><description>"..Description.."</description>"
			else
				if Split[1] == "identity" or Split[1] == "fidentity" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)

					if Split[1] == "fidentity" then
						Identity = vRP.FalseIdentity(Number)
					end

					if Identity then
						v["Port"] = "Não"
						v["Passport"] = Number
						v["Premium"] = "Inativo"
						v["Rolepass"] = "Inativo"
						v["Name"] = vRP.FullName(Number)
						v["Work"] = ClassWork(Identity["Work"])
						v["Blood"] = Sanguine(Identity["Blood"])

						if Identity["Gun"] == 1 then
							v["Port"] = "Sim"
						end

						if Number == Passport and Split[1] == "identity" then
							if Identity["Premium"] > os.time() then
								v["Premium"] = MinimalTimers(Identity["Premium"] - os.time())
							end

							if Identity["Rolepass"] > 0 then
								v["Rolepass"] = "Ativo"
							end
						end

						if Split[1] == "fidentity" then
							v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Tipo Sangüineo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.</description>"
						else
							v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Emprego: <green>"..v["Work"].."</green><br>Tipo Sangüineo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.<br>Passe Mensal: <green>"..v["Rolepass"].."</green>.<br>Premium: <green>"..v["Premium"].."</green>.</description>"
						end
					end
				end

				if Split[1] == "cnh" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)
					if Identity then
						v["Passport"] = Number
						v["Driverlicense"] = "Inativa"
						v["Name"] = Identity["Name"].." "..Identity["Lastname"]

						if Number == Passport then
							if Identity["Driver"] == 1 then
								v["Driverlicense"] = "Ativa"
							elseif Identity["Driver"] == 2 then
								v["Driverlicense"] = "Apreendida"
							end
						end

						v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Habilitação: <green>"..v["Driverlicense"].."</green>.</description>"
					end
				end

				if Split[1] == "vehkey" then
					v["desc"] = v["desc"].."<br><description>Placa do Veículo: <green>"..Split[2].."</green>.</description>"
				end

				if Split[1] == "bankcard" then
					v["desc"] = v["desc"].."<br><description>Saldo bancário disponível: <green>$"..parseFormat(vRP.GetBank(source)).."</green>.</description>"
				end

				if Split[1] == "notepad" and Split[2] then
					v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
				end

				if Split[1] == "paper" and Split[2] then
					v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
				end

				if itemType(Split[1]) == "Armamento" and Split[3] then
					v["desc"] = v["desc"].."<br><description>Nome de registro: <green>"..vRP.FullName(Split[3]).."</green>.</description>"
				end

				if Split[1] == "evidence01" or Split[1] == "evidence02" or Split[1] == "evidence03" or Split[1] == "evidence04" and Split[2] then
					v["desc"] = v["desc"].."<br><description>Tipo sanguíneo encontrado: <green>"..Sanguine(vRP.Identity(Split[2])["Blood"]).."</green>.</description>"
				end

				if Split[1] == "weedclone" or Split[1] == "weedclone2" or Split[1] == "weedbud" or Split[1] == "joint" then
					local Item = "da clonagem"
					if Split[1] == "weedbud" then
						Item = "da folha"
					elseif Split[1] == "joint" then
						Item = "do baseado"
					end

					v["desc"] = v["desc"].."<br><description>A pureza "..Item.." se encontra em <green>"..(Split[2] or 0).."%</green>.</description>"
				end
			end

			local Max = itemMaxAmount(v["item"])
			if not Max then
				Max = "S/L"
			end

			v["desc"] = v["desc"].."<br><legenda>Economia: <r>"..itemEconomy(v["item"]).."</r> <s>|</s> Máximo: <r>"..Max.."</r></legenda>"

			if Split[2] then
				if itemCharges(v["item"]) then
					v["charges"] = parseInt(Split[2] * 33)
				end

				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				end
			end

			Chest[Index] = v
		end

		return Inventory,Chest,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.InventoryWeight(Players[Passport]),vRP.GetWeight(Players[Passport])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Reset()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Sourcers[Passport] then
			TriggerEvent("inventory:ServerCarry",source,Passport,Sourcers[Passport])

			Sourcers[Passport] = nil
		end

		if Players[Passport] then
			Players[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Store(Item,Amount,Target)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Sourcers[Passport] then
		if vRP.MaxItens(Players[Passport],Item,Amount) then
			TriggerClientEvent("Notify",source,"vermelho","Limite atingido.","Aviso",5000)
			TriggerClientEvent("inspect:Update",source,"Request")

			return false
		end

		if (vRP.InventoryWeight(Players[Passport]) + itemWeight(Item) * Amount) <= vRP.GetWeight(Players[Passport]) then
			if vRP.TakeItem(Passport,Item,Amount,true) then
				vRP.GiveItem(Players[Passport],Item,Amount,true,Target)
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
			TriggerClientEvent("inspect:Update",source,"Request")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Take(Item,Target,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Sourcers[Passport] then
		if vRP.MaxItens(Passport,Item,Amount) then
			TriggerClientEvent("Notify",source,"vermelho","Limite atingido.","Aviso",5000)
			TriggerClientEvent("inspect:Update",source,"Request")

			return false
		end

		if (vRP.InventoryWeight(Passport) + itemWeight(Item) * Amount) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Players[Passport],Item,Amount,true) then
				vRP.GiveItem(Passport,Item,Amount,true,Target)
				TriggerClientEvent("inspect:Update",source,"Request")
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
			TriggerClientEvent("inspect:Update",source,"Request")
		end
	end
end