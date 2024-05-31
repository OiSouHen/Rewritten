-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("arena", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Players = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENAS
-----------------------------------------------------------------------------------------------------------------------------------------
local Arenas = {
	["1"] = {
		["Price"] = 1000,
		["Minutes"] = 10,
		["Active"] = false,
		["Timer"] = os.time(),
		["Players"] = {},
		["Money"] = 0
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKENTER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckEnter(Route, Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Arenas[Number] then
			if vRP.Request(source, "Arena Airsoft", "Prosseguir para a <b>Arena</b> pagando <b>$" .. parseFormat(Arenas[Number]["Price"]) .. "</b> Dólares?") then
				if vRP.PaymentBank(Passport, Arenas[Number]["Price"]) then
					TriggerEvent("arena:Active", Number)
					vRP.SaveTemporary(Passport, source, Route)

					if not Arenas[Number]["Active"] then
						Arenas[Number]["Active"] = true
						Arenas[Number]["Timer"] = os.time() + (Arenas[Number]["Minutes"] * 60)
					end

					if not Arenas[Number]["Players"][Passport] then
						Arenas[Number]["Players"][Passport] = {
							["Source"] = source,
							["Kills"] = 0
						}
					end

					Arenas[Number]["Money"] = Arenas[Number]["Money"] + Arenas[Number]["Price"]

					return true
				else
					TriggerClientEvent("Notify", source, "vermelho", "<b>"..itemName("dollars").."</b> insuficientes.", "Aviso", 5000)
				end
			end
		else
			vRP.SaveTemporary(Passport, source, Route)

			return true
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Active")
AddEventHandler("arena:Active", function(Number)
	if Arenas[Number] then
		if Arenas[Number]["Active"] and Arenas[Number]["Timer"] <= os.time() then
			Arenas[Number]["Active"] = false

			local Kills = 0
			local Winner = 0

			for Passport, v in pairs(Arenas[Number]["Players"]) do
				TriggerEvent("arena:Cancel", v["Source"], Passport)

				if v["Kills"] >= Kills then
					Kills = v["Kills"]
					Winner = Passport
				end
			end

			vRP.GiveBank(Winner, Arenas[Number]["Money"])
			Arenas[Number]["Players"] = {}
			Arenas[Number]["Money"] = 0
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:FEED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Feed")
AddEventHandler("arena:Feed", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Arenas[Number] then
		if Arenas[Number]["Active"] and Arenas[Number]["Players"][Passport] then
			Arenas[Number]["Players"][Passport]["Kills"] = Arenas[Number]["Players"][Passport]["Kills"] + 1
		end

		TriggerEvent("arena:Active", Number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:EXIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Exit")
AddEventHandler("arena:Exit", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("arena:Cancel", source, Passport)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Cancel")
AddEventHandler("arena:Cancel", function(source, Passport)
	local Route = GetPlayerRoutingBucket(source)

	TriggerEvent("arena:Players", "-", Route)
	TriggerClientEvent("arena:Exit", source)
	vRP.ApplyTemporary(Passport, source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Players")
AddEventHandler("arena:Players", function(Mode, Route)
	if Mode == "+" then
		if not Players[Route] then
			Players[Route] = 0
		end

		Players[Route] = Players[Route] + 1
	else
		if Players[Route] then
			Players[Route] = Players[Route] - 1

			if Players[Route] < 0 then
				Players[Route] = 0
			end
		end
	end

	TriggerClientEvent("arena:Players", -1, Route, Players[Route])
end)
