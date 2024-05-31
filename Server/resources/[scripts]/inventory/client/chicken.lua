-----------------------------------------------------------------------------------------------------------------------------------------
-- QUICKFADEIN
-----------------------------------------------------------------------------------------------------------------------------------------
local function quickFadeIn()
	DoScreenFadeOut(1000)
	Wait(1000)
	DoScreenFadeIn(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAIKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local function chaikin(dest, points, iterations)
	local result = {}
	for i = 1, #points - 1 do
		result[#result + 1] = points[i]
		result[#result + 1] = vec3((points[i].x + points[i + 1].x) / 2, (points[i].y + points[i + 1].y) / 2, (points[i].z + points[i + 1].z) / 2)
	end

	result[#result + 1] = points[#points]

	if iterations > 1 then
		chaikin(dest, result, iterations - 1)
	else
		dest.points = result
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAW_CURVE
-----------------------------------------------------------------------------------------------------------------------------------------
local function draw_curve(points, particleDict, particleSet, scale, insertionTable)
	insertionTable = {}

	for i = 1, #points - 1 do
		local random_offset_x = math.random(-1, 1)
		local random_offset_y = math.random(-1, 2)
		local random_offset_z = math.random(-1, 2)
		local distance = math.sqrt(random_offset_x * random_offset_x + random_offset_y * random_offset_y)
		random_offset_x /= distance * 2
		random_offset_y /= distance * 2
		UseParticleFxAssetNextCall(particleDict)
		local fx = StartParticleFxLoopedAtCoord(particleSet, points[i].x + random_offset_x, points[i].y + random_offset_y, points[i].z + random_offset_z, 0.0, 0.0, 0.0, scale, false, false, false, false)
		table.insert(insertionTable, fx)
	end

	Wait(500)

	for i = 1, #insertionTable do StopParticleFxLooped(insertionTable[i], 0) end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHICKEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Chicken")
AddEventHandler("inventory:Chicken", function()
	local ply = PlayerPedId()
	local playerHeading = GetEntityHeading(ply)
	local chickenModelHash = `a_c_hen`
	local playerForward, playerRight, _, _ = GetEntityMatrix(ply)
	local PlaceObjectOnGroundOrObjectProperly = PlaceObjectOnGroundProperly_2
	local chickenParticles = {}
	local chickenPeds = {}
	local chickenFx = { dict = "core", particle = "ent_sht_feathers" }
	local chickenSpawnCoords = {
		playerForward = playerForward * 2.0,
		playerBackwards = playerForward * -2.0,
		playerLeft = playerRight * -2.0,
		playerRight = playerRight * 2.0
	}

	local chickenAnim = {
		dict = "anim@mp_player_intcelebrationfemale@chicken_taunt",
		anim = "chicken_taunt"
	}

	LoadModel(chickenModelHash)
	LoadAnim(chickenAnim.dict)
	LoadPtfxAsset(chickenFx.dict)

	local pedCoords = GetEntityCoords(ply)
	if not IsEntityPlayingAnim(ply, chickenAnim.dict, chickenAnim.anim, 3) then
		TaskPlayAnim(ply, chickenAnim.dict, chickenAnim.anim, 8.0, 8.0, -1, 1, 0, false, false, false)
	end

	Wait(3000)

	StopAnimTask(ply, chickenAnim.dict, chickenAnim.anim, 3.0)

	quickFadeIn()

	for _ = 1, 5 do
		for _, value in pairs(chickenSpawnCoords) do
			local spawnCoords = pedCoords + value
			table.insert(chickenPeds, CreatePed(29, chickenModelHash, spawnCoords, playerHeading, false, false, false))

			local chickenPed = chickenPeds[#chickenPeds]
			PlaceObjectOnGroundOrObjectProperly(chickenPed)
			SetPtfxAssetNextCall(chickenFx.dict)
			table.insert(chickenParticles, StartParticleFxLoopedOnEntity(chickenFx.particle, chickenPed, vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), 4.0, false, false, false))
		end
	end

	local cooldown = GetGameTimer() + (30 * 1000)
	CreateThread(function()
		while GetGameTimer() < cooldown do
			for i = 1, #chickenPeds do
				local chickenPed = chickenPeds[i]
				if DoesEntityExist(chickenPed) then
					TaskGoToEntity(chickenPed, ply, -1, 1.0, 2.0, 0, 0)
				end
			end

			local curve = {}
			local playerCoords = GetEntityCoords(ply)
			playerForward = GetEntityForwardVector(ply)
			chaikin(curve, { playerCoords, playerCoords + playerForward }, 4)
			draw_curve(curve.points, chickenFx.dict, chickenFx.particle, 3.0)
			Wait(1000)
		end

		for i = 1, #chickenPeds do
			local chickenPed = chickenPeds[i]
			if DoesEntityExist(chickenPed) then
				SetEntityAsNoLongerNeeded(chickenPed)
				DeleteEntity(chickenPed)
				chickenPeds[i] = nil
			end
		end
	end)

	while #chickenPeds > 1 do Wait(100) end
	if not IsEntityPlayingAnim(ply, chickenAnim.dict, chickenAnim.anim, 3) then
		TaskPlayAnim(ply, chickenAnim.dict, chickenAnim.anim, 8.0, 8.0, -1, 1, 0, false, false, false)
	end

	Wait(3000)

	StopAnimTask(ply, chickenAnim.dict, chickenAnim.anim, 3.0)
	quickFadeIn()
end)