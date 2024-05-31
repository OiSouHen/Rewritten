-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Displayed = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPUTTARGETPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function InputTargetPosition(Number,v)
	if v["Model"] == "prop_money_bag_01" then
		exports["target"]:AddBoxZone("Farmer:"..Number,v["Coords"],v["Width"],v["Width"],{
			name = "Farmer:"..Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"],
			maxZ = v["Coords"]["z"] + 0.50
		},{
			shop = Number,
			Distance = v["Distance"],
			options = {
				{
					event = v["Event"],
					label = v["Label"],
					tunnel = "server"
				}
			}
		})
	else
		exports["target"]:AddCircleZone("Farmer:"..Number,v["Coords"],v["Width"],{
			name = "Farmer:"..Number,
			heading = v["Heading"]
		},{
			shop = Number,
			Distance = v["Distance"],
			options = {
				{
					event = v["Event"],
					label = v["Label"],
					tunnel = "server"
				}
			}
		})
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number,v in pairs(Objects) do
			if #(Coords - v["Coords"]) <= v["Show"] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
				if not Displayed[Number] and LoadModel(GlobalState["FarmerObjects:"..Number]) then
					Displayed[Number] = CreateObjectNoOffset(GlobalState["FarmerObjects:"..Number],v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"] - v["Height"],false,false,false)
					SetEntityHeading(Displayed[Number],v["Heading"])
					FreezeEntityPosition(Displayed[Number],true)
					SetModelAsNoLongerNeeded(v["Model"])
					InputTargetPosition(Number,v)
				end
			else
				if Displayed[Number] then
					if DoesEntityExist(Displayed[Number]) then
						DeleteEntity(Displayed[Number])
					end

					exports["target"]:RemCircleZone("Farmer:"..Number)
					Displayed[Number] = nil
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
for Number = 1,#Objects do
	AddStateBagChangeHandler("Farmer:"..Number,nil,function(Name,Key,Value)
		if Displayed[Number] then
			if DoesEntityExist(Displayed[Number]) then
				DeleteEntity(Displayed[Number])
			end

			exports["target"]:RemCircleZone("Farmer:"..Number)
			Displayed[Number] = nil
		end
	end)
end