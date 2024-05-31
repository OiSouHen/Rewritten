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
Tunnel.bindInterface("bank", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local yield = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECKOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local next_time = GetGameTimer()
	while true do
		if os.time() >= next_time then
			next_time = os.time() + 3600
			vRP.Query("investments/Actives")
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Home()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Passport = vRP.Passport(source)
		local Check = vRP.Query("investments/Check",{ Passport = Passport })
		if Check[1] then
			yield = Check[1]["Monthly"]
		end

		local balance = vRP.Identity(Passport)["Bank"]
		local transactions = Transactions(Passport)
		return {
			Passport = Passport,
			yield = yield,
			balance = balance,
			transactions = transactions
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.TransactionHistory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Transactions(Passport, 50)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKDEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Deposit(amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil and parseInt(amount) > 0 then
		Active[Passport] = true

		if vRP.ConsultItem(Passport, "dollars", amount) and vRP.TakeItem(Passport, "dollars", amount) then
			vRP.GiveBank(Passport, amount)
		end

		Active[Passport] = nil
		local balance = vRP.Identity(Passport)["Bank"]
		local transactions = Transactions(Passport)

		return { balance = balance, transactions = transactions }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Withdraw(amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil and parseInt(amount) > 0 then
		Active[Passport] = true

		vRP.WithdrawCash(Passport, amount)

		Active[Passport] = nil
		local balance = vRP.Identity(Passport)["Bank"]
		local transactions = Transactions(Passport)

		return { balance = balance, transactions = transactions }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Transfer(ClosestPed, amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil and parseInt(amount) > 0 then
		Active[Passport] = true

		if vRP.Identity(ClosestPed) and vRP.PaymentBank(Passport, amount, true) then
			vRP.GiveBank(ClosestPed, amount)
		end

		Active[Passport] = nil
		local balance = vRP.Identity(Passport)["Bank"]
		local transactions = Transactions(Passport)

		return { balance = balance, transactions = transactions }
	end

	return false
end
----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTION
-----------------------------------------------------------------------------------------------------------------------------------------
function Transactions(Passport, Limit)
	local Passport = Passport
	local transactions = {}
	if not Limit then
		Limit = 4
	end

	local Result = vRP.Query("transactions/List",{ Passport = Passport, Limit = Limit })
	if Result[1] then
		for i, transaction in pairs(Result) do
			local type = transaction["Type"]
			local date = transaction["Date"]
			local value = transaction["Price"]
			local balance = transaction["Balance"]
			transactions[#transactions + 1] = {
				type = type,
				date = date,
				value = value,
				balance = balance
			}
		end
	end

	return transactions
end
----------------------------------------------------------------------------------------------------------------------------------------
-- FINES
-----------------------------------------------------------------------------------------------------------------------------------------
function Fines(Passport)
	local Passport = Passport
	local fines = {}
	local Result = vRP.Query("fines/List",{ Passport = Passport })
	if Result[1] then
		for i, row in pairs(Result) do
			fines[i] = {
				id = row["id"],
				name = row["Name"],
				value = row["Value"],
				date = row["Date"],
				hour = row["Hour"],
				message = row["Message"]
			}
		end
	end

	return fines
end
----------------------------------------------------------------------------------------------------------------------------------------
-- FINELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.FineList()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Fines(Passport)
	end
end
----------------------------------------------------------------------------------------------------------------------------------------
-- FINESPREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fines/Check","SELECT * FROM fines WHERE Passport = @Passport AND id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.FinePayment(id)
	local source = source
	local Passport = vRP.Passport(source)
	local id = id
	if Passport and Active[Passport] == nil then
		Active[Passport] = true
		local Result = vRP.Query("fines/Check",{ Passport = Passport, id = id })
		if Result[1] then
			if vRP.PaymentBank(Passport, Result[1]["Value"]) then
				vRP.Query("fines/Remove",{ Passport = Passport, id = id })
				vRP.RemoveFine(Passport, Result[1]["Value"])
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENTALL
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.FinePaymentAll()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil then
		Active[Passport] = true
		local Result = vRP.Query("fines/List",{ Passport = Passport })
		if Result[1] then
			for i, row in pairs(Result) do
				local id = row["id"]
				if vRP.PaymentBank(Passport, Result[1]["Value"]) then
					vRP.Query("fines/Remove",{ Passport = Passport, id = id })
					vRP.RemoveFine(Passport, Result[1]["Value"])
					Active[Passport] = nil

					return true
				end
			end
		end

		Active[Passport] = nil
	end

	return Fines(Passport)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXS
-----------------------------------------------------------------------------------------------------------------------------------------
function Taxs(Passport)
	local Passport = Passport
	local taxs = {}
	local Result = vRP.Query("taxs/List",{ Passport = Passport })
	if Result[1] then
		for i, tax in pairs(Result) do
			taxs[i] = {
				id = tax["id"],
				name = tax["Name"],
				value = tax["Value"],
				date = tax["Date"],
				hour = tax["Hour"],
				message = tax["Message"]
			}
		end
	end

	return taxs
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.TaxList()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Taxs(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.TaxPayment(id)
	local source = source
	local Passport = vRP.Passport(source)
	local id = id
	if Passport and Active[Passport] == nil then
		Active[Passport] = true
		local Result = vRP.Query("taxs/Check",{ Passport = Passport, id = id })
		if Result[1] then
			if vRP.PaymentBank(Passport, Result[1]["Value"]) then
				vRP.RemoveTax(Passport, Result[1]["Value"])
				vRP.Query("taxs/Remove",{ Passport = Passport, id = id })
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
function Invoices(Passport)
	local Passport = Passport
	local invoices = {}
	local Result = vRP.Query("invoices/List",{ Passport = Passport })
	if Result[1] then
		for i, invoice in pairs(Result) do
			if not invoices[invoice["Type"]] then
				invoices[invoice["Type"]] = {}
			end

			local id = invoice["id"]
			local reason = invoice["Reason"]
			local holder = invoice["Holder"]
			invoices[invoice["Type"]][#invoices[invoice["Type"]] + 1] = { id = id, reason = reason, holder = holder, value = invoice["Value"] }
		end
	end

	return invoices
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.InvoiceList()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Invoices(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.InvoicePayment(id)
	local source = source
	local Passport = vRP.Passport(source)
	local id = id
	if Passport and Active[Passport] == nil then
		Active[Passport] = true
		local Result = vRP.Query("invoices/Check",{ Passport = Passport, id = id })
		if Result[1] then
			if vRP.PaymentBank(Passport, Result[1]["Value"]) then
				vRP.Query("invoices/Remove",{ Passport = Passport, id = id })
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.MakeInvoice(OtherPassport, value, reason)
	local source = source
	local Passport = vRP.Passport(source)
	local OtherPassport = OtherPassport
	if Passport and not Active[Passport] and parseInt(value) > 0 then
		Active[Passport] = true
		local OtherSource = vRP.Source(OtherPassport)
		if OtherSource then
			if vRP.Request(OtherSource, "Banco", "<b>"..vRP.FullName(Passport).."</b> lhe enviou uma fatura de <b>R$"..parseFormat(value).."</b>, deseja aceita-la?") then
				local Received = OtherPassport
				local Type = "received"
				local Reason = reason
				local Holder = vRP.FullName(Passport)
				local Value = value
				vRP.Query("invoices/Add",{ Passport = OtherPassport, Received = Received, Type = Type, Reason = Reason, Holder = Holder, Value = Value })

				local Type = "sent"
				local Holder = "Você"
				vRP.Query("invoices/Add",{ Passport = Passport, Received = Received, Type = Type, Reason = Reason, Holder = Holder, Value = Value })

				return Invoices(Passport)
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Investments()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Investment = vRP.Query("investments/Check",{ Passport = Passport })
		if Investment[1] then
			local deposit = Investment[1]["Deposit"]
			local liquid = Investment[1]["Liquid"]
			local brute = deposit
			local total = deposit + liquid

			return {
				["deposit"] = deposit,
				["liquid"] = liquid,
				["brute"] = brute,
				["total"] = total
			}
		end

		return {
			["deposit"] = 0,
			["liquid"] = 0,
			["brute"] = 0,
			["total"] = 0
		}
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Invest(amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and parseInt(amount) > 0 then
		Active[Passport] = true

		if vRP.PaymentBank(Passport, amount) then
			local Investment = vRP.Query("investments/Check",{ Passport = Passport })
			if Investment[1] then
				local Value = amount
				vRP.Query("investments/Invest",{ Passport = Passport, Value = Value })
			else
				local Deposit = amount
				vRP.Query("investments/Add",{ Passport = Passport, Deposit = Deposit })
			end

			Active[Passport] = nil
			return true
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTRESCUE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.InvestRescue()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Investment = vRP.Query("investments/Check",{ Passport = Passport })
		if Investment[1] then
			vRP.Query("investments/Remove",{ Passport = Passport })
			vRP.GiveBank(Passport, Investment[1]["Deposit"] + Investment[1]["Liquid"])
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddTransactions", function(Passport, Type, Amount)
	if vRP.Identity(Passport) then
		local Passport = Passport
		local Type = Type
		local Date = os.date("%d/%m/%Y")
		local Price = Amount
		local Balance = vRP.Identity(Passport)["Bank"]
		vRP.Query("transactions/Add",{ Passport = Passport, Type = Type, Date = Date, Price = Price, Balance = Balance })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTAXS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddTaxs", function(Passport, Name, Value, Message)
	if vRP.Identity(Passport) then
		local Passport = Passport
		local Name = Name
		local Date = os.date("%d/%m/%Y")
		local Hour = os.date("%H:%M")
		local Value = Value
		local Message = Message
		vRP.Query("taxs/Add",{ Passport = Passport, Name = Name, Date = Date, Hour = Hour, Value = Value, Message = Message })

		vRP.GiveTax(Passport, Value)
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- ADDFINES
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddFines", function(Passport, OtherPassport, Value, Message)
	if vRP.Identity(Passport) then
		local Passport = Passport
		local Name = vRP.FullName(OtherPassport)
		local Date = os.date("%d/%m/%Y")
		local Hour = os.date("%H:%M")
		local Value = Value
		local Message = Message
		vRP.Query("fines/Add",{ Passport = OtherPassport, Name = Name, Date = Date, Hour = Hour, Value = Value, Message = Message })

		vRP.GiveFine(Passport, Value)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Taxs", Taxs)
exports("Fines", Fines)
exports("Invoices", Invoices)
exports("Transactions", Transactions)