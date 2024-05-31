-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local MaxWeight = 120
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKGYM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckGym()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.GetWeight(Passport) >= MaxWeight then
			TriggerClientEvent("Notify", source, "vermelho", "Você atingiu o seu máximo.", "Aviso", 5000)

			return false
		else
			vRPC.AnimActive(source)

			Player(source)["state"]["Cancel"] = true
			Player(source)["state"]["Buttons"] = true

			TriggerClientEvent("inventory:Close", source)

			return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTGYM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.StartGym(Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.UpgradeStress(Passport, math.random(3, 6))
		vRP.DowngradeThirst(Passport, math.random(3, 6))

		local Members = exports["vrp"]:Party(Passport,source,5)
		if parseInt(#Members) >= 2 then
			for _,v in pairs(Members) do
				if vRP.Passport(v["Source"]) then
					if vRP.GetWeight(v["Passport"]) >= MaxWeight then
						TriggerClientEvent("Notify", v["Source"], "vermelho", "Você atingiu o seu máximo.", "Aviso", 5000)
					else
						vRP.SetWeight(v["Passport"], Amount * 2)
						TriggerClientEvent("Notify", v["Source"], "verde", "Você conseguiu <b>+ "..parseFormat(Amount * 2).."Kg</b>.", "Sucesso", 5000)
					end
				end
			end
		else
			if vRP.GetWeight(Passport) >= MaxWeight then
				TriggerClientEvent("Notify", source, "vermelho", "Você atingiu o seu máximo.", "Aviso", 5000)
			else
				vRP.SetWeight(Passport, Amount)
				TriggerClientEvent("Notify", source, "verde", "Você conseguiu <b>+ "..parseFormat(Amount).."Kg</b>.", "Sucesso", 5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPGYM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.StopGym()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRPC.Destroy(source)
		vRPC.Destroy(source, "one")

		Player(source)["state"]["Cancel"] = false
		Player(source)["state"]["Buttons"] = false
	end
end