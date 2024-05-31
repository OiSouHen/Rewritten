-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOUGH
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.GetCough(Value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local ClosestPed = vRPC.ClosestPed(source, 3)
		if ClosestPed then
			local OtherPassport = vRP.Passport(ClosestPed)
			if OtherPassport then
				if vRP.GetHealth(ClosestPed) > 100 then
					vRP.UpgradeCough(OtherPassport, Value)
				end
			end
		end
	end
end