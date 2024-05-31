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
Tunnel.bindInterface("hud", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Work"] = 0
GlobalState["Points"] = 0
GlobalState["Hours"] = 07
GlobalState["Minutes"] = 30
-----------------------------------------------------------------------------------------------------------------------------------------
-- SOUTH
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["TemperatureS"] = 20
GlobalState["WeatherS"] = "EXTRASUNNY"
-----------------------------------------------------------------------------------------------------------------------------------------
-- NORTH
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["TemperatureN"] = 22
GlobalState["WeatherN"] = "EXTRASUNNY"
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKOUT
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Blackout"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		GlobalState["Work"] = GlobalState["Work"] + 1
		GlobalState["Points"] = GlobalState["Points"] + 1
		GlobalState["Minutes"] = GlobalState["Minutes"] + 1

		if GlobalState["Points"] >= 30 then
			if math.random(100) >= 50 then
				if GlobalState["WeatherS"] == "EXTRASUNNY" or GlobalState["WeatherS"] == "CLEAR" or GlobalState["WeatherS"] == "SMOG" or GlobalState["WeatherS"] == "CLEARING" then
					if math.random(100) >= 50 then
						GlobalState["TemperatureS"] = GlobalState["TemperatureS"] + math.random(2)
					else
						GlobalState["TemperatureS"] = GlobalState["TemperatureS"] - math.random(2)
					end
				end

				if GlobalState["WeatherN"] == "EXTRASUNNY" or GlobalState["WeatherN"] == "CLEAR" or GlobalState["WeatherN"] == "SMOG" or GlobalState["WeatherN"] == "CLEARING" or GlobalState["WeatherN"] == "NEUTRAL" then
					if math.random(100) >= 50 then
						GlobalState["TemperatureN"] = GlobalState["TemperatureN"] + math.random(2)
					else
						GlobalState["TemperatureN"] = GlobalState["TemperatureN"] - math.random(2)
					end
				end
			else
				if GlobalState["WeatherS"] == "CLOUDS" or GlobalState["WeatherS"] == "FOGGY" or GlobalState["WeatherS"] == "OVERCAST" or GlobalState["WeatherS"] == "RAIN" or GlobalState["WeatherS"] == "THUNDER" or GlobalState["WeatherS"] == "SNOW" or GlobalState["WeatherS"] == "BLIZZARD" or GlobalState["WeatherS"] == "SNOWLIGHT" or GlobalState["WeatherS"] == "XMAS" then
					if math.random(100) >= 50 then
						GlobalState["TemperatureS"] = GlobalState["TemperatureS"] - math.random(2)
					else
						GlobalState["TemperatureS"] = GlobalState["TemperatureS"] + math.random(2)
					end
				end

				if GlobalState["WeatherN"] == "CLOUDS" or GlobalState["WeatherN"] == "OVERCAST" or GlobalState["WeatherN"] == "RAIN" or GlobalState["WeatherN"] == "THUNDER" then
					if math.random(100) >= 50 then
						GlobalState["TemperatureN"] = GlobalState["TemperatureN"] - math.random(2)
					else
						GlobalState["TemperatureN"] = GlobalState["TemperatureN"] + math.random(2)
					end
				end
			end

			GlobalState["Points"] = 0
		end

		if GlobalState["Minutes"] >= 60 then
			GlobalState["Hours"] = GlobalState["Hours"] + 1
			GlobalState["Minutes"] = 0

			if GlobalState["Hours"] >= 24 then
				GlobalState["Hours"] = 0

				repeat
					RandWeatherSouth = math.random(#WeatherListS)
				until GlobalState["WeatherS"] ~= WeatherListS[RandWeatherSouth]

				GlobalState["TemperatureS"] = 18
				GlobalState["WeatherS"] = WeatherListS[RandWeatherSouth]

				repeat
					RandWeatherNorth = math.random(#WeatherListN)
				until GlobalState["WeatherN"] ~= WeatherListN[RandWeatherNorth]

				GlobalState["TemperatureN"] = 22
				GlobalState["WeatherN"] = WeatherListN[RandWeatherNorth]
			end
		end

		Wait(10000)
	end
end)