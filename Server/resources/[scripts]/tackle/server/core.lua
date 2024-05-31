-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACKLE:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tackle:Update")
AddEventHandler("tackle:Update", function(source, ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
	if vRP.Passport(source) then
		TriggerClientEvent("tackle:Player", source, ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
	end
end)
