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
Tunnel.bindInterface("pdm", Hensa)
vCLIENT = Tunnel.getInterface("pdm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local PlateVeh = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Cars"] = {}
GlobalState["Bikes"] = {}
GlobalState["Rental"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Cars = {}
	local Bikes = {}
	local Rental = {}
	local Vehicles = VehicleGlobal()

	for Index, v in pairs(Vehicles) do
		if v["Mode"] == "Cars" then
			Cars[#Cars + 1] = {
				k = Index,
				name = v["Name"],
				price = v["Price"],
				chest = v["Weight"],
				tax = v["Price"] * 0.10
			}
		elseif v["Mode"] == "Bikes" then
			Bikes[#Bikes + 1] = {
				k = Index,
				name = v["Name"],
				price = v["Price"],
				chest = v["Weight"],
				tax = v["Price"] * 0.10
			}
		elseif v["Mode"] == "Rental" then
			Rental[#Rental + 1] = {
				k = Index,
				name = v["Name"],
				price = v["Gemstone"],
				chest = v["Weight"],
				tax = v["Price"] * 0.10
			}
		end
	end

	GlobalState:set("Cars", Cars, true)
	GlobalState:set("Bikes", Bikes, true)
	GlobalState:set("Rental", Rental, true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Buy(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

			if not VehicleMode(Name) then
				Active[Passport] = nil
				return
			end

			local Vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
			if Vehicle[1] then
				TriggerClientEvent("Notify", source, "amarelo", "Você já possui um <b>" .. VehicleName(Name) .. "</b>.", "Atenção", 5000)
				Active[Passport] = nil
				return
			else
				if VehicleMode(Name) == "Rental" or VehicleMode(Name) == "Exclusivos" then
					if vRP.Request(source, "Concessionária", "Alugar o veículo <b>" .. VehicleName(Name) .. "</b> por <b>" .. parseFormat(VehicleGemstone(Name)) .. " Diamantes</b>?") then
						if vRP.TakeItem(Passport, "rentalveh", 1, true) or vRP.PaymentGems(Passport, VehicleGemstone(Name)) then
							local Rental = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Name })
							if Rental[1] then
								if Rental[1]["rental"] <= os.time() then
									vRP.Query("vehicles/rentalVehiclesUpdate", { Passport = Passport, vehicle = Name })
									TriggerClientEvent("Notify", source, "verde", "Aluguel do veículo <b>" .. VehicleName(Name) .. "</b> atualizado.", "Sucesso", 5000)
								else
									vRP.Query("vehicles/rentalVehiclesDays", { Passport = Passport, vehicle = Name })
									TriggerClientEvent("Notify", source, "amarelo", "Adicionado <b>30 Dias</b> de aluguel no veículo <b>" .. VehicleName(Name) .. "</b>.", "Atenção", 5000)
								end
							else
								vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "false" })
								TriggerClientEvent("Notify", source, "verde", "Aluguel do veículo <b>" .. VehicleName(Name) .. "</b> concluído.", "Sucesso", 5000)
							end
						else
							TriggerClientEvent("Notify", source, "vermelho", "<b>Diamantes</b> insuficientes.", "Aviso", 5000)
						end
					end
				elseif VehicleMode(Name) == "Work" then
					if vRP.Request(source, "Concessionária", "Comprar <b>" .. VehicleName(Name) .. "</b> por <b>$" .. parseFormat(VehiclePrice) .. "</b> Dólares?") then
						if vRP.PaymentFull(Passport, VehiclePrice(Name)) then
							vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
							TriggerClientEvent("Notify", source, "verde", "Compra concluída.", "Sucesso", 5000)
						end
					end
				else
					local VehiclePrice = VehiclePrice(Name)
					if vRP.Request(source, "Concessionária", "Comprar <b>" .. VehicleName(Name) .. "</b> por <b>$" .. parseFormat(VehiclePrice) .. "</b> Dólares?") then
						if vRP.PaymentFull(Passport, VehiclePrice) then
							vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "false" })
							TriggerClientEvent("Notify", source, "verde", "Compra concluída.", "Sucesso", 5000)
						end
					end
				end
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Check()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

			if vRP.HasGroup(Passport, "Premium") then
				if vRP.Request(source, "Concessionária", "Iniciar o teste?") then
					PlateVeh[Passport] = "PDMSPORT"
					TriggerEvent("plateEveryone", PlateVeh[Passport])

					Player(source)["state"]["Route"] = Passport
					SetPlayerRoutingBucket(source, Passport)

					Active[Passport] = nil

					return true
				end
			else
				if vRP.Request(source, "Concessionária", "Iniciar o teste por <b>$100</b> Dólares?") then
					if vRP.PaymentFull(Passport, 100) then
						PlateVeh[Passport] = "PDMSPORT"
						TriggerEvent("plateEveryone", PlateVeh[Passport])

						Player(source)["state"]["Route"] = Passport
						SetPlayerRoutingBucket(source, Passport)

						Active[Passport] = nil

						return true
					end
				end
			end

			Active[Passport] = nil
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Remove()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("plateReveryone", PlateVeh[Passport])

		Player(source)["state"]["Route"] = 0
		SetPlayerRoutingBucket(source, 0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end

	if PlateVeh[Passport] then
		PlateVeh[Passport] = nil
	end
end)