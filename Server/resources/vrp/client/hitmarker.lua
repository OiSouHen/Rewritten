-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered", function(Name, Data)
	local Sure = 0

	if HitMarker then
		if Name == "CEventNetworkEntityDamage" then
			if Health == nil then 
				Health = GetEntityMaxHealth(Data[2])
			end

			local EntitySource = Data[1]
			local Player = Data[2]
			if Player == PlayerPedId() and EntitySource ~= Player then
				if ShowNPCDamages then
					if IsPedAPlayer(Player) and GetEntityType(EntitySource) == 1 then
						repeat
							local Damage = math.ceil(Health - GetEntityHealth(EntitySource))

							if GetEntityHealth(EntitySource) >= 100 then
								DrawHitText3D(GetEntityCoords(EntitySource), Damage, 29, 108, 177)
							else
								DrawHitText3D(GetEntityCoords(EntitySource), Damage, 255, 255, 255)
							end

							Sure = Sure + 1

							Wait(1)
						until Sure > 50

						Health = GetEntityHealth(EntitySource)
					end
				else
					if IsPedAPlayer(Player) and GetEntityType(EntitySource) == 1 and IsPedAPlayer(EntitySource) then
						repeat
							local Damage = math.ceil(Health - GetEntityHealth(EntitySource))

							if GetEntityHealth(EntitySource) >= 100 then
								DrawHitText3D(GetEntityCoords(EntitySource), Damage, 29, 108, 177)
							else
								DrawHitText3D(GetEntityCoords(EntitySource), Damage, 255, 255, 255)
							end

							Sure = Sure + 1

							Wait(1)
						until Sure > 200

						Health = GetEntityHealth(EntitySource)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWHITTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawHitText3D(coords, text, r, g, b)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	if onScreen then
		SetTextOutline(1)
		SetTextScale(0.50, 0.50)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(r, g, b, 255)
		SetTextEntry("STRING")
		SetTextCentre(true)
		AddTextComponentString(text)
		DrawText(x, y)
	end
end