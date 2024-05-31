-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	["weedsack"] = {
		["Price"] = { ["Min"] = 400, ["Max"] = 450 },
		["Amount"] = { ["Min"] = 1, ["Max"] = 4 }
	},
	["cokesack"] = {
		["Price"] = { ["Min"] = 400, ["Max"] = 450 },
		["Amount"] = { ["Min"] = 1, ["Max"] = 4 }
	},
	["methsack"] = {
		["Price"] = { ["Min"] = 1250, ["Max"] = 1500 },
		["Amount"] = { ["Min"] = 1, ["Max"] = 4 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckDrugs()
	local Return = false
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		for Item,v in pairs(List) do
			local Price = math.random(v["Price"]["Min"],v["Price"]["Max"])
			local Amount = math.random(v["Amount"]["Min"],v["Amount"]["Max"])

			if vRP.ConsultItem(Passport,Item,Amount) then
				Drugs[Passport] = { Item,Amount,Price * Amount }
				Return = true

				break
			end
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PaymentDrugs()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Drugs[Passport] and vRP.TakeItem(Passport,Drugs[Passport][1],Drugs[Passport][2]) then
		Active[Passport] = true

		local Valuation = Drugs[Passport][3]
		if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		for k,v in pairs(DrugsInfluences) do
			local Distance = #(Coords - vec3(v[1],v[2],v[3]))
			if Distance <= v[4] then
				Valuation = Valuation + (Valuation * 0.1)

				local RandomExtra = math.random(85, 115)
				if vRP.HasPermission(Passport, "Ballas") then
					vRP.GangBank("Add", RandomExtra, "Ballas")
				elseif vRP.HasPermission(Passport, "Families") then
					vRP.GangBank("Add", RandomExtra, "Families")
				elseif vRP.HasPermission(Passport, "Vagos") then
					vRP.GangBank("Add", RandomExtra, "Vagos")
				elseif vRP.HasPermission(Passport, "Aztecas") then
					vRP.GangBank("Add", RandomExtra, "Aztecas")
				elseif vRP.HasPermission(Passport, "Bloods") then
					vRP.GangBank("Add", RandomExtra, "Bloods")
				end

				TriggerEvent("Wanted", source, Passport, 60)
				TriggerEvent("inventory:BuffServer", source, Passport, "Luck", 300)

				TriggerClientEvent("Notify", source, "amarelo", "Adicionado <b>$"..parseFormat(RandomExtra).."</b> ao cofre de seu grupo.", "Atenção", 5000)
				TriggerClientEvent("Notify", source, "verde", "Você recebeu um <b>Bônus</b> pela <b>Área</b>.", "Sucesso", 5000)

				local Coords = vRP.GetEntityCoords(source)
				local Service = vRP.NumPermission("Policia")
				for Passports,Sources in pairs(Service) do
					async(function()
						TriggerClientEvent("sounds:Private",Sources,"crime",0.25)
						TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Venda de Drogas", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", color = 16 })
					end)
				end
			end
		end

		TriggerClientEvent("player:Residuals",source,"Resíduo Orgânico.")
		vRP.GenerateItem(Passport,"dollars2",Valuation,true)

		if math.random(100) >= 90 then
			TriggerEvent("Wanted",source,Passport,60)

			local Coords = vRP.GetEntityCoords(source)
			local Service = vRP.NumPermission("Policia")
			for Passports,Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("sounds:Private",Sources,"crime",0.25)
					TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Venda de Drogas", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", color = 16 })
				end)
			end
		end

		Active[Passport] = nil
		Drugs[Passport] = nil
	end
end