-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Packages = 0
local InService = false
local InPackage = false
local HandPackage = false
local BoxVehiclesClient = {}
local InitPackage = { -492.01, -2905.76, 6.2 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- NAMES
-----------------------------------------------------------------------------------------------------------------------------------------
local Name = { "James", "John", "Robert", "Michael", "William", "David", "Richard", "Charles", "Joseph", "Thomas", "Christopher", "Daniel", "Paul", "Mark", "Donald", "George", "Kenneth", "Steven", "Edward", "Brian", "Ronald", "Anthony", "Kevin", "Jason", "Matthew", "Gary", "Timothy", "Jose", "Larry", "Jeffrey", "Frank", "Scott", "Eric", "Stephen", "Andrew", "Raymond", "Gregory", "Joshua", "Jerry", "Dennis", "Walter", "Patrick", "Peter", "Harold", "Douglas", "Henry", "Carl", "Arthur", "Ryan", "Roger", "Joe", "Juan", "Jack", "Albert", "Jonathan", "Justin", "Terry", "Gerald", "Keith", "Samuel", "Willie", "Ralph", "Lawrence", "Nicholas", "Roy", "Benjamin", "Bruce", "Brandon", "Adam", "Harry", "Fred", "Wayne", "Billy", "Steve", "Louis", "Jeremy", "Aaron", "Randy", "Howard", "Eugene", "Carlos", "Russell", "Bobby", "Victor", "Martin", "Ernest", "Phillip", "Todd", "Jesse", "Craig", "Alan", "Shawn", "Clarence", "Sean", "Philip", "Chris", "Johnny", "Earl", "Jimmy", "Antonio", "Mary", "Patricia", "Linda", "Barbara", "Elizabeth", "Jennifer", "Maria", "Susan", "Margaret", "Dorothy", "Lisa", "Nancy", "Karen", "Betty", "Helen", "Sandra", "Donna", "Carol", "Ruth", "Sharon", "Michelle", "Laura", "Sarah", "Kimberly", "Deborah", "Jessica", "Shirley", "Cynthia", "Angela", "Melissa", "Brenda", "Amy", "Anna", "Rebecca", "Virginia", "Kathleen", "Pamela", "Martha", "Debra", "Amanda", "Stephanie", "Carolyn", "Christine", "Marie", "Janet", "Catherine", "Frances", "Ann", "Joyce", "Diane", "Alice", "Julie", "Heather", "Teresa", "Doris", "Gloria", "Evelyn", "Jean", "Cheryl", "Mildred", "Katherine", "Joan", "Ashley", "Judith", "Rose", "Janice", "Kelly", "Nicole", "Judy", "Christina", "Kathy", "Theresa", "Beverly", "Denise", "Tammy", "Irene", "Jane", "Lori", "Rachel", "Marilyn", "Andrea", "Kathryn", "Louise", "Sara", "Anne", "Jacqueline", "Wanda", "Bonnie", "Julia", "Ruby", "Lois", "Tina", "Phyllis", "Norma", "Paula", "Diana", "Annie", "Lillian", "Emily", "Robin" }
local Lastname = { "Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson", "Clark", "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Young", "Hernandez", "King", "Wright", "Lopez", "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell", "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins", "Stewart", "Sanchez", "Morris", "Rogers", "Reed", "Cook", "Morgan", "Bell", "Murphy", "Bailey", "Rivera", "Cooper", "Richardson", "Cox", "Howard", "Ward", "Torres", "Peterson", "Gray", "Ramirez", "James", "Watson", "Brooks", "Kelly", "Sanders", "Price", "Bennett", "Wood", "Barnes", "Ross", "Henderson", "Coleman", "Jenkins", "Perry", "Powell", "Long", "Patterson", "Hughes", "Flores", "Washington", "Butler", "Simmons", "Foster", "Gonzales", "Bryant", "Alexander", "Russell", "Griffin", "Diaz", "Hayes" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 500
		local Ped = PlayerPedId()

		if InService then
			if not IsPedInAnyVehicle(Ped) then
				local Vehicle = getNearVehicle(11)
				local Coords = GetEntityCoords(Ped)

				if DoesEntityExist(Vehicle) and GetEntityModel(Vehicle) == GetHashKey("boxville4") then
					local CoordsVeh = GetOffsetFromEntityInWorldCoords(Vehicle,0.0,-3.5,0.0)
					local Distance = #(Coords - CoordsVeh)
					if Distance <= 1.2 then
						TimeDistance = 4

						local Plate = GetVehicleNumberPlateText(Vehicle)

						if InPackage then
							if BoxVehiclesClient[Plate] == nil then
								PostOpDrawText3D(CoordsVeh["x"], CoordsVeh["y"], CoordsVeh["z"],"~g~E~w~   GUARDAR ENCOMENDA\nTOTAL DE ENCOMENDAS:  0/"..MaximumPackages,550,0.0225,0.06)
							else
								PostOpDrawText3D(CoordsVeh["x"], CoordsVeh["y"], CoordsVeh["z"],"~g~E~w~   GUARDAR ENCOMENDA\nTOTAL DE ENCOMENDAS:  "..BoxVehiclesClient[Plate].."/"..MaximumPackages,550,0.0225,0.06)
							end

							if IsControlJustPressed(1,38) and vSERVER.PutPackage(Plate) then
								InPackage = false
								HandPackage = false
								vRP.Destroy("one")
							end
						else
							if BoxVehiclesClient[Plate] == nil then
								PostOpDrawText3D(CoordsVeh["x"], CoordsVeh["y"], CoordsVeh["z"],"~g~E~w~   RETIRAR ENCOMENDA\nTOTAL DE ENCOMENDAS:  0/"..MaximumPackages,550,0.0225,0.06)
							else
								PostOpDrawText3D(CoordsVeh["x"], CoordsVeh["y"], CoordsVeh["z"],"~g~E~w~   RETIRAR ENCOMENDA\nTOTAL DE ENCOMENDAS:  "..BoxVehiclesClient[Plate].."/"..MaximumPackages,550,0.0225,0.06)
							end

							if IsControlJustPressed(1,38) and BoxVehiclesClient[Plate] then
								if BoxVehiclesClient[Plate] > 0 then
									InPackage = true
									HandPackage = true
									TriggerServerEvent("postop:RemovePackage", Plate)
									vRP.CreateObjects("anim@heists@box_carry@", "idle","hei_prop_heist_box", 50, 28422)
								end
							end
						end
					end
				end

				local Distance = #(Coords - vec3(InitPackage[1], InitPackage[2], InitPackage[3]))
				if Distance <= 10.0 then
					TimeDistance = 4

					if InPackage then
						PostOpDrawText3D(InitPackage[1], InitPackage[2], InitPackage[3],"~g~E~w~   GUARDAR ENCOMENDA",350,0.0125,0.03)
					else
						PostOpDrawText3D(InitPackage[1], InitPackage[2], InitPackage[3],"~g~E~w~   RETIRAR ENCOMENDA",350,0.0125,0.03)
					end

					if Distance <= 1 and IsControlJustPressed(1,38) then
						if InPackage then
							InPackage = false
							vRP.Destroy("one")
							LocalPlayer["state"]["Block"] = false
						else
							InPackage = true
							LocalPlayer["state"]["Block"] = true
							vRP.CreateObjects("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
						end
					end
				end

				local Distance = #(Coords - vec3(DeliveryCoords[Packages][1], DeliveryCoords[Packages][2], DeliveryCoords[Packages][3]))
				if Distance <= 25.0 then
					TimeDistance = 4

					PostOpDrawText3D(DeliveryCoords[Packages][1], DeliveryCoords[Packages][2], DeliveryCoords[Packages][3],"~g~G~w~   ENTREGAR ENCOMENDA",350,0.0125,0.03)
					if Distance <= 1.0 and IsControlJustPressed(1,47) and HandPackage then
						InPackage = false
						HandPackage = false

						vSERVER.PaymentPostOp()

						vRP.Destroy("one")
						TriggerEvent("postop:InitDelivery")
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 500
		if InPackage then
			TimeDistance = 4

			DisableControlAction(1, 245, true)
			DisableControlAction(1, 167, true)
			DisableControlAction(1, 21, true)
			DisableControlAction(1, 22, true)
			DisableControlAction(1, 23, true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:POSTOPINIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:PostOpInit")
AddEventHandler("inventory:PostOpInit",function()
	if vSERVER.CheckWork("PostOp") then
		if InService then
			exports["target"]:LabelText("WorkPostOp", "Trabalhar")
			TriggerEvent("Notify", "amarelo","Trabalho finalizado.", "Atenção", 5000)
			InService = false
		else
			exports["target"]:LabelText("WorkPostOp","Finalizar")
			TriggerEvent("Notify", "verde", "Trabalho iniciado.", "Sucesso", 5000)
			InService = true
			TriggerEvent("postop:InitDelivery")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSTOPUPDATEPACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:PostOpUpdatePackage")
AddEventHandler("inventory:PostOpUpdatePackage",function(Status)
	BoxVehiclesClient = Status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITDELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("postop:InitDelivery")
AddEventHandler("postop:InitDelivery",function()
	Packages = math.random(#DeliveryCoords)
	Nameckage = Name[math.random(#Name)].." "..Lastname[math.random(#Lastname)]

	TriggerEvent("NotifyPush",{ code = 20, title = "Entrega de Encomenda", text = "Preciso de você aqui para entregar uma encomenda.", x = DeliveryCoords[Packages][1], y = DeliveryCoords[Packages][2], z = DeliveryCoords[Packages][3], name = Nameckage, blipColor = 2 })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSTOPDRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function PostOpDrawText3D(x, y, z, text, h, g, f)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	SetTextFont(4)
	SetTextScale(0.35, 0.35)
	SetTextColour(255, 255, 255, 150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / h
	DrawRect(_x, _y + g, 0.01 + factor, f, 0, 0, 0, 100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNEARVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function getNearVehicles(Radius)
	local r = {}
	local Coords = GetEntityCoords(PlayerPedId())

	local vehs = {}
	local it,veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end

	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok

	EndFindVehicle(it)

	for _,veh in pairs(vehs) do
		local CoordsVeh = GetEntityCoords(veh)
		local Distance = #(Coords - CoordsVeh)
		if Distance <= Radius then
			r[veh] = Distance
		end
	end

	return r
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNEARVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function getNearVehicle(Radius)
	local veh
	local vehs = getNearVehicles(Radius)
	local min = Radius + 0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end

	return veh 
end