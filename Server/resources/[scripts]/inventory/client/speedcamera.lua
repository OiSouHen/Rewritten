-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local FinalPrice = 0
local DefaultPrice = 0
local HasCaught = false
local ExtraPrice = true
local EnableBlips = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFAULTPRICES
-----------------------------------------------------------------------------------------------------------------------------------------
local DefaultPrice60 = 100
local DefaultPrice80 = 300
local DefaultPrice120 = 500
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAPRICES
-----------------------------------------------------------------------------------------------------------------------------------------
local ExtraPrice10 = 125
local ExtraPrice20 = 595
local ExtraPrice30 = 1145
-----------------------------------------------------------------------------------------------------------------------------------------
-- AREAS60
-----------------------------------------------------------------------------------------------------------------------------------------
local Areas60 = {
	{ X = -521.92, Y = -1770.01, Z = 21.42 },
	{ X = -638.7, Y = -837.08, Z = 24.42 },
	{ X = -632.22, Y = -373.37, Z = 34.31 },
	{ X = -227.22, Y = -1003.37, Z = 28.83 },
	{ X = 154.36, Y = -1019.31, Z = 28.88 },
	{ X = 774.04, Y = -743.38, Z = 26.96 },
	{ X = 145.67, Y = -1614.32, Z = 28.83 },
	{ X = 945.37, Y = -1935.09, Z = 30.46 },
	{ X = 73.64, Y = -164.13, Z = 54.61 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AREAS80
-----------------------------------------------------------------------------------------------------------------------------------------
local Areas80 = {
	{ X = 348.72, Y = -1921.64, Z = 24.2 },
	{ X = 1280.27, Y = -1504.25, Z = 40.05 },
	{ X = 2578.46, Y = 4245.33, Z = 41.8 },
	{ X = -1468.19, Y = -104.2, Z = 50.36 },
	{ X = -441.11, Y = 244.36, Z = 82.58 },
	{ X = 310.92, Y = 155.6, Z = 103.32 },
	{ X = 394.65, Y = -592.25, Z = 28.27 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AREAS120
-----------------------------------------------------------------------------------------------------------------------------------------
local Areas120 = {
	{ X = 1578.62, Y = -980.07, Z = 60.09 },
	{ X = 2134.19, Y = -572.18, Z = 95.1 },
	{ X = 714.88, Y = 6511.94, Z = 27.41 },
	{ X = -2690.74, Y = -39.01, Z = 15.3 },
	{ X = -2658.32, Y = 2632.84, Z = 16.68 },
	{ X = 2559.33, Y = 5399.29, Z = 44.21 },
	{ X = 2654.56, Y = 4938.91, Z = 44.4 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSPEEDCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999

		local function CheckSpeedArea(Areas, MaxSpeed, DefaultPrice)
			for _, area in ipairs(Areas) do
				local playerCoords = GetEntityCoords(PlayerPedId(), false)
				local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, area.X, area.Y, area.Z)

				if distance <= 20 then
					local Ped = PlayerPedId()
					local Vehicle = GetVehiclePedIsIn(Ped, false)
					local VehiclePlate = GetVehicleNumberPlateText(Vehicle)
					local Speed = GetEntitySpeed(Ped) * 2.236936

					if Speed > MaxSpeed and IsPedInAnyVehicle(Ped, false) and GetPedInVehicleSeat(Vehicle, -1) == Ped then
						if not HasCaught then
							local FinalPrice = DefaultPrice
							if ExtraPrice then
								if Speed >= MaxSpeed + 30 then
									FinalPrice = DefaultPrice + ExtraPrice30
								elseif Speed >= MaxSpeed + 20 then
									FinalPrice = DefaultPrice + ExtraPrice20
								elseif Speed >= MaxSpeed + 10 then
									FinalPrice = DefaultPrice + ExtraPrice10
								end
							end

							vSERVER.SpeedCameraFines(FinalPrice, Speed, GetEntityArchetypeName(Vehicle), VehiclePlate)
							HasCaught = true
							Wait(10000)
						end
					end

					HasCaught = false
				end
			end
		end

		CheckSpeedArea(Areas60, 60, DefaultPrice60)
		CheckSpeedArea(Areas80, 80, DefaultPrice80)
		CheckSpeedArea(Areas120, 120, DefaultPrice120)

		Wait(TimeDistance)
	end
end)