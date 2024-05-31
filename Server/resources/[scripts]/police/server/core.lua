-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("police", Hensa)
vCLIENT = Tunnel.getInterface("police")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Impound = {}
local Reduces = {}
local PlateSave = {}
local Announces = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.InitPrison(OtherPassport, services, fines, text)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil then
			Active[Passport] = true

			local Identity = vRP.Identity(Passport)
			if Identity then
				local OtherPlayer = vRP.Source(OtherPassport)
				if OtherPlayer then
					vCLIENT.Sync(OtherPlayer,true,true)
					vRP.ChangeMode(OtherPassport,"Ilegal")
					Player(OtherPlayer)["state"]["Prison"] = true
					TriggerClientEvent("radio:RadioClean", OtherPlayer)
					exports["markers"]:Enter(OtherPlayer,"Prisioneiro")
					TriggerClientEvent("Notify",OtherPlayer,"amarelo","As lixeiras do pátio estão disponíveis para <b>vasculhar</b> em troca de redução penal.","Sistema Penitenciário",10000)

					if Player(OtherPlayer)["state"]["Handcuff"] then
						Player(OtherPlayer)["state"]["Handcuff"] = false
						Player(OtherPlayer)["state"]["Commands"] = false
					end
				end

				vRP.Query("prison/InsertPrison",{ Officer = vRP.FullName(Passport), OtherPassport = parseInt(OtherPassport), Services = services, Fines = fines, About = text, Time = os.date("%d/%m/%Y").." ás "..os.date("%H:%M") })
				TriggerClientEvent("Notify", source, "verde", "Prisão efetuada.", "Sucesso", 5000)
				TriggerClientEvent("police:Update", source, "reloadPrison")
				vRP.InitPrison(OtherPassport, services)

				if fines > 0 then
					vRP.GiveFine(OtherPassport,fines)
					exports["bank"]:AddFines(Passport,OtherPassport,fines,text)

					if NewBankTaxs then
						exports["bank"]:AddTaxs(OtherPassport,"Prefeitura",fines,"Sistema Penitenciário.")
					end
				end

				exports["vrp"]:Embed("Prison","**Por:** "..parseFormat(Passport).."\n**Passaporte:** "..parseFormat(OtherPassport).."\n**Serviços:** "..parseFormat(services).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,3092790)
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PRISONCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:prisonClothes")
AddEventHandler("police:prisonClothes",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		local Model = vRP.ModelPlayer(Entity[1])
		if Model == "mp_m_freemode_01" or Model == "mp_f_freemode_01" then
			TriggerClientEvent("skinshop:Apply", Entity[1], Preset[Model])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.SearchUser(OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Identity(OtherPassport)
		if Identity then
			local Fines = vRP.GetFine(OtherPassport)
			local Records = vRP.Query("prison/GetRecords",{ OtherPassport = parseInt(OtherPassport) })

			return { true, vRP.FullName(OtherPassport), Identity["Phone"], Fines, Records, Identity["Gun"] }
		end
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.InitFine(OtherPassport, fines, text)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and fines > 0 then
		if Active[Passport] == nil then
			Active[Passport] = true

			exports["vrp"]:Embed("Prison","**Por:** "..parseFormat(Passport).."\n**Passaporte:** "..parseFormat(OtherPassport).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").. "\n**Motivo:** "..text,3092790)
			TriggerClientEvent("Notify", source, "verde", "Multa aplicada.", "Sucesso", 5000)
			TriggerClientEvent("police:Update", source, "reloadFine")
			vRP.GiveFine(OtherPassport, fines)

			if NewBank then
				exports["bank"]:AddFines(Passport, OtherPassport, fines, text)
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Announce(Title, Seconds, Text)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Seconds > 0 then
		if (not Announces[Passport] or os.time() > Announces[Passport]) then
			if Active[Passport] == nil then
				Active[Passport] = true

				exports["vrp"]:Embed("Prison","**Por:** "..parseFormat(Passport).."\nHorário:** "..os.date("%H:%M:%S").. "\n**Anúncio:** "..Text,3092790)
				TriggerClientEvent("Notify", -1, "policia", Text, Title, Seconds * 1000)
				TriggerClientEvent("police:Update", source, "reloadAnnounce")
				Announces[Passport] = os.time() + 300

				Active[Passport] = nil
			end
		else
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..MinimalTimers(parseInt(Announces[Passport] - os.time())).."</b>.",false,5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.UpdatePort(OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local PortStatus = "Desativado"
		local OtherPassport = parseInt(OtherPassport)
		local Identity = vRP.Identity(OtherPassport)

		if parseInt(Identity["Gun"]) == 0 then
			PortStatus = "Ativado"
			vRP.UpdateGunlicense(OtherPassport, 1)
		else
			vRP.UpdateGunlicense(OtherPassport, 0)
		end

		TriggerClientEvent("Notify",source,"verde","Porte atualizado.","Sucesso",5000)
		TriggerClientEvent("police:Update",source,"reloadSearch",parseInt(OtherPassport))

		if NewBankTaxs then
			exports["bank"]:AddTaxs(OtherPassport,"Prefeitura",35,"Atualização de Identidade.")
		end

		exports["vrp"]:Embed("Prison","**Por:** "..parseFormat(Passport).."\n**Passaporte:** "..parseFormat(OtherPassport).."\n**Porte:** "..PortStatus.."\n**Horário:** "..os.date("%H:%M:%S"),3092790)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:REDUCES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Reduces")
AddEventHandler("police:Reduces",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Identity(Passport)
		if parseInt(Identity["Prison"]) > 0 then
			if not Reduces[Number] then
				Reduces[Number] = {}
			end

			if Reduces[Number][Passport] then
				if os.time() > Reduces[Number][Passport] then
					reduceFunction(source, Passport, Number)
				else
					TriggerClientEvent("Notify", source, "vermelho", "Nada encontrado.", "Sistema Penitenciário", 5000)
				end
			else
				reduceFunction(source, Passport, Number)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEFUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function reduceFunction(source, Passport, Number)
	vRPC.PlayAnim(source, false, { "amb@prop_human_bum_bin@base", "base" }, true)
	TriggerClientEvent("Progress", source, "Vasculhando", 10000)
	Reduces[Number][Passport] = os.time() + 600
	Player(source)["state"]["Buttons"] = true
	Player(source)["state"]["Cancel"] = true
	local timeProgress = 10

	repeat
		Wait(1000)
		timeProgress = timeProgress - 1
	until timeProgress <= 0

	local Random = math.random(#PrisonItens)
	local Amount = math.random(PrisonItens[Random]["Min"], PrisonItens[Random]["Max"])
	vRP.GenerateItem(Passport, PrisonItens[Random]["Item"], Amount, true)

	if vRP.HasGroup(Passport, "Premium") then
		vRP.UpdatePrison(Passport, source, 2)
	else
		vRP.UpdatePrison(Passport, source, 1)
	end

	Player(source)["state"]["Buttons"] = false
	Player(source)["state"]["Cancel"] = false
	vRPC.Destroy(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:SCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Scape")
AddEventHandler("police:Scape",function()
	local source = source
	local Passport = vRP.Passport(source)
	local Service,Total = vRP.NumPermission("Policia")
	if Passport then
		if Total >= 2 then
			if vRP.TakeItem(Passport,"key",1,true) then
				Player(source)["state"]["Prison"] = false

				exports["markers"]:Exit(source)
				vCLIENT.Sync(source,true,false)
				vRP.Query("characters/CleanPrison",{ Passport = Passport })

				for Passports,Sources in pairs(Service) do
					async(function()
						vRPC.PlaySound(Sources, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
						TriggerClientEvent("Notify",Sources,"amarelo","Encontramos um fugitivo da penitenciária e todos os policiais foram avisados.","Sistema Penitenciário",5000)
					end)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>1x "..itemName("key").."</b>.","Atenção",5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Contingente indisponível.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:IMPOUNDCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:ImpoundCheck")
AddEventHandler("police:ImpoundCheck",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		if not Impound[Entity[2].."-"..Entity[1]] then
			Active[Passport] = nil
			return
		else
			Impound[Entity[2].."-"..Entity[1]] = nil

			local VehRandom = 1000
			local VehParts = math.random(4)
			local VehSelected = "suspension"
			local AmountItens = math.random(4, 5)
			local Tow = vRP.GetExperience(Passport, "Tows")
			local Class = ClassCategory(Tow)

			if Class == 1 then
				VehRandom = math.random(4500)
			elseif Class == 2 then
				VehRandom = math.random(4500)
			elseif Class == 3 then
				VehRandom = math.random(4500)
			elseif Class == 4 then
				VehRandom = math.random(3500)
			elseif Class == 5 then
				VehRandom = math.random(3500)
			elseif Class == 6 then
				VehRandom = math.random(3500)
			elseif Class == 7 then
				VehRandom = math.random(2500)
			elseif Class == 8 then
				VehRandom = math.random(2500)
			elseif Class == 9 then
				VehRandom = math.random(2500)
			elseif Class == 10 then
				VehRandom = math.random(1500)
			end

			if VehParts <= 1 then
				VehSelected = "engine"
			elseif VehParts == 2 then
				VehSelected = "transmission"
			elseif VehParts == 3 then
				VehSelected = "brake"
			end

			if VehRandom <= 10 then
				vRP.GenerateItem(Passport, VehSelected .. "e", 1, true)
			elseif VehRandom >= 10 and VehRandom <= 30 then
				vRP.GenerateItem(Passport, VehSelected .. "d", 1, true)
			elseif VehRandom >= 31 and VehRandom <= 60 then
				vRP.GenerateItem(Passport, VehSelected .. "c", 1, true)
			elseif VehRandom >= 61 and VehRandom <= 100 then
				vRP.GenerateItem(Passport, VehSelected .. "b", 1, true)
			elseif VehRandom >= 101 and VehRandom <= 150 then
				vRP.GenerateItem(Passport, VehSelected .. "a", 1, true)
			end

			vRP.GenerateItem(Passport, "plastic", AmountItens, true)
			vRP.GenerateItem(Passport, "glass", AmountItens, true)
			vRP.GenerateItem(Passport, "rubber", AmountItens, true)
			vRP.GenerateItem(Passport, "copper", AmountItens, true)
			vRP.GenerateItem(Passport, "aluminum", AmountItens, true)
			vRP.PutExperience(Passport, "Tows", 1)

			TriggerClientEvent("garages:Delete", source, Entity[3])
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Impound")
AddEventHandler("police:Impound",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Impound[Entity[2].."-"..Entity[1]] then
			Impound[Entity[2].."-"..Entity[1]] = true
			TriggerEvent("inventory:CallTow", source, Entity[2], Entity[1])
			vRPC.PlaySound(source, "Event_Message_Purple", "GTAO_FM_Events_Soundset")
			TriggerClientEvent("Notify", source, "verde", "O veículo foi registrado.", "Sucesso", 5000)

			if string.sub(Entity[1], 1, 4) == "DISM" then
				local VehParts = math.random(4)
				local VehSelected = "suspension"
				local VehRandom = math.random(4500)
				local AmountItens = math.random(4, 5)

				if VehParts <= 1 then
					VehSelected = "engine"
				elseif VehParts == 2 then
					VehSelected = "transmission"
				elseif VehParts == 3 then
					VehSelected = "brake"
				end

				if VehRandom <= 10 then
					vRP.GenerateItem(Passport, VehSelected .. "e", 1, true)
				elseif VehRandom >= 10 and VehRandom <= 30 then
					vRP.GenerateItem(Passport, VehSelected .. "d", 1, true)
				elseif VehRandom >= 31 and VehRandom <= 60 then
					vRP.GenerateItem(Passport, VehSelected .. "c", 1, true)
				elseif VehRandom >= 61 and VehRandom <= 100 then
					vRP.GenerateItem(Passport, VehSelected .. "b", 1, true)
				elseif VehRandom >= 101 and VehRandom <= 150 then
					vRP.GenerateItem(Passport, VehSelected .. "a", 1, true)
				end

				vRP.GenerateItem(Passport, "plastic", AmountItens, true)
				vRP.GenerateItem(Passport, "glass", AmountItens, true)
				vRP.GenerateItem(Passport, "rubber", AmountItens, true)
				vRP.GenerateItem(Passport, "copper", AmountItens, true)
				vRP.GenerateItem(Passport, "aluminum", AmountItens, true)
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Veículo já está na lista.", "Aviso", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Plate")
AddEventHandler("police:Plate",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		runPlate(source,Entity[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RUNPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function runPlate(source, Plate)
	local Passport = vRP.PassportPlate(Plate)
	if Passport then
		local Identity = vRP.Identity(Passport["Passport"])
		vRPC.PlaySound(source, "Event_Message_Purple", "GTAO_FM_Events_Soundset")
		TriggerClientEvent("Notify",source,"azul","<b>Passaporte:</b> "..Identity["id"].."<br><b>Nome:</b> "..Identity["Name"].." "..Identity["Lastname"].."<br><b>Nº:</b> "..Identity["Phone"],false,10000)
	else
		if not PlateSave[Plate] then
			PlateSave[Plate] = { PlateName[math.random(#PlateName)].." "..PlateLastname[math.random(#PlateLastname)], vRP.GeneratePhone() }
		end

		vRPC.PlaySound(source, "Event_Message_Purple", "GTAO_FM_Events_Soundset")
		TriggerClientEvent("Notify",source,"azul","<b>Passaporte:</b> 9.999<br><b>Nome:</b> "..PlateSave[Plate][1].."<br><b>Nº:</b> "..PlateSave[Plate][2], false,10000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:ARREST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Arrest")
AddEventHandler("police:Arrest",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source, "Impound", "Apreender o veículo?") then
			local Consult = vRP.PassportPlate(Entity[1])
			if Consult then
				local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Consult["Passport"], vehicle = Entity[2] })
				if Vehicle[1] then
					if Vehicle[1]["arrest"] <= os.time() then
						vRP.Query("vehicles/arrestVehicles",{ Passport = Consult["Passport"], vehicle = Entity[2] })
						TriggerClientEvent("Notify",source,"verde","Veículo apreendido.","Sucesso",5000)
					else
						TriggerClientEvent("Notify",source,"vermelho","Veículo já se encontra apreendido.","Aviso",5000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:ARRESTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:ArrestItens")
AddEventHandler("police:ArrestItens", function(Entity)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local OtherPassport = vRP.Passport(Entity)
        if OtherPassport then
            local Inventory = vRP.Inventory(OtherPassport)
            if Inventory then
                for Slot, ItemData in pairs(Inventory) do
                    if CanArrest(ItemData.item) then
                        vRP.RemoveItem(OtherPassport, ItemData.item, ItemData.amount, ArrestNotify)
                    end
                end
            end
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport, source)
	local Identity = vRP.Identity(Passport)
	if parseInt(Identity["Prison"]) > 0 then
		Player(source)["state"]["Prison"] = true
		exports["markers"]:Enter(source,"Prisioneiro")
		TriggerClientEvent("Notify",source,"amarelo","Você ainda precisa cumprir <b>"..parseInt(Identity["Prison"]).." Serviços</b> para ter a redução penal zerada.","Sistema Penitenciário",10000)
	end

	if Active[Passport] == true then
		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end

	if Announces[Passport] then
		Announces[Passport] = nil
	end
end)